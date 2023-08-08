function rndmMarksList = getRandomAnnotations(fs, wdwStartSample, wdwEndSample, nrAnnots, mtgLabels)

    nrMtgs = length(mtgLabels);
    
    eventsList = {'HFO', 'Ripple', 'FR'};
    rng(0,'twister');
    markStartVec = randi([wdwStartSample wdwEndSample], 1, nrAnnots);
    markDurationVec = randi([round(0.025*fs) round(0.1*fs)], 1, nrAnnots);
    markEndVec = markStartVec + markDurationVec;
    markStartTimeVec = markStartVec/fs;
    markEndTimeVec = markEndVec/fs;

    markStartCell = num2cell(markStartVec)';
    markEndCell = num2cell(markEndVec)';
    markStartTimeCell = num2cell(markStartTimeVec)';
    markEndTimeCell = num2cell(markEndTimeVec)';
    
    markTypeIdx = randi([1 length(eventsList)], 1, nrAnnots);
    markTypeCell = {};
    for i = 1:nrAnnots
        annot = eventsList{markTypeIdx(i)};
        markTypeCell = cat(1, markTypeCell, annot);
    end
    
    markChIdx = randi([1 nrMtgs], 1, nrAnnots);
    markChCell = {};
    for i = 1:nrAnnots
        channLabel = mtgLabels{markChIdx(i)};
        markChCell = cat(1, markChCell, channLabel);
    end

    markCommentCell = cellstr(repmat('Comment', nrAnnots,1));

    rndmMarksList = cat(2, markChCell, markTypeCell, markStartTimeCell, markEndTimeCell, markStartCell, markEndCell, markCommentCell);
end
