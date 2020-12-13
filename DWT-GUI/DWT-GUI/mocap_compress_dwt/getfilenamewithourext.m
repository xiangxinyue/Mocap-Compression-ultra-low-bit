% % get file name without extension
% % INPUT
% % fn1: file name with extension e.g., 'flower.bmp'
% % OUTPUT
% % fn2: file name with extension e.g., 'flower'
% % ext: extesnion e.g., 'bmp'
function [fn2,ext]=getfilenamewithourext(fn1)

length(fn1);
k = strfind(fn1, '.');
fn2=fn1(1:k-1);
ext=fn1(k+1:end);

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
