%{
On the Home tab, in the Variable section, click Import Data to import
CWB_Taipei_20150203Hourly.xlsx.
CWB_Taipei_20150203Hourly.xlsx is then converted into table
"CWBTaipei20150203Hourly" saved in the workspace.
%}

albedo = 0.26; %Suppose 台北觀測站 is an environment of short grass field
groundEmissivity = 0.95; %Suppose 台北觀測站 is an environment of short grass field
skyEmissivity = 0.85; %Distinguishable data of CWBTaipei20150203Hourly.SS01 is mainly 0
sb = 5.67 * 10^(-8); %Stefan-Boltzman constant

incidentShortwaveRadiation = CWBTaipei20150203Hourly.SS02 / 3600 * 10^6;
outgoingShortwaveRadiation = (-1) * incidentShortwaveRadiation * albedo;
incomingLongwaveRadiation = skyEmissivity * sb * (CWBTaipei20150203Hourly.TX01 + 273).^4;
outgoingLongwaveRadiation = (-1) * groundEmissivity * sb * (CWBTaipei20150203Hourly.TX01 + 273).^4;
energyGain = abs(incidentShortwaveRadiation + outgoingShortwaveRadiation);
energyLoss = abs(incomingLongwaveRadiation + outgoingLongwaveRadiation);

plot(CWBTaipei20150203Hourly.yyyymmddhh, CWBTaipei20150203Hourly.TX01);
ylabel('Temperature(\circC)');
yyaxis right;
plot(CWBTaipei20150203Hourly.yyyymmddhh, energyGain, CWBTaipei20150203Hourly.yyyymmddhh, energyLoss);
ylabel('Energy(W/m^2)');
legend('Temperature', 'Energy gained', 'Energy lost');