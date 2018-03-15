% hw 4 
% Julia Dohner
%
% calcs to try with my data
% using keeling co2 data (flask-sampled monthly averages) at mlo
% code taken from A_SIOC_221/HW9/Dohner_SIOC221A_HW9_monthly.m

clear all; close all;

%% load CO2 data

dataMLO = fopen('monthly_data/monthly_flask_co2_mlo_JLD.txt');

valsMLO = textscan(dataMLO, '%f %f', ...
    'delimiter','\t');

fclose(dataMLO);

% format of .txt files is year, co2 value
MLOyear = valsMLO{1};
MLOco2 = valsMLO{2};

%MLOco2 = detrend(MLOco2);


% remove flagged data
for i = 1:length(MLOco2)
    if MLOco2(i) == -99.99
        MLOco2(i) = nan;
    end
end

% remove nan's
addpath('/Users/juliadohner/Documents/MATLAB/A_SIOC_221/HW9/Inpaint_nans/Inpaint_nans');
MLOco2 = inpaint_nans(MLOco2);


% plot timeseries
figure('name','Atmospheric CO2 Timeseries');
plot(MLOyear,MLOco2, '.-');
xlabel('\fontsize{14}year')
ylabel('\fontsize{14}ppm')
title('\fontsize{16}MLO Atmospheric CO2 Record')
legend('\fontsize{12}Mauna Loa','location','northwest');

%% calculate EOF of data

% get a bunch of different timeseries from around the world

%% suppose linear relationship 

% wind speed and aerosol content from oco2 data

%% create objective map

% can do this just from a single timeseries