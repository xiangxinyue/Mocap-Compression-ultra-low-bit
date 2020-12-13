import numpy as np
from sklearn.decomposition import PCA


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


# if __name__ == "__main__":
#     walk_amc = Animation("02_01.amc")
#     clip_size = 32
#     joint_order = walk_amc.get_joint_order()
#     for joint in joint_order:
#         dof_number = walk_amc.get_joint_dof_number(joint)
#         for dof in range(dof_number):
#             clip_for_single_dof = walk_amc.get_trajectory_specific_dof_cut_by_k(
#                 joint, dof, clip_size)
#             print(clip_for_single_dof)

if __name__ == "__main__":
    walk_amc = Animation("02_01.amc")
    joint_order = walk_amc.get_joint_order()
    root = joint_order[0]
    clip_size = 32
    clip = walk_amc.get_trajectory_all_dof_cut_by_k(root, clip_size)
    print(clip.shape)
    pca = PCA(n_components=0.95)
    for i in range(clip.shape[0]):
        c = clip[i]
        pca.fit(c)
        print(c.shape)
        print(pca.explained_variance_ratio_)
        print(pca.explained_variance_)
        print(pca.n_components_)
        print(pca.components_)
        new_x = pca.fit_transform(c)
        x = pca.inverse_transform(new_x)
        print(new_x)
        # print(x)
        error = np.mean((x - c)**2)
        print(error)
