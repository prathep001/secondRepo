function makeHTMLReport(model_names)

% Create a Master HTML file.
mdlId = fopen('Master_Mdl_Advisor_Report.html','w');
fprintf(mdlId,'<!DOCTYPE html>\n<html>\n<head>\n<style>\n');
fprintf(mdlId,...
    'mark{background-color:#ADD8E6;color: Black;}\n');
fprintf(mdlId,'.center{margin: auto;width: 60;border: 3px solid black;padding: 10px;}\n');
fprintf(mdlId,'</style>\n</head>\n<body>\n<div class = "center">\n');
fprintf(mdlId,'<h3 align=center>Master Model Advisor Report </h3>\n');
fprintf(mdlId,'<h3>Date:%s </h3>\n',datestr(now));
fprintf(mdlId,'<h3>Number of Systems Run: %d</h3>\n',numel(model_names));
fprintf(mdlId,'<table border="1" cellpadding="5">\n');
% Table header - system name,pass,fail,warning,not run.
fprintf(mdlId,'<tr>\n');
fprintf(mdlId,...
    '<th>System Name</th>\n<th><img src = "Images/task_passed.png"></img>Pass</th>\n<th><img src = "Images/task_failed.png"></img>Fail</th>\n<th><img src = "Images/task_warning.png"></img>Warnings</th>\n<th >Not Run</th>\n<th>Report Link</th>\n');
fprintf(mdlId,'</tr>\n');
% Read the file one by one and collect the pass fail norun waning values.
for ii = 1:length(model_names)
    reportName = [model_names{ii} '.html'];
    fileId = fopen(reportName,'r');
    rawData = textscan(fileId,'%s','delimiter','\n');
    fclose(fileId);
    htmlData = rawData{1,1};
    % Parse and get the table data.
    findPass = cellfun(@(x)strcmp(x,'Pass'),htmlData);
    tableEnd = cellfun(@(x)strcmp(x,'</table>'),htmlData);
    passIdx = find(findPass == 1);
    tableIdcs = find(tableEnd == 1);
    tableIdx = find(tableIdcs > passIdx == 1);
    tableEndIdx = tableIdcs(tableIdx(1));
    % Table Data.
    tableData = htmlData(passIdx:tableEndIdx);
    % Get the value of pass,fail and warning.
    endData = cellfun(@(x)regexp(x,'<img.*> (\d+)','tokens'),tableData,'UniformOutput',0);
    modelAdvisorOutput = [endData{:}];
    fprintf(mdlId,'<tr>\n');
    fprintf(mdlId,'<td width="200" align="left">%s</td>\n',model_names{ii});
    fprintf(mdlId,'<td width="200" align="left">%s</td>\n',char(modelAdvisorOutput{1}));
    fprintf(mdlId,'<td width="200" align="left">%s</td>\n',char(modelAdvisorOutput{2}));
    fprintf(mdlId,'<td width="200" align="left">%s</td>\n',char(modelAdvisorOutput{3}));
    fprintf(mdlId,'<td width="200" align="left">%s</td>\n',char(modelAdvisorOutput{4}));
    % Report link.
    fprintf(mdlId,'<td width="200" align="left"><a href = %s>%s</a></td>\n',reportName,reportName);
    fprintf(mdlId,'</tr>\n');
end
fprintf(mdlId,'</table>\n</div>\n</body>\n</html>');
fclose(mdlId);

end