function testScriptAutotrans(varargin)
modelName = 'sim_autotrans';
inputName = 'inputVector';
baseVar = evalin('base','who');
disp(baseVar);
testScriptFilepath = mfilename('fullpath');
[testDir,~,~] = fileparts(testScriptFilepath);
[parentDir,~,~] = fileparts(testDir);
textFilePath = [testDir '\changeDetailsText.txt'];
try
    filetext = fileread(textFilePath);
    filetext = strsplit(filetext,'\n');
catch
    disp('Unable to read File');
end
modelDir= [parentDir '\ModelFile'];
testDataDir = [parentDir '\TestData'];
addpath(modelDir);
disp(modelDir);
addpath(testDataDir);
disp(testDataDir);
% Searching Test Data Files.
testFiles = dir([testDataDir '\*.mat']);
if isempty(testFiles)
    disp('No TestFiles are found');
    return;
end
% Loading Model
disp('Loading system model ....');
load_system(modelName)
disp('Model loaded successfully');
passCount = 0;
failCount = 0;
% Test file in loop.
for idx = 1:length(testFiles)
    disp('Clearing Test Data if any');
    clear(inputName);
    testData = load(testFiles(idx).name);
    testName = fieldnames(testData);
    disp('******************************************************************');
    disp(['Test no: ' num2str(idx) ' - ' testName{1}]);
    disp('******************************************************************');
    assignin('base',inputName,testData.(testName{1}));
    disp('Simulating the model');
    try
        sim(modelName);
        disp('Test Passed');
        passCount = passCount+ 1;
    catch
        disp('Test Failed');
        failCount = failCount+ 1;
        continue;
    end
end
% Close system
close_system(modelName,0);
% Messages
disp('******************************************************************');
disp('Test Summary');
disp('******************************************************************');
disp(['Number of Test Cases: ' num2str(idx)]);
disp(['Number of test Cases Passed: ' num2str(passCount)]);
disp(['Number of test Cases Failed: ' num2str(failCount)]);
if ~isequal(failCount,0)
    disp(errorMsg);
else
    disp('Overall Test Result: Passed');
end
end