% % Order or serial numbers (S.No.) of joints in ASF and AMC files 
% % are not same. For example:
% % 'lowerback' joint in AMC file has S.No.= 2  
% % 'lowerback' joint in ASF file has S.No.= 12 
% % Then this function in the array snM has value snM(2)=12

% % ---------------------------------------------------
% % Even number of joints in ASF and AMC files are not same. For some
% % joints in ASF file their is no data in AMC file.
% % ---------------------------------------------------

% % INPUT
% % skel: mocap data in skel structure
% % jnameAMC: cell array that contains joints names as in AMC file


% % OUTPUT
% % sM: An array that holds matching serial numbers of ACM and ASF file

function [snM] = jointsMatchSNoASFAMC(skel, jnameAMC)

snM = [];
for i = 1:length(jnameAMC)
    for j = 1:length(skel.tree)        
          if isequal(jnameAMC{i},skel.tree(j).name)
            snM(end+1)=j;
        end
    end
end

% % % ---------------------------------------------------------------
% % This program or any other program(s) supplied with it do(es) not
% % provide any warranty direct or implied.
% % This program is free to use/share for non-commerical purpose only. 
% % Kindly reference the author.
% % Thanking you.
% % @ Copyright: Dr. Murtaza Ali Khan
% % Email: drkhanmurtaza@gmail.com
% % LinkedIn: http://www.linkedin.com/pub/dr-murtaza-khan/19/680/3b3
% % ResearchGate: http://www.researchgate.net/profile/Murtaza_Khan2/
% % % --------------------------------------------------------------- 





