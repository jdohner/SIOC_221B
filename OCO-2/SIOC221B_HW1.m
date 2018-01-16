% SIOC 221B - HW 1
% January 15, 2018
% Julia Dohner
%
% First look at OCO-2 data

% h5disp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');

clear all;

lat = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');
lon = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');

% Column-averaged dry-air mole fraction of CO2 (includes bias correction)
% units: ppm
% This variable expresses the column-averaged CO2 dry air mole fraction for
% a sounding. Those soundings that did not converge will not be present. 
% These values have units of mol/mol. This can easily be converted to ppm 
% by multiplying by 106.
xco2 = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/xco2');

%% TODO: stuck here. 
% What I want to do is plot a meshgrid of all lat/lon points, then plot the
% xco2 data I have (assuming that the datapoints in the 48,170-long vector
% align with the corresponding lat and lon values (also 48,170-long
% vectors)

% open to other ideas on plotting


% lonGrid = -180:0.001:180;
% latGrid = -90:0.001:90;

% truncating data to make smaller files
lat2 = lat(1:1000);
lon2 = lon(1:1000);
xco2_2 = xco2(1:1000);

% meshgrid of all lat values, lon values
% then make colorbar for co2 value
[X,Y] = meshgrid(-180:1:180);
figure('name','3D Plot', 'NumberTitle','off')
surfc(X, Y, xco2_2); % does xco2_2 here need to have lat and lon as first 2 columns?
colorbar()
axesm utm
grid on
hold on
legend()


% Notes from Dillon:
% snctools is toolbox dillon uses
% nc_varget
% ncdisp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');