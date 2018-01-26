% SIOC 221B - HW 1
% January 15, 2018
% Julia Dohner
%
% First look at OCO-2 data

% h5disp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');

addpath(genpath('/Users/juliadohner/Documents/MATLAB/B_SIOC_221/OCO-2'));

clear all;

lat = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');
lon = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/longitude');
% Column-averaged dry-air CO2 mole frac (includes bias correction), in ppm
xco2 = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/xco2');
windspeed = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/Retrieval/windspeed');
tcwv = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/Retrieval/tcwv'); % total column water vapor

for i = 1:length(windspeed)
    if windspeed(i) == -999999;
        windspeed(i) = NaN;
    end
    if tcwv(i) == -999999;
        tcwv(i) = NaN;
    end
end



figure
% co2 data by itself
subplot(2,2,1)
plot(xco2);
title('\fontsize{14}Plot of Xco2 Data')
xlabel('\fontsize{12}index')
ylabel('\fontsize{12}ppm')

% lat vs lon
subplot(2,2,3)
plot(lat,lon,'.')
title('\fontsize{14}Plot of Latitude vs. Longitude')
xlabel('\fontsize{12}degrees latitude')
ylabel('\fontsize{12}degrees longitude')

% co2 vs lat
subplot(2,2,2)
plot(lat,xco2,'.')
title('\fontsize{14}Plot of Xco2 vs. Latitude')
xlabel('\fontsize{12}degrees latitude')
ylabel('\fontsize{12}ppm')

% co2 vs lon
subplot(2,2,4)
plot(lon,xco2,'.')
title('\fontsize{14}Plot of Xco2 vs. Longitude')
xlabel('\fontsize{12}degrees longitude')
ylabel('\fontsize{12}ppm')

% pdf of co2 data
figure
histogram(xco2,'Normalization','pdf')
title('\fontsize{14}PDF of Xco2 Data')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

%% HW 2

% calculate PDF with different bin widths
figure
subplot(3,1,1)
histogram(xco2,10,'Normalization','pdf')
title('\fontsize{14}PDF of Xco2 Data - 10 Bins')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

subplot(3,1,2)
histogram(xco2,100,'Normalization','pdf')
title('\fontsize{14}PDF of Xco2 Data - 100 Bins')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

subplot(3,1,3)
histogram(xco2,1000,'Normalization','pdf')
title('\fontsize{14}PDF of Xco2 Data - 1000 Bins')
xlabel('\fontsize{12}ppm')
ylabel('\fontsize{12}probability')

% The PDF tells me the mean, the variance, and the skewedness of the data.

% calculating a joint PDF of two of the variables:

X = windspeed;
Y = xco2;

MIN1 = min(X)

MAX1 = max(X)

MIN2 = min(Y)

MAX2 = max(Y)

%x_axis = MIN1:1:MAX1; % Define edges of bins for x axis. Column vector
%y_axis = MIN2:1:MAX2; % Same for y axis

%// Compute and plot pdf
figure
subplot(2,2,1)
histogrhistogram2(X, Y, 100, 'Normalization', 'pdf')
am2(X, Y, 100, 'Normalization', 'pdf')

%// Compute and plot cdf
subplot(2,2,2)
histogram2(X, Y, x_axis, y_axis, 'Normalization', 'cdf')

figure
subplot(2,2,3)
histogram2(X, Y, x_axis, y_axis, 'Normalization', 'pdf')

%// Compute and plot cdf
subplot(2,2,4)
histogram2(X, Y, x_axis, y_axis, 'Normalization', 'cdf')

% calculate mean and moments of a few variables