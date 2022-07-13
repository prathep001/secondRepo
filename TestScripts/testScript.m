modelName = 'sim_autotrans';
inputName = 'inputVector';
testScriptFilepath = mfilename('fullpath');
[testDir,~,~] = fileparts(testScriptFilepath);
[parentDir,~,~] = fileparts(testDir);

modelDir= [parentDir '\ModelFile'];
testDataDir = [parentDir '\TestData'];
addpath(modelDir);
fprintf(modelDir);
addpath(testDataDir);
fprintf(testDataDir);
% Searching Test Data Files.
testFiles = dir([testDataDir '\*.mat']);
if isempty(testFiles)
    fprintf('No TestFiles are found');
    return;
end
% Loading Model
fprintf('Loading system model ....');
load_system(modelName)
fprintf('Model loaded successfully');
passCount = 0;
failCount = 0;
% Test file in loop.
for idx = 1:length(testFiles)
    fprintf('Clearing Test Data if any');
    clear(inputName);
    testData = load(testFiles(idx).name);
    testName = fieldnames(testData);
    fprintf('******************************************************************');
    fprintf(['Test no: ' num2str(idx) ' - ' testName{1}]);
    fprintf('******************************************************************');
    assignin('base',inputName,testData.(testName{1}));
    fprintf('Simulating the model');
    try
        sim(modelName);
        fprintf('Test Passed');
        passCount = passCount+ 1;
    catch
        fprintf('Test Failed');
        failCount = failCount+ 1;
        continue;
    end
end
% Close system
close_system(modelName,0);
% Messages
fprintf('******************************************************************');
fprintf('Test Summary');
fprintf('******************************************************************');
fprintf(['Number of Test Cases: ' num2str(idx)]);
fprintf(['Number of test Cases Passed: ' num2str(passCount)]);
fprintf(['Number of test Cases Failed: ' num2str(failCount)]);
if ~isequal(failCount,0)
    fprintf(errorMsg);
else
    fprintf('Overall Test Result: Passed');
end