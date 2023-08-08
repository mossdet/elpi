%% get filtered signals
function [bpSignal] = getNotchedSignal(samplingRate, order, wc, signal)
    filterDelay = order/2;
    h = fir1(order/2, wc/(samplingRate/2), 'stop'); % 'low' | 'bandpass' | 'high' | 'stop' | 'DC-0' | 'DC-1'
    bpSignal = filter(h, 1, flip(signal));
    bpSignal = filter(h, 1, flip(bpSignal));
    bpSignal(1:filterDelay) = bpSignal(filterDelay+1);
    bpSignal(end-filterDelay:end) = bpSignal(end-filterDelay-1);
end