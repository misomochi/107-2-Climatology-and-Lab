Jul_SO2 = [];
Jul_O3 = [];
Jul_PM25 = [];
Nov_SO2 = [];
Nov_O3 = [];
Nov_PM25 = [];

%July daily pollutant concentration average
for i = 0:30
    SO2 = [];
    for j = 0:23
        SO2 = [SO2, July{13 + i * 18, 4 + j}];
    end
    Jul_SO2 = [Jul_SO2, nanmean(SO2)];
end

for i = 0:30
    O3 = [];
    for j = 0:23
        O3 = [O3, July{8 + i * 18, 4 + j}];
    end
    Jul_O3 = [Jul_O3, nanmean(O3)];
end

for i = 0:30
    PM25 = [];
    for j = 0:23
        PM25 = [PM25, July{10 + i * 18, 4 + j}];
    end
    Jul_PM25 = [Jul_PM25, nanmean(PM25)];
end

%November hourly pollutant concentration average
for i = 0:29
    SO2 = [];
    for j = 0:23
        SO2 = [SO2, November{13 + i * 18, 4 + j}];
    end
    Nov_SO2 = [Nov_SO2, nanmean(SO2)];
end

for i = 0:29
    O3 = [];
    for j = 0:23
        O3 = [O3, November{8 + i * 18, 4 + j}];
    end
    Nov_O3 = [Nov_O3, nanmean(O3)];
end

for i = 0:29
    PM25 = [];
    for j = 0:23
        PM25 = [PM25, November{10 + i * 18, 4 + j}];
    end
    Nov_PM25 = [Nov_PM25, nanmean(PM25)];
end

subplot(2, 1, 1);
t1 = timeseries(Jul_SO2, 1:length(Jul_SO2));
t1.TimeInfo.Unit = "days";
t1.TimeInfo.StartDate = "00-Jul-2016";
t1.TimeInfo.Format = "dd mmm, yyyy";
plot(t1);

t2 = timeseries(Jul_O3, 1:length(Jul_O3));
t2.TimeInfo.Unit = "days";
t2.TimeInfo.StartDate = "00-Jul-2016";
t2.TimeInfo.Format = "dd mmm, yyyy";
hold on;
plot(t2);

t3 = timeseries(Jul_PM25, 1:length(Jul_PM25));
t3.TimeInfo.Unit = "days";
t3.TimeInfo.StartDate = "00-Jul-2016";
t3.TimeInfo.Format = "dd mmm, yyyy";
hold on;
plot(t3);

title('Daily average of SO2, O3, PM2.5 in July, 2016');
xlabel('dd mmm, yyyy');
ylabel('Concentration');
legend('SO_2 (ppb)', 'O_3 (ppb)', 'PM_{2.5} (μg/m^3)');

subplot(2, 1, 2);
t4 = timeseries(Nov_SO2, 1:length(Nov_SO2));
t4.TimeInfo.Unit = "days";
t4.TimeInfo.StartDate = "00-Nov-2016";
t4.TimeInfo.Format = "dd mmm, yyyy";
plot(t4);

t5 = timeseries(Nov_O3, 1:length(Nov_O3));
t5.TimeInfo.Unit = "days";
t5.TimeInfo.StartDate = "00-Nov-2016";
t5.TimeInfo.Format = "dd mmm, yyyy";
hold on;
plot(t5);

t6 = timeseries(Nov_PM25, 1:length(Nov_PM25));
t6.TimeInfo.Unit = "days";
t6.TimeInfo.StartDate = "00-Nov-2016";
t6.TimeInfo.Format = "dd mmm, yyyy";
hold on;
plot(t6);

title('Daily average of SO2, O3, PM2.5 in November, 2016');
xlabel('dd mmm, yyyy');
ylabel('Concentration');
legend('SO_2 (ppb)', 'O_3 (ppb)', 'PM_{2.5} (μg/m^3)');