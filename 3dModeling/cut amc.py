

# this file is used to create sample walk and run amc to further generate 3d matched amc file from trajectories
class read_amc():
    def __init__(self,file_name):
        self.amc_file = open(file_name, 'r')
        self.start_frames = []
        self.complete_frame = []
        self.read_frame()

    def read_frame(self):
        with self.amc_file as f:
            amc_lines = f.readlines()
            for line in amc_lines:
                try:
                    int(line)
                except:
                    self.complete_frame.append(line)
                else:
                    # parameter that has to be changed based on run or walk amc
                    # for walk, use 140; for run use 91
                    if int(line) == 91:
                        return
                    else:
                        self.complete_frame.append(line)




file_name = 'run.amc'
new_file = 'short_run.amc'

amc_data = read_amc(file_name).complete_frame
f = open(new_file, 'w')
for line in amc_data:
    f.write(line)
f.close()

