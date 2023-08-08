%% add to search path
[path,~,~] = fileparts(mfilename('fullpath'));
cutIdx = strfind(path, '\');
workspacePath = path(1:cutIdx(end));
addpath(genpath(strcat(workspacePath,'appSrc\')));
addpath(genpath(strcat(workspacePath,'src\')));
%addpath(genpath(workspacePath));

ftPath = strcat(workspacePath, 'fieldtrip');
addpath(ftPath); 
ft_defaults;