% SIOC 221B - HW 1 & 2
% January 15, 2018
% Julia Dohner
%
% First look at OCO-2 data

% h5disp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');

addpath(genpath('/Users/juliadohner/Documents/MATLAB/B_SIOC_221/OCO-2'));

clear all;

% data from September 6, 2014
% date data: year, month, day, hour, minute, second, milisecond
date = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/date');
lat = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');
lon = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/longitude');
% Column-averaged dry-air CO2 mole frac (includes bias correction), in ppm
xco2 = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/xco2');
windspeed = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/Retrieval/windspeed');
tcwv = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/Retrieval/tcwv'); % total column water vapor
warnlvl = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/warn_level');
flag = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/xco2_quality_flag');


%% remove bad data

for i = 1:length(xco2)
    if warnlvl(i) > 15;
        xco2(i) = NaN;
    end
    if flag(i) == 1;
        xco2(i) = NaN;
    end
    if windspeed(i) == -999999;
        windspeed(i) = NaN;
    end
    if tcwv(i) == -999999;
        tcwv(i) = NaN;
    end
    
end



%%

figure
% co2 data by itself
subplot(2,2,1)
plot(xco2);
title('\fontsize{14}Plot of Xco2 Data')
xlabel('\fontsize{12}index')
ylabel('\fontsize{12}ppm')

figure
pcolor(lon, lat, xco2)
caxis([-1 1])
%colorbar
[cmap] = cbrewer('div', 'RdBu', 50);
colormap(cmap);
h = colorbar;
shading flat

title('Along Channel Velocity CW(m/s)')

% lat vs lon
subplot(2,2,3)
plot(lon,lat,'.')
title('\fontsize{14}Plot of Latitude vs. Longitude')
xlabel('\fontsize{12}degrees longitude')
ylabel('\fontsize{12}degrees latitude')

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

% Compute and plot pdf
figure
subplot(3,1,1)
histogram2(X, Y, 10, 'Normalization', 'pdf')
title('\fontsize{14}Joint PDF of Xco2 vs. windspeed - 10 Bins')
xlabel('\fontsize{12}windspeed')
ylabel('\fontsize{12}ppm co2')

subplot(3,1,2)
histogram2(X, Y, 100,'Normalization', 'pdf')
title('\fontsize{14}Joint PDF of Xco2 vs. windspeed - 100 Bins')
xlabel('\fontsize{12}windspeed')
ylabel('\fontsize{12}ppm co2')

subplot(3,1,3)
histogram2(X, Y, 1000,'Normalization', 'pdf')
title('\fontsize{14}Joint PDF of Xco2 vs. windspeed - 1000 Bins')
xlabel('\fontsize{12}windspeed')
ylabel('\fontsize{12}ppm co2')

% It seems as though the two are not correlated - that you have the same
% amount of co2 over a range of windspeeds. It does seem that in areas of
% lower windspeed there is a range in xco2 though, which does not appear at
% higher windspeeds, where co2 remains between 385 and 400 ppm. I'd say
% that they are dependent (windspeed certainly has some influence on local 
% levels co2) but that they are not correlated. There's some relationship
% between the two variables as seen when viewing the joint PDFs from above
% (not a mess of points in the middle) but there's no positive or negative
% relationship (the line of data is mostly flat), indicating that they're
% not correlated.


% calculate mean and a few moments of variables

% 0th moment - mean xco2
mean = mean(xco2);

% 1st moment - variance xco2
variance = var(xco2);

% 2nd moment - skewness xco2
skew = skewness(xco2);

