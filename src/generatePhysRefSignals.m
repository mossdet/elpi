function [mtgLabels, mtgSignals, mtgSignalsLow, mtgSignalsHFO, mtgSignalsRipple, mtgSignalsFR] = generatePhysRefSignals(samplingRate, unipSignals, unipLabels, filterValues, removeHarmonics)
    nrSamples = size(unipSignals,2);
    nrMtgs = size(unipLabels,1);

    mtgSignals = zeros(nrMtgs, nrSamples);
    mtgSignalsLow = zeros(nrMtgs, nrSamples);
    mtgSignalsHFO= zeros(nrMtgs, nrSamples);
    mtgSignalsRipple = zeros(nrMtgs, nrSamples);
    mtgSignalsFR = zeros(nrMtgs, nrSamples);

    fltrOrder = 512;
    noiseFreqs = 60*[1:8];
    notchWidth=3;
    harmonFreqs = [];
    for nf = noiseFreqs
        harmonFreqs = [harmonFreqs; [nf-notchWidth, nf+notchWidth]];
    end
    
    for mi = 1:nrMtgs
        mtgSignal = unipSignals(mi,:);
        if removeHarmonics
            for hi = 1:size(harmonFreqs,1)
                mtgSignal = getBandstopSignal(samplingRate, fltrOrder, harmonFreqs(hi,1), harmonFreqs(hi,2), mtgSignal);
            end
        end

        mtgSignals(mi,:) = mtgSignal;
        mtgSignalsLow(mi,:) = getBandpassedSignal(samplingRate, filterValues(1,3), filterValues(1,1), filterValues(1,2), mtgSignal);
        mtgSignalsHFO(mi,:) = getBandpassedSignal(samplingRate, filterValues(2,3), filterValues(2,1), filterValues(2,2), mtgSignal);
        mtgSignalsRipple(mi,:) = getBandpassedSignal(samplingRate, filterValues(3,3), filterValues(3,1), filterValues(3,2), mtgSignal);
        mtgSignalsFR(mi,:) = getBandpassedSignal(samplingRate, filterValues(4,3), filterValues(4,1), filterValues(4,2), mtgSignal);
    end
    mtgLabels = unipLabels;
end