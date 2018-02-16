% data presentation
%
% author: julia dohner


% h5disp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');

addpath(genpath('/Users/juliadohner/Documents/MATLAB/B_SIOC_221/OCO-2'));

clear all;

%% winter data


% data from January 15, 2015
DJF_date = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/date');
DJF_lat = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/latitude');
DJF_lon = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/longitude');
% Column-averaged dry-air CO2 mole frac (includes bias correction), in ppm
DJF_xco2 = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/xco2');
DJF_warnlvl = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/warn_level');
DJF_flag = h5read('oco2_LtCO2_150115_B8100r_171012042804s.nc4','/xco2_quality_flag');

% remove bad data
for i = 1:length(DJF_xco2)
    if DJF_warnlvl(i) > 15;
        DJF_xco2(i) = NaN;
    end
    if DJF_flag(i) == 1;
        DJF_xco2(i) = NaN;
    end
    
end

% separate NH from SH
DJF_NH_xco2 = DJF_xco2;
DJF_SH_xco2 = DJF_xco2;
for i = 1:length(DJF_xco2)
    if DJF_lat(i) >= 0
        DJF_SH_xco2(i) = NaN;
    else 
        DJF_NH_xco2(i) = NaN;
    end
end

DJF_NH_mean = nanmean(DJF_NH_xco2);
DJF_SH_mean = nanmean(DJF_SH_xco2);

figure
% co2 data by itself
subplot(2,1,1)
plot(DJF_xco2);
title('\fontsize{14}Plot of Jan Xco2 Data')
xlabel('\fontsize{12}index')
ylabel('\fontsize{12}ppm')

% lat vs lon
subplot(2,1,2)
plot(DJF_lon,DJF_lat,'.')
title('\fontsize{14}Plot of Jan Latitude vs. Longitude')
xlabel('\fontsize{12}degrees longitude')
ylabel('\fontsize{12}degrees latitude')

% co2 vs lat
figure
plot(DJF_xco2,DJF_lat,'.')
title('\fontsize{14}Plot of January Xco2 vs. Latitude')
ylabel('\fontsize{12}degrees latitude')
xlabel('\fontsize{12}ppm')

% % co2 vs lon
% subplot(2,2,4)
% plot(DJF_lon,DJF_xco2,'.')
% title('\fontsize{14}Plot of January Xco2 vs. Longitude')
% xlabel('\fontsize{12}degrees longitude')
% ylabel('\fontsize{12}ppm')

% pdf of co2 data
figure
histogram(DJF_xco2,'Normalization','pdf')
title('\fontsize{14}January PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

% pdf of NH
figure
histogram(DJF_NH_xco2,'Normalization','pdf')
title('\fontsize{14}Jan NH PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

% pdf of SH
figure
histogram(DJF_SH_xco2,'Normalization','pdf')
title('\fontsize{14}Jan SH PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

%% summer data

% data from July 15, 2015
% date data: year, month, day, hour, minute, second, milisecond
JJA_date = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/date');
JJA_lat = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/latitude');
JJA_lon = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/longitude');
% Column-averaged dry-air CO2 mole frac (includes bias correction), in ppm
JJA_xco2 = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/xco2');
JJA_warnlvl = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/warn_level');
JJA_flag = h5read('oco2_LtCO2_150715_B8100r_171009072652s.nc4','/xco2_quality_flag');

% remove bad data
for i = 1:length(JJA_xco2)
    if JJA_warnlvl(i) > 15
        JJA_xco2(i) = NaN;
    end
    if JJA_flag(i) == 1
        JJA_xco2(i) = NaN;
    end
    
end

% separate NH from SH
JJA_NH_xco2 = JJA_xco2;
JJA_SH_xco2 = JJA_xco2;
for i = 1:length(JJA_xco2)
    if JJA_lat(i) >= 0
        JJA_SH_xco2(i) = NaN;
    else 
        JJA_NH_xco2(i) = NaN;
    end
end

JJA_NH_mean = nanmean(JJA_NH_xco2);
JJA_SH_mean = nanmean(JJA_SH_xco2);

figure
% co2 data by itself
subplot(2,1,1)
plot(JJA_xco2);
title('\fontsize{14}Plot of July Xco2 Data')
xlabel('\fontsize{12}index')
ylabel('\fontsize{12}ppm')

% lat vs lon
subplot(2,1,2)
plot(JJA_lon,JJA_lat,'.')
title('\fontsize{14}Plot of July Latitude vs. Longitude')
xlabel('\fontsize{12}degrees longitude')
ylabel('\fontsize{12}degrees latitude')

% co2 vs lat
figure
plot(JJA_xco2,JJA_lat,'.')
title('\fontsize{14}Plot of July Xco2 vs. Latitude')
ylabel('\fontsize{12}degrees latitude')
xlabel('\fontsize{12}ppm')

% % co2 vs lon
% subplot(2,2,4)
% plot(JJA_lon,JJA_xco2,'.')
% title('\fontsize{14}Plot of July Xco2 vs. Longitude')
% xlabel('\fontsize{12}degrees longitude')
% ylabel('\fontsize{12}ppm')

% pdf of co2 data
figure
histogram(JJA_xco2,'Normalization','pdf')
title('\fontsize{14}July PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

% pdf of NH
figure
histogram(JJA_NH_xco2,'Normalization','pdf')
%to draw a line from (x1,y1) to (x2,y2)
hold on
line([JJA_NH_mean JJA_NH_mean], [0 0.35])
title('\fontsize{14}July NH PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

% pdf of SH
figure
histogram(JJA_SH_xco2,'Normalization','pdf')
%to draw a line from (x1,y1) to (x2,y2)
hold on
line([JJA_SH_mean JJA_SH_mean], [0 0.6])
title('\fontsize{14}July SH PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

