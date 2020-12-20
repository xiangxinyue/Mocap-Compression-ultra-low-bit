import math


# f = open('short_run.amc','r')
# data = f.readlines()
# for line in data:
#     try:
#         int(line)
#     except:
#         pass
#     else:
#         print(line, end='')
#     temp = line.split()
#     if temp[0] == 'root':
#         print(temp[0], temp[3], end='\n')
#         print()
# f.close()

# By using above code to get stride length range in Mocap representation is ( -40.3324 , -14.6831 ), ( -30.6689 , 16.2002 ) for running
# So the length in Mocap representation is  ** 25.6493 **
# multiply by scalar ** 0.056444 **         from http://mocap.cs.cmu.edu/faqs.php
# to get the real world length in Meter

# ******  Walking Stride Length = 1.448 Meter  ****** #
# ******  Running Stride Length =  2.645Meter  ****** #

# From Video, walked 5 steps, approximate 3.25 meters

# ********************* PARAMETERS ************************* #
mocap_scalar = 1 / 0.056444
stride_length = 1.4
walk_stride = 2.5
pixel_length = (1000, 1660)
real_length = stride_length * walk_stride
y_ratio = real_length / pixel_length[1]
x_ratio = y_ratio / pixel_length[0]
# ********************* PARAMETERS ************************* #


def generator(root, x, y, direction):
    root = root.split()
    root[3] = round(y,4)
    root[1] = round(x,4)
    root[5] = round(direction,4)
    for i in range(len(root)):
        root[i] = str(root[i])

    root = ' '.join(root)
    return root

def get_coor(root):
    root = root.split()
    return root[1], root[3]


def one_stride(f2,f3):
    for i in range(3):
        f3.write(f2.readline())

    short_sample = f2.readlines()
    sample_walk = []

    frame = []
    for line in short_sample:
        try:
            int(line)
        except:
            frame.append(line.rstrip('\n'))
        else:
            if frame:
                sample_walk.append(frame)
                frame = []
            frame.append(int(line.rstrip('\n')))
    return sample_walk


def create_walk():
    f2 = open('short_walk.amc', 'r')
    f3 = open('matched_walk.amc', 'w')

    sample_walk = one_stride(f2, f3)

    walk_trajectory = trajectory[-7:]
    for i in range(len(walk_trajectory)):
        if walk_trajectory[i][0] < 0:
            walk_trajectory[i][0] = 0
        if walk_trajectory[i][1] < 0:
            walk_trajectory[i][1] = 0

    frame_count = 0

    for i in range(len(walk_trajectory) - 1):
        # Get x,y coordinate of trajectory point
        new_x, new_y = walk_trajectory[i + 1]
        old_x, old_y = walk_trajectory[i]

        diff_x = abs(new_x - old_x)
        diff_y = abs(new_y - old_y)
        hypotenuse = math.sqrt(diff_x ** 2 + diff_y ** 2)

        if hypotenuse != 0:
            direction = math.acos(diff_y / hypotenuse)
        else:
            direction = 0

        diff_x = diff_x * x_ratio * mocap_scalar
        diff_y = diff_y * y_ratio * mocap_scalar

        old_x *= mocap_scalar * x_ratio
        old_y *= mocap_scalar * y_ratio

        increment_x = diff_x / 60
        increment_y = diff_y / 60

        for j in range(60):
            change_frame = sample_walk[frame_count % 120]
            change_frame[0] = str(frame_count + 1)
            root_dof = change_frame[1]
            if j == 0:
                y = old_y
                x = old_x
            else:
                # x,y = get_coor(root_dof)
                # x = float(x)
                # y = float(y)
                x += increment_x
                y += increment_y
            change_frame[1] = generator(root_dof, x, y, direction)
            for item in change_frame:
                f3.write(item + '\n')
            frame_count += 1
    f2.close()
    f3.close()



def create_run():
    f2 = open('short_run.amc', 'r')
    f3 = open('matched_run.amc', 'w')

    sample_run = one_stride(f2,f3)
    print(len(sample_run))
    run_trajectory = trajectory[:6]

    frame_count = 0

    for i in range(len(run_trajectory)-1):
        new_x, new_y = run_trajectory[i+1]
        old_x, old_y = run_trajectory[i]

        diff_x = abs(new_x - old_x)
        diff_y = abs(new_y - old_y)

        hypotenuse = math.sqrt(diff_x ** 2 + diff_y ** 2)

        if hypotenuse != 0:
            direction = math.acos(diff_y / hypotenuse)
        else:
            direction = 0

        diff_x = diff_x * x_ratio * mocap_scalar
        diff_y = diff_y * y_ratio * mocap_scalar

        old_x *= mocap_scalar * x_ratio
        old_y *= mocap_scalar * y_ratio

        increment_x = diff_x / 60
        increment_y = diff_y / 60

        for j in range(60):
            change_frame = sample_run[frame_count % 89]
            change_frame[0] = str(frame_count+1)
            root_dof = change_frame[1]
            if j == 0:
                x, y = -old_x, -old_y
            else:
                x += increment_x
                y += increment_y

            change_frame[1] = generator(root_dof,x,y,direction)
            for item in change_frame:
                f3.write(item+'\n')
            frame_count += 1

    f2.close()
    f3.close()


#######################################################################

f = open('trajectory.txt', 'r')
all_data = f.read().splitlines()
trajectory = []
for item in all_data:
    coor = []
    item = item.split()
    for i in item:
        try:
            float(i)
        except:
            pass
        else:
            coor.append(float(i))
    trajectory.append(coor)

f.close()
create_walk()
create_run()
