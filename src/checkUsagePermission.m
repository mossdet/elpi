function permits = checkUsagePermission()

    permits = checkForPermits();

    pc = thisCompInfo();

    if ~isempty(permits)
        delete('specs.txt');
    else
        thisComputerSpecs = table({pc.MAC}, {pc.osName}, {pc.RAM}, 'VariableNames', { 'A', 'B', 'C'});
        writetable(thisComputerSpecs, 'specs.txt');
    end

    outStr = strcat(pc.MAC, ", ", pc.osName, ", ", num2str(pc.RAM), ", ");
    disp(outStr);
end

%% heck for permits
function permits = checkForPermits()

    approvedComps = approvedCompsList();
    nrApprovedComps = size(approvedComps,1);
    thisPC = thisCompInfo();

    permits = [];
    for aci = 1:nrApprovedComps
        compFound = (...
            strcmp(thisPC.MAC, approvedComps{aci}.MAC) &&...
            strcmp(thisPC.osName, approvedComps{aci}.osName) && ...
            thisPC.RAM == approvedComps{aci}.RAM && ...
            true());
                
        if compFound
            permits = approvedComps{aci}.permits;
            break;
        end
    end


end

%% This computer info
function pc = thisCompInfo()
    [status,result] = dos('getmac');
    if status == 0
        thisMAC = result(160:176);
    end
    thisComputerName = getenv('COMPUTERNAME');
    [user,sys] = memory;
    thisRAM = ceil(sys.PhysicalMemory.Total/1000000000);

    pc.Label = 'This Comp';
    pc.MAC = thisMAC;
    pc.osName = thisComputerName;
    pc.RAM = thisRAM;
    pc.permits.generalUse = false();
    pc.permits.annotsMenu = false();
    pc.permits.profilesMenu = false();
    pc.permits.newAnnots = false();
    pc.permits.detect = false();
    pc.permits.reports = false();
    pc.permits.artfctRmvl = false();

end

%% List of allowed computers
function approvedComps = approvedCompsList()

    approvedComps = {};
    
    pc.Label = 'Lenovo IdepadGaming3';
    pc.MAC = '8C-8C-AA-E1-9B-A2';
    pc.osName = 'LAPTOP-TFQFNF6U';
    pc.RAM = 34;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);
    
    pc.Label = 'VM Win10';
    pc.MAC = '08-00-27-0D-48-43';
    pc.osName = 'WIN10';
    pc.RAM = 9;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);
    
    pc.Label = 'Alienware';
    pc.MAC = 'CC-96-E5-81-0D-4B';
    pc.osName = 'DLP';
    pc.RAM = 69;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);

    pc.Label = 'Minette_HP';
    pc.MAC = 'A0-E7-0B-67-8D-65';
    pc.osName = 'LAPTOP-5D668HJL';
    pc.RAM = 34;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);

    pc.Label = 'HP Envy Maggi';
    pc.MAC = '00-FF-FD-FF-66-3B';
    pc.osName = 'HFO2LAPTOP';
    pc.RAM = 35;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);

    pc.Label = 'Dell Maria Petryk';
    pc.MAC = '00-09-0F-FE-00-01';
    pc.osName = 'MED-C28884';
    pc.RAM = 16;
    pc.permits.generalUse = true();
    pc.permits.annotsMenu = true();
    pc.permits.profilesMenu = true();
    pc.permits.newAnnots = true();
    pc.permits.detect = true();
    pc.permits.reports = true();
    pc.permits.artfctRmvl = true();
    approvedComps = cat(1, approvedComps, pc);

end
