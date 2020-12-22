import numpy as np
from sklearn.decomposition import PCA
# Ref: https://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html

# the class of animation deal with the movements
class Animation():                                 
    def __init__(self, file_path):
        self.amc_file = open(file_path, mode='r')
        self.framewise_database = []
        self.read_frame()
        self.framewise_database = np.array(self.framewise_database)

    def read_frame(self):
        frame_data = []
        with self.amc_file as f:
            amc_lines = f.readlines()
            for line in amc_lines:
                try:
                    int(line)
                except:
                    frame_data.append(line)
                else:
                    current_frame = int(line) - 1
                    if len(frame_data) == 29:
                        frame_info = Frame(frame_data)
                        self.framewise_database.append(
                            [current_frame, frame_info])
                    frame_data = []
            self.framewise_database.append(
                [current_frame + 1, Frame(frame_data)])

    def get_trajectory_all_dof(self, joint_name):
        all_frames = self.framewise_database[:, 1]
        all_movements = np.array(
            list(map(lambda x: x.frame_dict[joint_name], all_frames)))
        return all_movements

    def get_trajectory_specific_dof(self, joint_name, dof):
        all_movements = self.get_trajectory_all_dof(joint_name)
        specific_dof = all_movements[:, dof]
        return specific_dof

    def get_trajectory_all_dof_cut_by_k(self, joint_name, k):
        all_movements = self.get_trajectory_all_dof(joint_name)
        movement_length = all_movements.shape[0]
        num_of_dof = all_movements.shape[1]
        num_clips = int(np.floor(movement_length / k))
        movements_ready = all_movements[0: num_clips * k]
        movements_ready = np.reshape(
            movements_ready, (num_clips, k, num_of_dof))
        return movements_ready

    def get_trajectory_specific_dof_cut_by_k(self, joint_name, dof, k):
        movements_ready = self.get_trajectory_all_dof_cut_by_k(joint_name, k)
        specific_dof_data = movements_ready[:, :, dof]
        return specific_dof_data

    def get_joint_dof_number(self, joint_name):
        one_frame = self.framewise_database[0, 1]
        dof_info = one_frame.frame_dict[joint_name]
        dof_number = dof_info.shape[0]
        return dof_number

    def get_joint_order(self):
        one_frame = self.framewise_database[0, 1]
        return one_frame.joint_order

# the class of frame to deal with the joint order things using dictonary and 
# numpy array as well as the list format tranformation
class Frame():
    def __init__(self, list_data):
        self.list_data = np.array(list_data)
        self.frame_dict = {}
        self.joint_order = []
        self.analysis()

    def analysis(self):
        for joint in self.list_data:
            joint = joint.strip('\n')
            split_line = joint.split(" ")
            split_line = np.array(split_line)
            joint_name = split_line[0]
            joint_dof = split_line[1:].astype(np.float32)
            self.joint_order.append(joint_name)
            self.frame_dict[joint_name] = joint_dof



if __name__ == "__main__":
    walk_amc = Animation("modify.amc")
    joint_order = walk_amc.get_joint_order()

    # list all the 29 joints by the index
    root = joint_order[0]
    lowerback = joint_order[1]
    upperback = joint_order[2]
    thorax = joint_order[3]
    lowerneck = joint_order[4]
    upperneck = joint_order[5]
    head = joint_order[6]
    rclavicle = joint_order[7]
    rhumerus = joint_order[8]
    rradius = joint_order[9]
    rwrist = joint_order[10]
    rhand = joint_order[11]
    rfingers = joint_order[12]
    rthumb = joint_order[13]
    lclavicle = joint_order[14]
    lhumerus = joint_order[15]
    lradius = joint_order[16]
    lwrist = joint_order[17]
    lhand = joint_order[18]
    lfingers = joint_order[19]
    lthumb = joint_order[20]
    rfemur = joint_order[21]
    rtibia = joint_order[22]
    rfoot = joint_order[23]
    rtoes = joint_order[24]
    lfemur = joint_order[25]
    ltibia = joint_order[26]
    lfoot = joint_order[27]
    ltoes = joint_order[28]

    clip_size = 360
    i = 0 
    for i in range(29):
        clip = walk_amc.get_trajectory_all_dof_cut_by_k(joint_order[i], clip_size)
        print(clip.shape)

        # class sklearn.decomposition.PCA(n_components=None, *, copy=True, whiten=False, svd_solver='auto', tol=0.0, iterated_power='auto', random_state=None)[source]¶
        pca = PCA(n_components=0.95)

        for i in range(clip.shape[0]):
            c = clip[i]
            pca.fit(c)
            print(c.shape)

            #explained_variance_ratio_array, shape (n_components,)
            # Percentage of variance explained by each of the selected components.
            # If n_components is not set then all components are stored and the sum of the ratios is equal to 1.0.
            print(pca.explained_variance_ratio_)

            # explained_variance_array, shape (n_components,) 
            # The amount of variance explained by each of the selected components.
            # Equal to n_components largest eigenvalues of the covariance matrix of X.
            print(pca.explained_variance_)

            # n_componentsint, float, None or str
            # Number of components to keep
            print(pca.n_components_)

            #components_array, shape (n_components, n_features)
            # Principal axes in feature space, representing the directions of maximum variance in the data. 
            # The components are sorted by explained_variance_.
            print(pca.components_)
            new_x = pca.fit_transform(c)
            x = pca.inverse_transform(new_x)
            print(new_x)

            # mean_array, shape (n_features,)
            # Per-feature empirical mean, estimated from the training set.
            # Equal to X.mean(axis=0).
            error = np.mean((x - c)**2)
            print(error)
