%{
On the Home tab, in the Variable section, click Import Data to import
CWB_Taipei_20150820Hourly.xlsx.
CWB_Taipei_20150820Hourly.xlsx is then converted into table
"CWBTaipei20150820Hourly" saved in the workspace.
%}

albedo = 0.26; %Suppose 台北觀測站 is an environment of short grass field
groundEmissivity = 0.95; %Suppose 台北觀測站 is an environment of short grass field
skyEmissivity = 0.65; %Distinguishable data of CWBTaipei20150820Hourly.SS01 is mainly 1
sb = 5.67 * 10^(-8); %Stefan-Boltzman constant

incidentShortwaveRadiation = CWBTaipei20150820Hourly.SS02 / 3600 * 10^6;
outgoingShortwaveRadiation = (-1) * incidentShortwaveRadiation * albedo;
incomingLongwaveRadiation = skyEmissivity * sb * (CWBTaipei20150820Hourly.TX01 + 273).^4;
outgoingLongwaveRadiation = (-1) * groundEmissivity * sb * (CWBTaipei20150820Hourly.TX01 + 273).^4;
netRadiation = (incidentShortwaveRadiation + outgoingShortwaveRadiation) + (incomingLongwaveRadiation + outgoingLongwaveRadiation);

plot(CWBTaipei20150820Hourly.yyyymmddhh, incidentShortwaveRadiation, CWBTaipei20150820Hourly.yyyymmddhh, outgoingShortwaveRadiation, CWBTaipei20150820Hourly.yyyymmddhh, incomingLongwaveRadiation, CWBTaipei20150820Hourly.yyyymmddhh, outgoingLongwaveRadiation, CWBTaipei20150820Hourly.yyyymmddhh, netRadiation);