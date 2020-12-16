import read_amc
import numpy as np
import matplotlib.pyplot as plt

def plot_curve_of_joints(input_amc,joint_order):
	the_joint1 = joint_order[21]
	the_joint2 = joint_order[22]
	the_joint3 = joint_order[23]

	clip1 = input_amc.get_trajectory_all_dof(the_joint1)
	clip2 = input_amc.get_trajectory_all_dof(the_joint2)
	clip3 = input_amc.get_trajectory_all_dof(the_joint3)

	frame_num = list(range(1,len(clip1)+1))

	x_ = clip1[...,0].tolist()
	y_ = clip2[...,0].tolist()
	z_ = clip3[...,0].tolist()
	plt.plot(frame_num, x_,label = "rfemur")
	plt.plot(frame_num, y_,label = "rtibia") 
	plt.plot(frame_num, z_,label = "rfoot")
	plt.xlabel('Frame Number')
	plt.ylabel('degrees')
	plt.title('Right leg of rotation on X axis of running')




def plot_curve_of_specific_joint(input_amc,joint_order):
	the_joint = joint_order[21]
	clip = input_amc.get_trajectory_all_dof(the_joint)
	frame_num = list(range(1,len(clip)+1))
	x_ = clip[...,0].tolist()
	y_ = clip[...,1].tolist()
	z_ = clip[...,2].tolist()
	plt.plot(frame_num, x_,label = "x_axis")
	plt.plot(frame_num, y_,label = "y_axis")  
	plt.plot(frame_num, z_,label = "z_axis")
	plt.title('Right Femur curve')


if __name__ == "__main__":
	input_amc = read_amc.Animation("09_06-run.amc")
	joint_order = input_amc.get_joint_order()
	plot_curve_of_joints(input_amc,joint_order)
	# plot_curve_of_specific_joint(input_amc,joint_order)
	plt.legend() 
	plt.show()




