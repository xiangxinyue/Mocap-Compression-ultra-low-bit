
from PIL import Image
# from PIL import GifImagePlugin
import cv2
import numpy as np
import os

#root_dir = os.path.dirname('/Users/apple/Desktop/414project/')

input_video = Image.open("./walking.gif")
frame_length = input_video.n_frames


def track_position_per_frame(f_num):
	image = cv2.imread('./walking_frames/frame{}.png'.format(f_num), cv2.IMREAD_UNCHANGED) 
	#make mask of where the transparent bits are
	bg_mask = image[:,:,3] == 0
	fg_mask = image[:,:,3] != 0

	#replace areas of transparency with black and not transparent with white
	image[bg_mask] = [0, 0, 0, 0] #black
	image[fg_mask] = [255,255,255, 255] #white

	#new image without alpha channel...
	img = cv2.cvtColor(image, cv2.COLOR_BGRA2BGR)
	white_ = [255,255,255]
	#zipped = np.argwhere(img == white_)[0]
	zipped_coordinates = np.argwhere(np.all(img == white_,axis =2))
	#current_position['YX'] = zipped_coordinates[0]
	current_position = (zipped_coordinates[-1].tolist())
	current_position = [i * 3 for i in current_position]
	current_position[0],current_position[1] = current_position[1],current_position[0]

	return current_position

# remain to be changed
def draw_points(img, current_position):
	# img = cv2.circle(img, (top_X,top_Y), radius=4, color=(0, 0, 255), thickness=-1)
	new_img =cv2.circle(img, (current_position[1],current_position[0]), radius=4, color=(0, 0, 255), thickness=-1)
	cv2.imshow('foot position',new_img)
	cv2.waitKey()


def main(frame_length):
	input_video = Image.open("./walking.gif")
	frame_length = input_video.n_frames
	motion_trail = []
	cut_frames = list(range(0, frame_length, 15))
	for i in cut_frames:
		input_video.seek(i)
		input_video.save('./walking_frames/frame{}.png'.format(i))		
		motion_trail.append(track_position_per_frame(i))
	print(motion_trail)
	with open("2d_coordinates.txt", 'w') as file:
		for row in motion_trail:
			s = " ".join(map(str, row))
			file.write(s+'\n')
		
if __name__ == '__main__':
    main(frame_length)
