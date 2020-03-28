AQI = [];
count = 0;

for i = 0:29
    O3_total = 0;
    CO_total = 0;
    PM25_12 = 0; PM25_4 = 0;
    PM10_12 = 0; PM10_4 = 0;
    
    %O3 (unit: ppb)
    count_0 = 0;
    for j = 0:7
        if ~isnan(Daliao{8 + i * 18, 10 + j})
            O3_total = O3_total + Daliao{8 + i * 18, 10 + j};
            count_0 = count_0 + 1;
        else
            O3_total = O3_total + 0;
            count_0 = count_0 + 0;
        end
    end
    if count_0 == 0
        O3_8hr = 0;
    else
        O3_8hr = O3_total / (count_0 * 10^3); %(unit: ppm)
    end
    
    if ~isnan(Daliao{8 + i * 18, 18})
        O3 = Daliao{8 + i * 18, 18} / 10^3; %(unit: ppm)
    else
        O3 = 0;
    end
    
    %O3 AQI
    if O3_8hr <= 0.054
        O3_AQI = 50 / 0.054 * O3_8hr; %AQI: 0~50
    elseif O3_8hr > 0.054 && O3_8hr <= 0.07
        O3_AQI = (100 - 51) / (0.07 - 0.055) * (O3_8hr - 0.055) + 51; %AQI: 51~100
    elseif (O3_8hr > 0.07 && O3_8hr <= 0.085) && (O3 >= 0.125 && O3 <= 0.164)
        O3_8hr_aqi = (150 - 101) / (0.085 - 0.071) * (O3_8hr - 0.071) + 101;
        O3_aqi = (150 - 101) / (0.164 - 0.125) * (O3 - 0.125) + 101;
        if O3_8hr_aqi > O3_aqi
            O3_AQI = O3_8hr_aqi;
        else
            O3_AQI = O3_aqi; %AQI: 101~150
        end
    elseif (O3_8hr > 0.085 && O3_8hr <= 0.105) && (O3 > 0.164 && O3 <= 0.204)
        O3_8hr_aqi = (200 - 151) / (0.105 - 0.086) * (O3_8hr - 0.086) + 151;
        O3_aqi = (200 - 151) / (0.204 - 0.165) * (O3 - 0.165) + 151;
        if O3_8hr_aqi > O3_aqi
            O3_AQI = O3_8hr_aqi;
        else
            O3_AQI = O3_aqi; %AQI: 151~200
        end
    elseif (O3_8hr > 0.105 && O3_8hr <= 0.2) && (O3 > 0.204 && O3 <= 0.404)
        O3_8hr_aqi = (300 - 201) / (0.2 - 0.106) * (O3_8hr - 0.106) + 201;
        O3_aqi = (300 - 201) / (0.404 - 0.205) * (O3 - 0.205) + 201;
        if O3_8hr_aqi > O3_aqi
            O3_AQI = O3_8hr_aqi;
        else
            O3_AQI = O3_aqi; %AQI: 201~300
        end
    elseif O3 > 0.404 && O3 <= 0.504
        O3_AQI = (400 - 301) / (0.504 - 0.405) * (O3 - 0.405) + 301; %AQI: 301~400
    elseif O3 > 0.504 && O3 <= 0.604
        O3_AQI = (500 - 401) / (0.604 - 0.505) * (O3 - 0.505) + 401; %AQI: 401~500
    elseif O3 > 0.604
        O3_AQI = 500;
    end
    
    %PM2.5 (unit: μg / m^3)
    count_1 = 0;
    for j = 0:11
        if ~isnan(Daliao{10 + i * 18, 6 + j})
            PM25_12 = PM25_12 + Daliao{10 + i * 18, 6 + j};
            count_1 = count_1 + 1;
        else
            PM25_12 = PM25_12 + 0;
            count_1 = count_1 + 0;
        end
    end
    count_2 = 0;
    for j = 0:3
        if ~isnan(Daliao{10 + i * 18, 14 + j})
            PM25_4 = PM25_4 + Daliao{10 + i * 18, 14 + j};
            count_2 = count_2 + 1;
        else
            PM25_4 = PM25_4 + 0;
            count_2 = count_2 + 0;
        end
    end
    if count_1 == 0 || count_2 == 0
        PM25 = 0;
    else
        PM25 = 0.5 * (PM25_12 / count_1 + PM25_4 / count_2);
    end
    
    %PM2.5 AQI
    if PM25 <= 15.4
        PM25_AQI = 50 / 15.4 * PM25;
    elseif PM25 > 15.4 && PM25 <= 35.4
        PM25_AQI = (100 - 51) / (35.4 - 15.5) * (PM25 - 15.5) + 51;
    elseif PM25 > 35.4 && PM25 <= 54.4
        PM25_AQI = (150 - 101) / (54.4 - 35.5) * (PM25 - 35.5) + 101;
    elseif PM25 > 54.4 && PM25 <= 150.4
        PM25_AQI = (200 - 151) / (150.4 - 54.5) * (PM25 - 54.5) + 151;
    elseif PM25 > 150.4 && PM25 <= 250.4
        PM25_AQI = (300 - 201) / (250.4 - 150.5) * (PM25 - 150.5) + 201;
    elseif PM25 > 250.4 && PM25 <= 350.4
        PM25_AQI = (400 - 301) / (350.4 - 250.5) * (PM25 - 250.5) + 301;
    elseif PM25 > 350.4 && PM25 <= 500.4
        PM25_AQI = (500 - 401) / (500.4 - 350.5) * (PM25 - 350.5) + 401;
    elseif PM25 > 500.4
        PM25_AQI = 500;
    end
    
    %PM10 (unit: μg / m^3)
    count_3 = 0;
    for j = 0:11
        if ~isnan(Daliao{9 + i * 18, 6 + j})
            PM10_12 = PM10_12 + Daliao{9 + i * 18, 6 + j};
            count_3 = count_3 + 1;
        else
            PM10_12 = PM10_12 + 0;
            count_3 = count_3 + 0;
        end
    end
    count_4 = 0;
    for j = 0:3
        if ~isnan(Daliao{9 + i * 18, 14 + j})
            PM10_4 = PM10_4 + Daliao{9 + i * 18, 14 + j};
            count_4 = count_4 + 1;
        else
            PM10_4 = PM10_4 + 0;
            count_4 = count_4 + 0;
        end
    end
    if count_3 == 0 || count_4 == 0
        PM10 = 0;
    else
        PM10 = 0.5 * (PM10_12 / count_3 + PM10_4 / count_4);
    end
    
    %PM10 AQI
    if PM10 <= 54
        PM10_AQI = 50 / 54 * PM10;
    elseif PM10 > 54 && PM10 <= 125
        PM10_AQI = (100 - 51) / (125 - 55) * (PM10 - 55) + 51;
    elseif PM10 > 125 && PM10 <= 254
        PM10_AQI = (150 - 101) / (254 - 126) * (PM10 - 126) + 101;
    elseif PM10 > 254 && PM10 <= 354
        PM10_AQI = (200 - 151) / (354 - 255) * (PM10 - 255) + 151;
    elseif PM10 > 354 && PM10 <= 424
        PM10_AQI = (300 - 201) / (424 - 355) * (PM10 - 355) + 201;
    elseif PM10 > 424 && PM10 <= 504
        PM10_AQI = (400 - 301) / (504 - 425) * (PM10 - 425) + 301;
    elseif PM10 > 504 && PM10 <= 604
        PM10_AQI = (500 - 401) / (604 - 505) * (PM10 - 505) + 401;
    elseif PM10 > 604
        PM10_AQI = 500;
    end
    
    %CO (unit: ppm)
    count_5 = 0;
    for j = 0:7
        if ~isnan(Daliao{3 + i * 18, 10 + j})
            CO_total = CO_total + Daliao{3 + i * 18, 10 + j};
            count_5 = count_5 + 1;
        else
            CO_total = CO_total + 0;
            count_5 = count_5 + 0;
        end
    end
    if count_5 == 0
        CO =0;
    else
        CO = CO_total / count_5;
    end
    
    %CO AQI
    if CO <= 4.4
        CO_AQI = 50 / 4.4 * CO;
    elseif CO > 4.4 && CO <= 9.4
        CO_AQI = (100 - 51) / (9.4 - 4.5) * (CO - 4.5) + 51;
    elseif CO > 9.4 && CO <= 12.4
        CO_AQI = (150 - 101) / (12.4 - 9.5) * (CO - 9.5) + 101;
    elseif CO > 12.4 && CO <= 15.4
        CO_AQI = (200 - 151) / (15.4 - 12.5) * (CO - 12.5) + 151;
    elseif CO > 15.4 && CO <= 30.4
        CO_AQI = (300 - 201) / (30.4 - 15.5) * (CO - 15.5) + 201;
    elseif CO > 30.4 && CO <= 40.4
        CO_AQI = (400 - 301) / (40.4 - 30.5) * (CO - 30.5) + 301;
    elseif CO > 40.4 && CO <= 50.4
        CO_AQI = (500 - 401) / (50.4 - 40.5) * (CO - 40.5) + 401;
    elseif CO > 50.4
        CO_AQI = 500;
    end
    
    %SO2 (unit: ppb)
    if ~isnan(Daliao{13 + i * 18, 18})
        SO2 = Daliao{13 + i * 18, 18};
    else
        SO2 = 0;
    end
    
    %SO2 AQI
    if SO2 <= 35
        SO2_AQI = 50 / 35 * SO2;
    elseif SO2 > 35 && SO2 <= 75
        SO2_AQI = (100 - 51) / (75 - 36) * (SO2 - 36) + 51;
    elseif SO2 > 75 && SO2 <= 185
        SO2_AQI = (150 - 101) / (185 - 76) * (SO2 - 76) + 101;
    elseif SO2 > 185 && SO2 <= 304
        SO2_AQI = (200 - 151) / (304 - 186) * (SO2 - 186) + 151;
    elseif SO2 > 304 && SO2 <= 604
        SO2_AQI = (300 - 201) / (604 - 305) * (SO2 - 305) + 201;
    elseif SO2 > 604 && SO2 <= 804
        SO2_AQI = (400 - 301) / (804 - 605) * (SO2 - 605) + 301;
    elseif SO2 > 804 && SO2 <= 1004
        SO2_AQI = (500 - 401) / (1004 - 805) * (SO2 - 805) + 401;
    elseif SO2 > 1004
        SO2_AQI = 500;
    end
    
    %NO2 (unit: ppb)
    if ~isnan(Daliao{6 + i * 18, 18})
        NO2 = Daliao{6 + i * 18, 18};
    else
        NO2 = 0;
    end
    
    %NO2 AQI
    if NO2 <= 53
        NO2_AQI = 50 / 53 * NO2;
    elseif NO2 > 53 && NO2 <= 100
        NO2_AQI = (100 - 51) / (100 - 54) * (NO2 - 54) + 51;
    elseif NO2 > 100 && NO2 <= 360
        NO2_AQI = (150 - 101) / (360 - 101) * (NO2 - 101) + 101;
    elseif NO2 > 360 && NO2 <= 649
        NO2_AQI = (200 - 151) / (649 - 361) * (NO2 - 361) + 151;
    elseif NO2 > 649 && NO2 <= 1249
        NO2_AQI = (300 - 201) / (1249 - 650) * (NO2 - 650) + 201;
    elseif NO2 > 1249 && NO2 <= 1649
        NO2_AQI = (400 - 301) / (1649 - 1250) * (NO2 - 1250) + 301;
    elseif NO2 > 1649 && NO2 <= 2049
        NO2_AQI = (500 - 401) / (2049 - 1650) * (NO2 - 1650) + 401;
    elseif NO2 > 2049
        NO2_AQI = 500;
    end
    
    aqi = max([O3_AQI, PM25_AQI, PM10_AQI, CO_AQI, SO2_AQI, NO2_AQI]);
    if aqi >= 100
        count = count + 1;
        disp(i + 1);
        disp(count);
        disp([O3_AQI, PM25_AQI, PM10_AQI, CO_AQI, SO2_AQI, NO2_AQI]);
    end
    
    AQI = [AQI, aqi];
    
end

t = timeseries(AQI, 1:length(AQI));
t.Name = '2016年11月大寮每日14:00即時空氣品質指標';
t.TimeInfo.Units = 'days';
t.TimeInfo.StartDate = '00-Nov-2016';
t.TimeInfo.Format = 'mmm dd, yyyy';
plot(t);
xlabel("Time(mmm dd, yyyy)");
ylabel("AQI");
yline(100);