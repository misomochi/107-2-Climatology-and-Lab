SD_Pdiff = std(reshape(TahitiMeanSeaLevelPressure{58:117, 2:13}', 1, []) - reshape(DarwinMeanSeaLevelPressure{58:117, 2:13}', 1, [])); %long term standard deviation of Pdiff from 1933 ~ 1992
Pdiffav = sum(reshape(TahitiMeanSeaLevelPressure{58:117, 2:13}', 1, []) - reshape(DarwinMeanSeaLevelPressure{58:117, 2:13}', 1, [])) / length(reshape(TahitiMeanSeaLevelPressure{58:117, 2:13}', 1, [])); %long term average of Pdiff from 1933 ~ 1992

SOI = 10 * (reshape(TahitiMeanSeaLevelPressure{105:144, 2:13}', 1, []) - reshape(DarwinMeanSeaLevelPressure{105:144, 2:13}', 1, []) - Pdiffav) ./ SD_Pdiff; %southern oscillation index(SOI)

t = timeseries(SOI, 1:length(SOI));
t.Name = 'Southern Oscillation Index(SOI)';
t.TimeInfo.Units = 'months';
t.TimeInfo.StartDate = '01-Jan-1980';
t.TimeInfo.Format = 'mmm, yyyy';
plot(t);
xlabel('Time(mmm, yyyy)');
yline(0);