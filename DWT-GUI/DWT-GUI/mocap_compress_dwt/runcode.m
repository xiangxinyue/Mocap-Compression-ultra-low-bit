% % runcode function find a zero run in the run-length table.
% % If not found, create a new entry in the table. 
% % Return the index of the run.

function y=runcode(x)
 global RUNS
y=find(RUNS==x);
if length(y) ~= 1
    RUNS=[RUNS; x];
    y=length(RUNS);
end

% % ------------------------------
% % Reference
% % Digital Image Processing Using MATLAB by Gonzalez, Woods and Eddins

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