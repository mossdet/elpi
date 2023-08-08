function [wdwRelevantMarks, timeChannTypeValidIdxNr] = getValidMarks(marksList, wdwLoc, wdwLenSamples, mtgLabels, validAnnotTypes)
    wdwRelevantMarks = [];
    timeChannTypeValidIdxNr = [];
    if ~isempty(marksList)
        startSamplesVec = cell2mat(marksList(:,5));
        endSamplesVec = cell2mat(marksList(:,6));
        currWdwMargins =  [wdwLoc, wdwLoc + wdwLenSamples];
        timeChannTypeValidMask = false(length(startSamplesVec),1);
        timeChannTypeValidIdxNr = [];

        relevantA = startSamplesVec >= currWdwMargins(1) & startSamplesVec <= currWdwMargins(2);
        relevantB = endSamplesVec >= currWdwMargins(1) & endSamplesVec <= currWdwMargins(2);
        relevantC = startSamplesVec <= currWdwMargins(1) & endSamplesVec >= currWdwMargins(2);
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