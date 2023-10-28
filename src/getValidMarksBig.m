function [wdwRelevantMarks, timeChannTypeValidIdxNr] = getValidMarksBig(fs, marksList, wdwLimsT, mtgLabels, validAnnotTypes)
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

        badSegSel = ismember(marksList(:,2), 'Bad');
        badSegMarks = marksList(badSegSel,:);
        inBadMask = false(length(startTimesVec),1);
        for bsi = 1:size(badSegMarks,1)
            bss = badSegMarks{bsi,3};
            bse = badSegMarks{bsi,4};
            bschName = badSegMarks{bsi,1};
            channSpec = badSegMarks{bsi,8};
            if channSpec
                inBadMask(ismember(marksList(:,1), bschName) & startTimesVec>=bss & endTimesVec <=bse) = true();
            else
                inBadMask(startTimesVec>=bss & endTimesVec <=bse) = true();
            end
        end
        inBadMask = inBadMask & not(badSegSel);
        timeRelevantMask = timeRelevantMask & not(inBadMask);

        if sum(timeRelevantMask) > 0
            timeRelevantMarks = marksList(timeRelevantMask,:);
            channLabelVec = timeRelevantMarks(:,1);
            channelRelevantMask = ismember(channLabelVec, mtgLabels) | strcmp(channLabelVec, 'All');

            allTypesOK = isempty(validAnnotTypes) || sum(ismember(validAnnotTypes, "All"))>0;
            markTypeVec = timeRelevantMarks(:,2);
            typeRelevantMask = true(length(markTypeVec),1);
            if ~allTypesOK
                typeRelevantMask = ismember(markTypeVec, validAnnotTypes) | ismember(markTypeVec, 'Bad');
            end
            timeChannTypeValidMask(timeRelevantMask) = channelRelevantMask & typeRelevantMask;
 
            wdwRelevantMarks = marksList(timeChannTypeValidMask,:);
            timeChannTypeValidIdxNr = find(timeChannTypeValidMask);
        end
    end
end