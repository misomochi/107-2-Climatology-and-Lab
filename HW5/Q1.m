%0203 hourly lifting condensation level
liftingCondensationLevel0203 = 125 * (CWBTaipei20150203Hourly.TX01 - CWBTaipei20150203Hourly.TX05); %H = 125 * (T - T_d)

%0820 hourly lifting condensation level
vaporPressure0820 = CWBTaipei20150820Hourly.RH01 / 100 .* arrayfun(@svp, CWBTaipei20150820Hourly.TX01); %ambient vapor pressure(kPa) = relative humidity * saturation vapor pressure
dewPointTemperature0820 = arrayfun(@dpt, vaporPressure0820); %ambient dew point temperature
liftingCondensationLevel0820 = 125 * (CWBTaipei20150820Hourly.TX01 - dewPointTemperature0820); %H = 125 * (T - T_d)

subplot(2, 1, 1);
plot(CWBTaipei20150203Hourly.yyyymmddhh, liftingCondensationLevel0203, '-o', 'Linewidth', 2.0);
title('0203 Hourly Condensation Level');
xlabel('Time(yyyymmdd)');
ylabel('Height(m)');

subplot(2, 1, 2);
plot(CWBTaipei20150820Hourly.yyyymmddhh, liftingCondensationLevel0820, '-o', 'Linewidth', 2.0);
title('0820 Hourly Condensation Level');
xlabel('Time(yyyymmdd)');
ylabel('Height(m)');

function y = svp(T) %saturation vapor pressure equation
y = 0.611 * exp(17.5 * T / (240.97 + T));
end

function y = dpt(e) %dew point temperature equation
y = 240.97 * log(e / 0.611) / (17.5 - log(e / 0.611));
end