function [wdwRelevantMarks, timeChannTypeValidIdxNr] = getValidMarks(fs, marksList, wdwLimsT, mtgLabels, validAnnotTypes)
    wdwRelevantMarks = [];
    timeChannTypeValidIdxNr = [];
    if ~isempty(marksList)
        startTimesVec = cell2mat(marksList(:,3));
        endTimesVec = cell2mat(marksList(:,4));
        %startSamplesVec = startTimesVec*fs;
        %endSamplesVec = endTimesVec*fs;
        timeChannTypeValidMask = false(length(startTimesVec),1);
        timeChannTypeValidIdxNr = [];

        relevantA = startTimesVec >= wdwLimsT(1) & startTimesVec <= wdwLimsT(2);
        relevantB = endTimesVec >= wdwLimsT(1) & endTimesVec <= wdwLimsT(2);
        relevantC = startTimesVec <= wdwLimsT(1) & endTimesVec >= wdwLimsT(2);
        timeRelevantMask = relevantA | relevantB | relevantC;

        if sum(timeRelevantMask) > 0
            timeRelevantMarks = marksList(timeRelevantMask,:);
            channLabelVec = timeRelevantMarks(:,1);
            channelRelevantMask = ismember(channLabelVec, mtgLabels) | strcmp(channLabelVec, 'All');

            allTypesOK = isempty(validAnnotTypes) || sum(ismember(validAnnotTypes, "All"))>0;
            markTypeVec = timeRelevantMarks(:,2);
            typeRelevantMask = true(length(markTypeVec),1);
            if ~allTypesOK
                typeRelevantMask = ismember(markTypeVec, validAnnotTypes);
            end
            timeChannTypeValidMask(timeRelevantMask) = channelRelevantMask & typeRelevantMask;
 
            wdwRelevantMarks = marksList(timeChannTypeValidMask,:);
            timeChannTypeValidIdxNr = find(timeChannTypeValidMask);
        end
    end
end