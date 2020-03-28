% Import data 'Chiayi0301~0306.xlsx' & 'Chiayi05001400.xlsx'

% time of day in hours
t1 = 1 : 5;
t2 = 6 : 14;
t3 = 15 : 24;

march1st = [gammaArray(t1)' * [Chiayi05001400.VarName2(2); Chiayi05001400.VarName3(1)];
            gammaArray(t2)' * [Chiayi05001400.VarName3(2); Chiayi05001400.VarName3(1)];
            gammaArray(t3)' * [Chiayi05001400.VarName3(2); Chiayi05001400.VarName4(1)]];
march2nd = [gammaArray(t1)' * [Chiayi05001400.VarName3(2); Chiayi05001400.VarName4(1)];
            gammaArray(t2)' * [Chiayi05001400.VarName4(2); Chiayi05001400.VarName4(1)];
            gammaArray(t3)' * [Chiayi05001400.VarName4(2); Chiayi05001400.VarName5(1)]];
march3rd = [gammaArray(t1)' * [Chiayi05001400.VarName4(2); Chiayi05001400.VarName5(1)];
            gammaArray(t2)' * [Chiayi05001400.VarName5(2); Chiayi05001400.VarName5(1)];
            gammaArray(t3)' * [Chiayi05001400.VarName5(2); Chiayi05001400.VarName6(1)]];
march4th = [gammaArray(t1)' * [Chiayi05001400.VarName5(2); Chiayi05001400.VarName6(1)];
            gammaArray(t2)' * [Chiayi05001400.VarName6(2); Chiayi05001400.VarName6(1)];
            gammaArray(t3)' * [Chiayi05001400.VarName6(2); Chiayi05001400.VarName7(1)]];
march5th = [gammaArray(t1)' * [Chiayi05001400.VarName6(2); Chiayi05001400.VarName7(1)];
            gammaArray(t2)' * [Chiayi05001400.VarName7(2); Chiayi05001400.VarName7(1)];
            gammaArray(t3)' * [Chiayi05001400.VarName7(2); Chiayi05001400.VarName8(1)]];

marchHourlyChange = [march1st; march2nd; march3rd; march4th; march5th];

T = linspace(1, 120, 120);
plot(T, Chiayi03010306.Temperature, T, marchHourlyChange);
ylabel('Temperature(\circC)');
yyaxis right;
plot(T, abs(marchHourlyChange - Chiayi03010306.Temperature) / Chiayi03010306.Temperature); % similarity between the two plots
legend('Measured hourly temperature', 'Equation differentiated hourly temperature', 'Similarity');

h = findobj(gca,'Type','line'); % to remove the asterisks on the x-axis
set(h,'Marker','none');

function y = gamma(t)
y = 0.44 - 0.46 * sin(pi/12 * t + 0.9) + 0.11 * sin(pi/6 * t + 0.9);
end

function y = gammaArray(t)
y = [gamma(t); 1-gamma(t)];
end