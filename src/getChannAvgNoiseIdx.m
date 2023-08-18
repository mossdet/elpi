function [timeVec, r2Vec] = getChannAvgNoiseIdx(fs, mtgLabels, mtgSignals)

    nSamples = size(mtgSignals,2);
    stepSize = fs*5;
    wdwSize = fs*10;
    ssVec = 1:stepSize:nSamples-wdwSize;
    timeVec = zeros(1, length(ssVec));
    r2Vec = zeros(1, length(ssVec));

    parfor si = 1:length(ssVec)
        startSample = ssVec(si);
        endSample = startSample+wdwSize-1;
        timestamp = startSample/fs;

        dataWin = mtgSignals(:, startSample:endSample);
        r2PerfEEG = getNoiseIndex(fs, mtgLabels, dataWin);

        timeVec(si) = timestamp;
        r2Vec(si) = r2PerfEEG;
    end

end