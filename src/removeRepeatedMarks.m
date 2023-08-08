function newMarksList = removeRepeatedMarks(marksList)

	nrRows = size(marksList,1);
    entreeCell = cell(nrRows, 1);
    for ei = 1:nrRows
        entree = strcat(marksList{ei,1}, '-', marksList{ei,2}, '-', ...
            num2str(marksList{ei,5}), '-', num2str(marksList{ei,6}));
        entreeCell{ei} = entree;
    end
    [C,ia,ic] = unique(entreeCell);
    newMarksList = marksList(ia,:);
end