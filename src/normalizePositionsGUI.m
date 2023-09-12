function normalizePositionsGUI(app)
    screenSize = get(groot,'ScreenSize');
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

%app.annotateHFO_GUI.Position = screenSize;


%% Warning Text
left = screenWidth*0.2;
bottom = screenHeight*0.7;
app.WarningTxt_Label.Position(1:2) = [left bottom];

%% bigWdw
left = screenWidth*0;
bottom = screenHeight*0.015;
width = screenWidth*0.50;
height = screenHeight*0.88;
app.bigWdw.Position = [left bottom width height];

%% smallWdw
left = screenWidth*0.50;
bottom = screenHeight*0.30;
width = screenWidth*0.45;
height = screenHeight*0.60;
app.smallWdw.Position = [left bottom width height];

%% heatmap
left = screenWidth*0.50;
bottom = screenHeight*0.015;
width = screenWidth*0.45;
height = screenHeight*0.28   ;
app.heatmap.Position = [left bottom width height];

%% Big Wdw Slider
left = screenWidth*0.2;
bottom = screenHeight*0.007;
app.bigWdwSlider.Position(1:2) = [left bottom];

%% Small Wdw Slider
left = screenWidth*0.65;
bottom = screenHeight*0.007;
app.smallWdwSlider.Position(1:2) = [left bottom];

%% bigWdwFltrBttn
left = screenWidth*0.3;
bottom = screenHeight*0.90;
app.bigWdwFltrBttn.Position(1:2) = [left bottom];
buttonWidth = app.bigWdwFltrBttn.Position(3);

%% wdwsLengthLabel
left = screenWidth*0.42;
bottom = screenHeight*0.90;
app.wdwsLengthLabel.Position(1:2) = [left bottom];

%% bigWdwSetLen
left = sum(app.wdwsLengthLabel.Position([1 3]));
bottom = screenHeight*0.90;
app.bigWdwSetLen.Position(1:3) = [left bottom buttonWidth];

%% smallWdwSetLen
left = sum(app.bigWdwSetLen.Position([1 3]));
bottom = screenHeight*0.90;
%app.smallWdwSetLen.Position = [left bottom width height];
app.smallWdwSetLen.Position(1:3) = [left bottom buttonWidth];

%% AutosaveCheckBox
left = screenWidth*0.965;
bottom = screenHeight*0.90;
app.AutosaveCheckBox.Position(1:2) = [left bottom];

%% annotAutosaveText
left = screenWidth*0.99;
bottom = screenHeight*0.87;
app.autosaveTxt.Position(1:2) = [left bottom];

%% markModeLampSmall
left = screenWidth*0.98;
bottom = screenHeight*0.86;
app.markModeLampSmall.Position(1:2) = [left bottom];

%% markModeTxtSmall
left = screenWidth*0.975;
bottom = screenHeight*0.825;
app.markModeTxtSmall.Position(1:2) = [left bottom];

%% RemoveHarmonicsCheckBox
left = screenWidth*0.965;
bottom = screenHeight*0.75;
app.RemoveEMIHarmonicsCheckBox.Position(1:2) = [left bottom];

%% smallWdwFltrBttn
left = screenWidth*0.965;
bottom = screenHeight*0.60;
app.smallWdwFltrBttn.Position(1:2) = [left bottom];

%% eegNIStr
left = screenWidth*0.975;
bottom = screenHeight*0.40;
app.eegNIStr.Position(1:2) = [left bottom];

%% noiseIdxStr
left = screenWidth*0.9725;
bottom = screenHeight*0.36;
app.noiseIdxStr.Position(1:2) = [left bottom];

%% heatmapFltrBttn
left = screenWidth*0.965;
bottom = screenHeight*0.20;
app.heatmapFltrBttn.Position(1:2) = [left bottom];

%% cwtLockCheck
left = screenWidth*0.97;
bottom = screenHeight*0.15;
app.cwtLockCheck.Position(1:2) = [left bottom];

%% refreshHeatmap
left = screenWidth*0.97;
bottom = screenHeight*0.10;
app.refreshHeatmap.Position(1:2) = [left bottom];


end