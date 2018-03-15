% eof question of hw #3
% (question 2)

clear all

% data in matrices y1 and y2 as functions of x and t
% 11 timeseries
% 101 time points in each series

% Perform EOF analysis on y1
% y1 is in form [timeseries timeseries] (as columns)


load eofdata.mat;
%y1 = y1';
y1_dm = detrend(y1, 'constant');
y2_dm = detrend(y2, 'constant');
[U1,S1,V1]=svd(y1_dm,0);
[U2,S2,V2]=svd(y2_dm,0);

figure('Name','y1 data')
subplot(2,1,1)
plot(x,y1(1:11,:))
title('y1 data before removing mean')
subplot(2,1,2)
plot(x,y1_dm(1:11,:)) % removing mean didn't seem to do anything
title('y1 data after removing mean')

figure('Name','y2 data')
subplot(2,1,1)
plot(x,y2(1:11,:))
title('y2 data before removing mean')
subplot(2,1,2)
plot(x,y2_dm(1:11,:))
title('y2 data after removing mean')


% plot the fraction of total variance accounted for by each EOF
figure('Name','y1 fraction of variances')
plot(diag(S1.^2)/trace(S1.^2),'x'); % trace is sum of diagnoal
grid;
title('fraction of total variance in y1 accounted for by EOFs')
figure('Name','y2 fraction of variances')
plot(diag(S2.^2)/trace(S2.^2),'x');
title('fraction of total variance in y2 accounted for by EOFs')
grid;

% plot the first two EOFs and amplitudes
% amplitudes given by the rows of the matrix:
amp1 = V1'*y1_dm;
figure('Name','y1 EOFs and amplitudes')
subplot(2,2,1)
plot(x,V1(:,1))
title('first EOF of y1')
subplot(2,2,2)
plot(amp1(:,1))
title('amplitude of first EOF of y1')
subplot(2,2,3)
plot(x,V1(:,2))
title('second EOF of y1')
subplot(2,2,4)
plot(amp1(:,2))
title('amplitude of second EOF of y1')

% amp: plot(t,U(:,2))
%amp2 = V2'*y2_dm;
figure('Name','y2 EOFs and amplitudes')
subplot(2,2,1)
plot(x,V2(:,1))
title('first EOF of y2')
subplot(2,2,2)
plot(amp2(:,1))
title('amplitude of first EOF of y2')
subplot(2,2,3)
plot(x,V2(:,2))
title('second EOF of y2')
subplot(2,2,4)
plot(amp2(:,2))
title('amplitude of second EOF of y2')



% [N,L] = size(y1);
% neof = 11; %working with 5 eofs for now
% 
% y1 = y1';
% [U,S,V] = svd(y1,'econ');
% % columns of U are the EOFs
% U=U(:,1:neof);
% s=diag(S.^2)/trace(S.^2);
% s=s(1:neof);
%V=V(:,neof); % what happens here? V is weird dims


% U is vectors of EOF's


