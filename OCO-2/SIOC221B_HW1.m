% SIOC 221B - HW 1
% January 15, 2018
% Julia Dohner
%
% First look at OCO-2 data

clear all;

%A = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/Retrieval/xco2_raw');
latData = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');
lonData = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/latitude');

% Column-averaged dry-air mole fraction of CO2 (includes bias correction)
% units: ppm
% This variable expresses the column-averaged CO2 dry air mole fraction for
% a sounding. Those soundings that did not converge will not be present. 
% These values have units of mol/mol. This can easily be converted to ppm 
% by multiplying by 106.
xco2Data = h5read('oco2_LtCO2_140906_B7305Br_160713033252s.nc4','/xco2');

lon = -180:0.001:180;
lat = -90:0.001:90;


lat2 = latData(1:1000);
lon2 = lonData(1:1000);
xco2Data2 = xco2Data(1:1000);

% meshgrid of all lat values, lon values
% then make colorbar for co2 value
[X,Y] = meshgrid(-180:1:180);
figure('name','3D Plot', 'NumberTitle','off')
surfc(X, Y, xco2Data2)
colorbar()
axesm utm
grid on
hold on
legend()

theta = [-179:180];
phi = [-89:90];
obs % 360x180 2d array of data
[lat_grid,lon_grid] = meshgrid(theta,phi); % should both be 360x180 to match data
%load coast % loads lat and long variables that define the coastline


% Notes from Dillon:
% snctools is toolbox dillon uses
% nc_varget
% ncdisp('oco2_LtCO2_140906_B7305Br_160713033252s.nc4');