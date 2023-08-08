function noiseSegmentsPlot = getNoiseIdxsToPlot(fs, tWin, analysisMtgNames, allMtgNames, noiseMarksList)
    noiseSegmentsPlot = [];
    wdwStartS = tWin(1);
    wdwEndS = tWin(end);
    wdwNoiseMtgSel = ismember(allMtgNames, analysisMtgNames);
    wdwNoiseList = noiseMarksList(wdwNoiseMtgSel);
    for mi = 1:size(wdwNoiseList,1)
        mtgNoiseSgmnts = wdwNoiseList{mi};
        if not(isempty(mtgNoiseSgmnts))
            selSegmentsA = mtgNoiseSgmnts(1,:)>=wdwStartS & wdwNoiseList{mi}(1,:)<=wdwEndS;
            selSegmentsB = mtgNoiseSgmnts(2,:)>=wdwStartS & wdwNoiseList{mi}(2,:)<=wdwEndS;
            selSegments = selSegmentsA | selSegmentsB; 
            mtgNoiseSgmntsValid = mtgNoiseSgmnts(:,selSegments);
            for si = 1:size(mtgNoiseSgmntsValid,2)
                noiseSegStartS = mtgNoiseSgmntsValid(1,si);
                noiseSegEndS = mtgNoiseSgmntsValid(2,si);
                noiseSegStartSample = find(tWin>=noiseSegStartS, 1, 'first');
                noiseSegEndSample = find(tWin<=noiseSegEndS, 1, 'last');
                noiseSegmentsPlot = cat(1, noiseSegmentsPlot, [mi, si, noiseSegStartSample, noiseSegEndSample]);
            end
        end
    end
end