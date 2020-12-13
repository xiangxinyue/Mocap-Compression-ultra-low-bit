% % Save results of compression MoCap data in a
% % text file

function saveResult_qbc_mocap(hObject, eventdata, handles)

author = 'Murtaza Ali Khan,';
title = '"An efficient algorithm for compression of motion capture signal using multidimensional quadratic Bezier  curve break-and-fit method",';
journal ='Springer journal, Multidimensional Systems and Signal Processing,';
pages='pp. 121-143,';
month='Jan.,';
year='2016.,';
doi='doi = 10.1007/s11045-014-0293-4.';
ref = sprintf('%s %s %s %s %s %s %s',author,title,journal,pages,month,year,doi);

% % Get contents of text box
msgStr= get(handles.edit_main_msgs,'String');
msgStr{end+1}='Copyright: Dr. Murtaza Ali Khan';
msgStr{end+1}='Email: drkhanmurtaza@gmail.com';
msgStr{end+1}='Reference:';
msgStr{end+1}=ref;


% % Open standard dialog box to save statistics and analysis results
pathResult=pwd;
defaultFileName = fullfile(pathResult, '*.txt');
[fnameResult, pathResult, FilterIndex] = uiputfile(defaultFileName,'Save Statistics and Analysis');
if fnameResult == 0
    return;
end
fnameResultfull=fullfile(pathResult,fnameResult);
writecellaryinfile(fnameResultfull,msgStr);

% % % ---------------------------------------------------------------
% % Reference:
% % Reference:
% Murtaza Ali Khan, "An efficient algorithm for compression of motion
% capture signal using multidimensional quadratic Bezier  curve
% break-and-fit method", Multidimensional Systems and Signal Processing,
% Springer journal, August 2014,
% DOI 10.1007/s11045-014-0293-4.
% http://link.springer.com/article/10.1007/s11045-014-0293-4

% % Reference BibTeX
% @Article{Khan2014,
% author="Khan, Murtaza Ali",
% title="An efficient algorithm for compression of motion capture signal using multidimensional quadratic Bezier curve break-and-fit method",
% journal="Multidimensional Systems and Signal Processing",
% year="2014",
% volume="27",
% number="1",
% pages="121--143",
% issn="1573-0824",
% doi="10.1007/s11045-014-0293-4",
% url="http://dx.doi.org/10.1007/s11045-014-0293-4"
% }
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
