function errorStr = checkSavedDetections(detections, savedDets)

    errorStr = '';

    %% Check nr. dets
    nrDets = size(detections,1);
    nrSavedDets = size(savedDets,1);
    floatTolerance = 0.0000000001;

    detNameCell = {detections{:,7}; savedDets{:,7}}';

    if nrDets~= nrSavedDets
        errorStr = 'Annotation Save Error: incorrect number of detections';
    elseif sum(strcmp(detections(:,1), savedDets(:,1))) ~= nrDets
        errorStr = 'Annotation Save Error: incorrect channel labels';
    elseif sum(strcmp(detections(:,2), savedDets(:,2))) ~= nrDets
        errorStr = 'Annotation Save Error: incorrect event type labels';
    elseif abs(sum(cell2mat(detections(:,3)) - cell2mat(savedDets(:,3)))) > floatTolerance
        errorStr = 'Annotation Save Error: incorrect start times';
    elseif abs(sum(cell2mat(detections(:,4)) - cell2mat(savedDets(:,4)))) > floatTolerance
        errorStr = 'Annotation Save Error: incorrect end times';
    elseif abs(sum(cell2mat(detections(:,5)) - cell2mat(savedDets(:,5)))) > floatTolerance
        errorStr = 'Annotation Save Error: incorrect start sample';
    elseif abs(sum(cell2mat(detections(:,6)) - cell2mat(savedDets(:,6)))) > floatTolerance
        errorStr = 'Annotation Save Error: incorrect end sample';
    elseif sum(cellfun(@strcmp, detNameCell(:,1), detNameCell(:,2))) ~= nrDets
        errorStr = 'Annotation Save Error: incorrect detector name';
    elseif abs(sum(cell2mat(detections(:,8)) - cell2mat(savedDets(:,8)))) > floatTolerance
        errorStr = 'Annotation Save Error: incorrect scope flag';
    elseif sum(strcmp(detections(:,9), savedDets(:,9))) ~= nrDets
        errorStr = 'Annotation Save Error: incorrect date';
    elseif sum(strcmp(detections(:,10), savedDets(:,10))) ~= nrDets
        errorStr = 'Annotation Save Error: incorrect username';
    end

end