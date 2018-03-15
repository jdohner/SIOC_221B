function [U,s,V,timeeof,loneof,lateof]=eofersst(t,time,lon,lat,yearmin,yearmax,lonmin,lonmax,latmin,latmax,neof)
% function [U,s,V]=eofersst(t,n) calculates eofs and amplitudes from ersst
% data t, time, lon, lat.  itmin and itmax are minimum and maximum time 
% indices.  lonmin,lonmax,latmin,latmax are min and max lons and lats.
% neof is the number of eofs and amplitudes to be returned.
%

% D. Rudnick, April 2, 2009

ilat=lat >= latmin & lat <= latmax;
lateof=lat(ilat);
nlat=length(lateof);
ilon=lon >= lonmin & lon <= lonmax;
loneof=lon(ilon);
nlon=length(loneof);
dv=datevec(ut2dn(time));
itime=dv(:,1) >= yearmin & dv(:,1) <= yearmax;
timeeof=time(itime);
ntime=length(timeeof);

t2=t(itime,ilat,ilon);
t2=reshape(t2,ntime,[]);
ii=all(~isnan(t2));
t2=t2(:,ii);
npos=size(t2,2);

mtime=1:ntime;
for n=1:npos
   for m=0:11
      jj=rem(mtime,12) == m;
      t2(jj,n)=t2(jj,n)-mean(t2(jj,n));
   end
end


[U,S,V2]=svd(t2,'econ');
U=U(:,1:neof);
s=diag(S.^2)/trace(S.^2);
s=s(1:neof);
V=nan(nlat*nlon,neof);
V(ii,:)=V2(:,1:neof);
V=reshape(V,nlat,nlon,neof);
