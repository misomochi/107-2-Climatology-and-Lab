% import data CWB_Taipei_20150203Hourly.xlsx & CWB_Taipei_20150820Hourly.xlsx

gamma = 6.66*10^(-4); % thermodynamic psychrometer constant

% 20150820 露點溫度 & 水氣壓
vaporPressure0820 = CWBTaipei20150820Hourly.RH01 / 100 .* arrayfun(@svp, CWBTaipei20150820Hourly.TX01); % ambient vapor pressure(kPa) = relative humidity * saturation vapor pressure
dewPointTemperature0820 = arrayfun(@dpt, vaporPressure0820); % ambient dew point temperature

% 20150203 相對濕度 & 水氣壓
vaporPressure0203 = arrayfun(@svp, CWBTaipei20150203Hourly.TX05); % ambient vapor pressure(kPa) differentiated from dew point temperature
relativeHumidity0203 = vaporPressure0203 ./ arrayfun(@svp, CWBTaipei20150203Hourly.TX01) * 100; % relative humidity(%) = ambient vapor pressure / saturation vapor pressure

% 20150820 wet bulb temperature
t1 = sym('t1_', [24, 1]); % column of symbolic variables
eqn1 = vaporPressure0820 == arrayfun(@svp, t1) - gamma .* CWBTaipei20150820Hourly.PS01 .* (CWBTaipei20150820Hourly.TX01 - t1); % e_a = e_s(T_w) - γp_a(T_a - T_w)
wetBulbTemperature0820 = struct2array(vpasolve(eqn1, t1));

% 20150203 wet bulb temperature
t2 = sym('t2_', [24, 1]); % column of symbolic variables
eqn2 = vaporPressure0203 == arrayfun(@svp, t2) - gamma .* CWBTaipei20150203Hourly.PS01 .* (CWBTaipei20150203Hourly.TX01 - t2); % e_a = e_s(T_w) - γp_a(T_a - T_w)
wetBulbTemperature0203 = struct2array(vpasolve(eqn2, t2));

% Plot
subplot(3, 1, 1)
plot(CWBTaipei20150820Hourly.yyyymmddhh, dewPointTemperature0820);
ylabel('Dew Point Temperature(\circC)');
yyaxis right;
plot(CWBTaipei20150820Hourly.yyyymmddhh, vaporPressure0820 * 10); % transform the unit from kPa to hPa
ylabel('Vapor Pressure(hPa)');
title('圖1：20150820臺北測站逐時露點溫度與水氣壓');
xlabel('Time(yyymmddhh)');
legend('20150820 Dew Point Temperature', '20150820 Vapor Pressure');

subplot(3, 1, 2)
plot(CWBTaipei20150203Hourly.yyyymmddhh, relativeHumidity0203);
ylabel('Relative Humidity(%)');
yyaxis right;
plot(CWBTaipei20150203Hourly.yyyymmddhh, vaporPressure0203 * 10); % transform the unit from kPa to hPa
ylabel('Vapor Pressure(hPa)');
title('圖2：20150203臺北測站逐時相對濕度與水氣壓');
xlabel('Time(yyyymmddhh)');
legend('20150203 Relative Humidity', '20150203 Vapor Pressure');

subplot(3, 1, 3)
x = linspace(1, 24, 24);
plot(x, wetBulbTemperature0203', x, wetBulbTemperature0820');
title('圖3：20150203與20150820臺北測站逐時濕球溫度');
xlabel('Time(hr)');
ylabel('Wet Bulb Temperature(\circC)');
legend('20150203 Wet Bulb Temperature', '20150820 Wet Bulb Temperature');

function y = svp(T) % saturation vapor pressure equation
y = 0.611 * exp(17.5 * T / (240.97 + T));
end

function y = dpt(e) % dew point temperature equation
y = 240.97 * log(e / 0.611) / (17.5 - log(e / 0.611));
end
