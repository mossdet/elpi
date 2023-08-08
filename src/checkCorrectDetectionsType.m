function typeOk = checkCorrectDetectionsType(detections, existingAnnots)
    classTypesDets = cell(1, size(detections,2));
    for ci = 1:size(detections,2)
    classTypesDets{ci} = class(detections{1,ci});
    end
    
    classTypesAnnots = cell(1, size(existingAnnots,2));
    for ci = 1:size(existingAnnots,2)
    classTypesAnnots{ci} = class(existingAnnots{1,ci});
    end
    [classTypesDets;classTypesAnnots]
    typeOk = sum(not(strcmp(classTypesDets,classTypesAnnots))) == 0;
end