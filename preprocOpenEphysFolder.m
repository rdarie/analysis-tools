function [result] = preprocOpenEphysFolder(folderPath)
% eg folderPath = 'Z:\data\rdarie\Murdoc Neural Recordings\raw\201901070700-ProprioRC\open_ephys\Trial004_EMG';
% eg folderPath = 'Z:\data\rdarie\Murdoc Neural Recordings\raw\201812051000-PadawanRecruitmentCurve\open_ephys\201812051000-PadawanRecruitmentCurve-Trial001-1_EMG';
queryStr = strcat(folderPath, filesep, '100_*.continuous');
folderPathParts = regexp(folderPath, filesep, 'split');
folderBaseName = folderPathParts{end};
filenames  = dir(queryStr);
result = struct('data', [], 'timestamps', [], 'info', []);
%
for k = 1:length(filenames)
    filePath = strcat(filenames(k).folder, filesep, filenames(k).name);
    [result(k).data, result(k).timestamps, result(k).info] = load_open_ephys_data_faster(filePath, 'unscaledInt16');
end
%
resultPath = strcat(folderPath, filesep, folderBaseName, '.mat');
save(resultPath, 'result', '-v7.3')
end