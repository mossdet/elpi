function [annotationsFilepath] = readAndSave_EDF_Annotations(eegFilepath)
    % Fieldtrip
    startupFieldtrip;

    [filepath, patName, ext] = fileparts(eegFilepath);
    annotationsFilepath = strcat(filepath, "\", patName, "_Annotations.mat");

    if ~isfile(annotationsFilepath)
        ahsEventsCell = {};

    %% Read annotations from the exported EDF file
%         hdr = ft_read_header(eegFilepath);
%         eventHdr = ft_read_event(eegFilepath);
%         eventsTable = struct2table(eventHdr);
%         eventsCell = table2cell(eventsTable);
%         validIdx = not(cellfun('isempty', eventsCell(:,2)));
%         validEventsCell = eventsCell(validIdx, :);
    
%         %% Assemble cell
%         ahsEventsCell = cell(size(validEventsCell,1), 7);    
%         for i = 1:size(validEventsCell,1)
%             chann = 'All';
%             mark = validEventsCell{i,2};
%             mark = strrep(mark, char(10), '');
%             mark = strrep(mark, char(13), '');
%             startSample = validEventsCell{i,3};
%             startTime = startSample/hdr.Fs;
%
%             if ~ischar(mark)
%                 stop = 1;
%             end
%     
%             ahsEventsCell{i,1} = chann;
%             ahsEventsCell{i,2} = mark;
%             ahsEventsCell{i,3} = startTime;
%             ahsEventsCell{i,4} = startTime+1;
%             ahsEventsCell{i,5} = startSample;
%             ahsEventsCell{i,6} = startSample+hdr.Fs;
%             ahsEventsCell{i,7} = 'edfComment';
%         end
        annotations.ahs= ahsEventsCell;    
        save(annotationsFilepath, 'annotations');
    end
end
