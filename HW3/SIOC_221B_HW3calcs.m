% hw 3 
%
% calcs to try with my data
% using keeling co2 data (flask-sampled monthly averages) at mlo
% code taken from A_SIOC_221/HW9/Dohner_SIOC221A_HW9_monthly.m

clear all; close all;

%% load CO2 data

dataMLO = fopen('monthly_data/monthly_flask_co2_mlo_JLD.txt');
%dataMLO = fopen('halfhour_data/LJO_CO2_halfhourly_1958-1962.txt');

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
% TODO: if time, go back and change this to a linear interpolation
addpath('/Users/juliadohner/Documents/MATLAB/A_SIOC_221/HW9/Inpaint_nans/Inpaint_nans');
MLOco2 = inpaint_nans(MLOco2);


% plot timeseries
figure('name','Atmospheric CO2 Timeseries');
plot(MLOyear,MLOco2, '.-');
xlabel('\fontsize{14}year')
ylabel('\fontsize{14}ppm')
title('\fontsize{16}MLO Atmospheric CO2 Record')
legend('\fontsize{12}Mauna Loa','location','northwest');


% calculate mean and a few moments of variables

% 0th moment - mean xco2
mean = mean(MLOco2);

% 1st moment - variance xco2
variance = var(MLOco2);

% 2nd moment - skewness xco2
skew = skewness(MLOco2);

% calculate the standard error

sigma = variance^0.5;
stderr = sigma/(length(MLOco2));

% spectrum of data
% three overlapping segments:
N = length(MLOco2);
Nseg = 4; % number of segments splitting data into
segment_length = N/Nseg; % length of each chunk of data (aka segment length)
M = segment_length/2;

MLO_use=[reshape(MLOco2,segment_length,Nseg)];
MLO_ft=fft(detrend(MLO_use).*(hann(segment_length)*ones(1,Nseg)));
MLO_spec=sum(abs(MLO_ft(1:M+1,:)).^2,2)/N;
MLO_spec(2:end)=MLO_spec(2:end)*2;
% plot spectra
frequency=(1:M+1)/(segment_length/12);
frequency = frequency';
figure('name','Power Spectra of CO2 Records');
loglog(frequency, MLO_spec, '-b')
xlabel('\fontsize{14}cycles per year')
ylabel('\fontsize{14}ppm^2/cpy')
title('\fontsize{16}Power Spectra of CO2 Record')
legend('\fontsize{12}Mauna Loa Station', 'Location','northeast');



% taking account of serial correlation
% S0 = MLO_spec(1);
% X = 10;
% mserr = S0/(MLOyear(end)-MLOyear(1)); % units of years
% 
% % fit a model to your data
% N = length(MLOco2);
% M = N;
% G = bsxfun(@power,MLOyear,0:M-1);
% [m1,m2]=meshgrid(0:M-1,0:M-1);
% Wm=(m1.*(m1-1).*m2.*(m2-1))./(m1+m2-3).*X.^(m1+m2-3);
% Wm(isnan(Wm))=0;

% fitting trend plus annual cycle
t_MLO = MLOyear-MLOyear(1);
cosMLO = cos(2*pi*MLOyear/(1)); 
sinMLO = sin(2*pi*MLOyear/(1));
G = [ones(length(MLOyear),1) t_MLO sinMLO cosMLO t_MLO.^2];
m = inv(G'*G)*G'*MLOco2;

d_calc = G*m;
plot(MLOyear,d_calc,MLOyear,MLOco2);
legend('MLO calculated','MLO observed')


