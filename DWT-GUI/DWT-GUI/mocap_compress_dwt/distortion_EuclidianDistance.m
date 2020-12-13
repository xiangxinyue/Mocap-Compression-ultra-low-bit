% % measure the distortion using average Euclidian distance 

% % INPUT
% % x: matrix of size r-by-c (r: no. of rows, c: no. of columns)
% % y: matrix of size r-by-c (r: no. of rows, c: no. of columns)
% % OUTPUT
% % mse:    mean squared error (mse)
% % sqdRow: square distance row wise between x and y for 1-D or 2-D data
% %         only

function [distortion]=distortion_EuclidianDistance(eMSE)

distortion = sqrt(eMSE);

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