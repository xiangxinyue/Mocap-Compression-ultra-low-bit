% % Save results of compression MoCap data via DWT in a
% % text file

function saveResult_dwt_mocap(hObject, eventdata, handles)

author = 'Murtaza Ali Khan';
title = '"Multiresolution coding of motion capture data for real-time multimedia applications"';
journal ='Springer journal';
pages='First online pp. 1-16';
month='Sep.';
year='2016';
doi='doi = 10.1007/s11042-016-3944-7';
ref = sprintf('%s, %s, %s, %s, %s %s, %s',author,title,journal,pages,month,year,doi);

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
% Murtaza Ali Khan, "Multiresolution coding of motion capture data for
% real-time multimedia applications", Multimedia Tools and Applications,
% Springer journal, First online pp 1-16, Sep. 2016.
% DOI=10.1007/s11042-016-3944-7

% % Reference BibTeX
% % @Article{Khan2016,
% % author="Khan, Murtaza Ali",
% % title="Multiresolution coding of motion capture data for real-time multimedia applications",
% % journal="Multimedia Tools and Applications",
% % year="2016",
% % pages="1--16",
% % issn="1573-7721",
% % doi="10.1007/s11042-016-3944-7",
% % url="http://dx.doi.org/10.1007/s11042-016-3944-7"
% % }
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
