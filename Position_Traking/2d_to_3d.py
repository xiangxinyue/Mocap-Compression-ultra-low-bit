import cv2
import math
import numpy as np
import matplotlib.pyplot as plt
from skimage import data
from skimage import transform
from skimage import io, color

def mp4_to_frames(file_path):
	vc = cv2.VideoCapture('IMG_0932.mp4')
	c=1

	if vc.isOpened():
		rval , frame = vc.read()
	else:
		rval = False

	while rval:
		rval, frame = vc.read()
		cv2.imwrite(file_path + str(c) + '.jpg', frame)
		c = c + 1
		cv2.waitKey(1)
	vc.release()
def read_foot_coordinates(coordinates_file):
	with open(coordinates_file) as f:
		positions2d = []
		for line in f:
			line = line.split()
			if line: 
				line = [int(i) for i in line]
				positions2d.append(line)
		f.close()
	print(positions2d)
	return positions2d

def unwarp(img, src, dst,positions2d, testing):
    h, w = img.shape[:2]
    # use cv2.getPerspectiveTransform() to get M, the transform matrix, and Minv, the inverse
    M = cv2.getPerspectiveTransform(src, dst)
    print(M)
    
    # use cv2.warpPerspective() to warp your image to a top-down view
    warped = cv2.warpPerspective(img, M, (w, h), flags=cv2.INTER_LINEAR)

    if testing:
        f, (ax1, ax2) = plt.subplots(1, 2, figsize=(20, 10))
        f.subplots_adjust(hspace=.2, wspace=.05)
        ax1.imshow(img)
        #to draw the shape of the lounge
        x = [src[0][0], src[2][0], src[3][0], src[1][0], src[0][0]]
        y = [src[0][1], src[2][1], src[3][1], src[1][1], src[0][1]]
        x_ = [dst[0][0], dst[2][0], dst[3][0], dst[1][0], dst[0][0]]
        y_ = [dst[0][1], dst[2][1], dst[3][1], dst[1][1], dst[0][1]]

        foot_x = [row[0] for row in positions2d]
        foot_y = [row[1] for row in positions2d]
        positions2d = np.array([np.float32(positions2d)])
        
        real_coordinates = cv2.perspectiveTransform(positions2d, M)
        real_coordinates = real_coordinates.reshape(17,2)
        real_x = [row[0] for row in real_coordinates]
        real_y = [row[1] for row in real_coordinates]
        ax1.plot(x, y, color='red', alpha=0.4, linewidth=1, solid_capstyle='round', zorder=2)
        ax1.scatter(foot_x,foot_y,color='red', s=2**2)
        ax1.set_ylim([h, 0])
        ax1.set_xlim([0, w])
        ax1.set_title('Original Image', fontsize=10)
        ax2.plot(x_, y_, color='red', alpha=0.4, linewidth=1, solid_capstyle='round', zorder=2)
        ax2.scatter(real_x,real_y,color='red', s=2**2)
        ax2.imshow(cv2.flip(warped, 1))
        ax2.set_title('Remove Perespective', fontsize=10) 
        plt.show()         
    else:
        return warped, M, real_coordinates



def main():
	img = cv2.imread("30.JPG")
	#img = cv2.cvtColor(np.array(img), cv2.COLOR_BGR2GRAY)
	positions2d =read_foot_coordinates('2d_coordinates.txt')
	#first manually select the source points 
	# we will select the destination point which will map the source points in
	# original image to destination points in unwarped image
	dst = np.float32([(335,1660),(745,1660),(335,0),(745,0)])
	src = np.float32([(135,1920),(966,1920),(409,1320),(689,1320)])
	unwarp(img, src, dst,positions2d, True)


if __name__ == '__main__':
    main()
