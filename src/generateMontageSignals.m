function [mtgLabels, mtgSignals, mtgSignalsLow, mtgSignalsHFO, mtgSignalsRipple, mtgSignalsFR] = generateMontageSignals(samplingRate, unipSignals, unipLabels, goalMtgLabels, filterValues, notchSettings, notchOK)
    nrSamples = size(unipSignals,2);
    mtgLabelsTemp = lower(goalMtgLabels);
    unipLabels = lower(unipLabels);

    % Find out how many of the goal mtgs are really present in the data
    cnsldtMtgList = {};
    for mi = 1:size(mtgLabelsTemp,1)
        montageName = mtgLabelsTemp{mi};
        chA = montageName(1:strfind(montageName, '-')-1);
        chB = montageName(strfind(montageName, '-')+1:end);
        chAIdx = find(ismember(unipLabels, chA));
        chBIdx = find(ismember(unipLabels, chB));
        if not(isempty(chAIdx) || isempty(chBIdx))
            mtgEntree = {goalMtgLabels{mi}, chAIdx, chBIdx};
            cnsldtMtgList = [cnsldtMtgList; mtgEntree];
        end
    end
    nrMtgs = size(cnsldtMtgList,1);
    mtgLabels = cnsldtMtgList(:,1);

    mtgSignals = zeros(nrMtgs, nrSamples);
    mtgSignalsLow = zeros(nrMtgs, nrSamples);
    mtgSignalsHFO= zeros(nrMtgs, nrSamples);
    mtgSignalsRipple = zeros(nrMtgs, nrSamples);
    mtgSignalsFR = zeros(nrMtgs, nrSamples);

    notchWidth=2;
    notchOrder = notchSettings.order;
    harmonFreqs = [notchSettings.freqs - notchWidth, notchSettings.freqs + notchWidth];
    
    for mi = 1:nrMtgs
        sigA = unipSignals(cnsldtMtgList{mi,2},:);
        sigB = unipSignals(cnsldtMtgList{mi,3},:);
        mtgSignal = sigA - sigB;
        if notchOK
            if sum(ismember(notchSettings.channs, mtgLabels{mi})==1)
                for hi = 1:size(harmonFreqs,1)
                    mtgSignal = getBandstopSignal(samplingRate, notchOrder, harmonFreqs(hi,1), harmonFreqs(hi,2), mtgSignal);
                end
            end
        end
        %mtgSignal = getHighpassedSignal(samplingRate, fltrOrder, 1, mtgSignal);
        %mtgSignal = getNotchedSignal(samplingRate, fltrOrder, 60, mtgSignal);
        mtgSignals(mi,:) = mtgSignal;
        mtgSignalsLow(mi,:) = getBandpassedSignal(samplingRate, filterValues(1,3), filterValues(1,1), filterValues(1,2), mtgSignal);
        mtgSignalsHFO(mi,:) = getBandpassedSignal(samplingRate, filterValues(2,3), filterValues(2,1), filterValues(2,2), mtgSignal);
        mtgSignalsRipple(mi,:) = getBandpassedSignal(samplingRate, filterValues(3,3), filterValues(3,1), filterValues(3,2), mtgSignal);
        mtgSignalsFR(mi,:) = getBandpassedSignal(samplingRate, filterValues(4,3), filterValues(4,1), filterValues(4,2), mtgSignal);
    end

end