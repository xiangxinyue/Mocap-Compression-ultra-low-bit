% % Computes mean squarred error between x and y

% % INPUT
% % x: matrix of size r-by-c
% % y: matrix of size r-by-c
% % OUTPUT
% % mse:    mean squared error (mse)
% % sqdRow: square distance row wise between x and y for 1-D or 2-D data
% %         only

function [mse,sqdRow]=msqerr(x,y)

dim=ndims(x);
[r, c]=size(x);
x=double(x);
y=double(y);

if dim<=2
    sqdColRow=(x-y).^2;        % sq. distance for each column of each row
    sqdRow=sum(sqdColRow,2);   % sq. distance for each row
    mse=sum(sqdRow)/(r*c);
else
    error = (x - y).^2;
    mse = sum(error(:))/prod(size(x));
end

% % Ref:
% % http://en.wikipedia.org/wiki/PSNR
% % http://www.mathworks.com/support/solutions/data/1-ON190.html?product=IP&solution=1-ON190

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
