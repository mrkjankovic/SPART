%Adds SPART to the path and save it

%Add all the required folders into the path
addpath(sprintf('%s/KinDyn',pwd));
addpath(sprintf('%s/SimulinkLibrary',pwd));

%Save path
savepath;
