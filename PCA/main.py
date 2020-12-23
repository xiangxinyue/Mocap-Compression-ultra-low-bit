import numpy as np
from sklearn.decomposition import PCA
import bezier

# Ref: https://scikit-learn.org/stable/modules/generated/sklearn.decomposition.PCA.html

# Class Animation
# description:    This class creates an instance for given amc file, that able to cut amc into frames, group frames into several clips
# Parameters:
#     file_path:  path of amc file to be used
# Attribute:
#     self.amc_file   instance of opened amc file
#     self.framewise_database   Numpy array object, stores Frame type object that contains information in each frame
# Methods:
#     self.read_frame():  use given amc file to create framewise_dtabase attribute
#     self.get_trajectory_all_dof(joint_name):    given joint name, returns all dof trajectory for that joint through all frames
#     self.get_trajectory_specific_dof(joint_name, dof):  partial self.get_trajectory_all_dof(), that only returns specific dof values
#     self.get_trajectory_all_dof_cut_by_k(joint_name, k):    split return values from self.get_trajectory_all_dof() into k clips
#     self.get_trajectory_specific_dof_cut_by_k(joint_name, dof, k):  partial self.get_trajectory_all_dof_cut_by_k(), that only returns specific dof values with k clips
#     self.get_joint_dof_number(joint_name):  given joint name, returns the index order of the joint in any frame
#     self.get_joint_order(): returns a list that preserves the order of each joint being stored in amc file
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

# Frame class
# Description: This is a helper class for Animation class, split joint and its dof into attributes for Animation class use
# Parameters:
#     list_data   List element, that contains all joint name and corresponding DOF value in one frame
# Attributes:
#     self.frame_dict(dictionary)  key:joint name;  value: DOF values
#     self.joint_order(list)   states joint name preserving its order in frame
# Method:
#     self.Anaysis()   This method will analyze and parse the information in the frame to above two attributes
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



# Description: This function takes a clip that contains 10 frames of trasformation matrix value for current joint, and
#              put into bezier curve and operating curve fitting technic using at least 4 control points so that can predict
#              other points' value

def curve_fitting(clip):
    threashold = 2
    index_set = [0.,0,1111,0.2222,0.3333,0.4444,0.5555,0.6666,0.7777,0.8888,0.9999]
    valid = False

    frame = np.array([0, 0.3333, 0.6666, 0.9999])

    cp1, cp2, cp3, cp4 = clip[0], clip[3], clip[6], clip[9]
    control_points = [cp1,cp2,cp3,cp4]


    while not valid:
        # print(frame.shape,len(control_points))
        # print(control_points)
        nodes = np.asfortranarray([frame,control_points])
        curve = bezier.Curve.from_nodes(nodes)

        for i in range(10):
            sample = clip[i]
            pred = curve.evaluate(float(index_set[i]))

            if threashold < abs(sample-pred[1]):
                frame = np.append(frame,index_set[i])
                control_points.append(clip[i])
                continue
        valid = True

    return frame,control_points

# Description: since the target list object contains numpy values, it cannot directly convert to string object,
#               This function is to convert such list into one single string object and return it
def to_str(lst):
    lit = ''
    for item in lst:
        lit += str(item)
        lit+=' '
    return lit


if __name__ == "__main__":
    # To compress run.amc, replace matched_walk.amc to matched_run.amc
    walk_amc = Animation("matched_run.amc")
    joint_order = walk_amc.get_joint_order()

    clip_size = len(walk_amc.framewise_database)
    print(clip_size)
    b_file = open('bezier.txt','w') # file used to store our designed compression result
    p_file = open('pca.txt','w')    # file used to store only pca compression method for further comparision needs
    mse = 0
    count = 0
    # loop for each joint in the amc file
    for i in range(29):
        clip = walk_amc.get_trajectory_all_dof_cut_by_k(joint_order[i], clip_size)  # cut into clips

        # class sklearn.decomposition.PCA(n_components=None, *, copy=True, whiten=False, svd_solver='auto', tol=0.0, iterated_power='auto', random_state=None)[source]¶
        pca = PCA(n_components=0.95)    # apply PCA to reduce dimension for each clip

        for j in range(clip.shape[0]):  # no sense loop, it does nothing at all
            c = clip[j]
            pca.fit(c)

            # explained_variance_ratio_array, shape (n_components,)
            # Percentage of variance explained by each of the selected components.
            # If n_components is not set then all components are stored and the sum of the ratios is equal to 1.0.

            #print(pca.explained_variance_ratio_)

            # explained_variance_array, shape (n_components,) 
            # The amount of variance explained by each of the selected components.
            # Equal to n_components largest eigenvalues of the covariance matrix of X.
            #print(pca.explained_variance_)

            # n_componentsint, float, None or str
            # Number of components to keep



            # components_array, shape (n_components, n_features)
            # Principal axes in feature space, representing the directions of maximum variance in the data. 
            # The components are sorted by explained_variance_.\
            #print(pca.components_)

            new_x = pca.fit_transform(c)
            p_file.write(np.array2string(new_x))

            for channel in range(len(new_x[0])):
                # sets contains 36 subset, each contains 10 frames
                subset = clip_size/10
                sets = np.split(new_x[:,channel],subset)
                for clip in sets:   # each clip has 10 frames
                    frame, cp = curve_fitting(clip)
                    b_file.write(to_str(cp))

            x = pca.inverse_transform(new_x)

            # mean_array, shape (n_features,)
            # Per-feature empirical mean, estimated from the training set.
            # Equal to X.mean(axis=0).
            error = np.mean((x - c)**2)
            mse+=error
            count+=1
            #print(error)

    b_file.close()
    p_file.close()
    print(mse/count)
