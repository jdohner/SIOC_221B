%script to calculate and plot eofs
%

tbar=ones(size(t,1),1)*mean(t);
tdm=detrend(t,'constant');
[U,S,V]=svd(tdm,0);

plot(diag(S.^2)/trace(S.^2),'x');
grid;

moororder={'F2';'F6';'F4';'F8';'F10'};

id=input('Which EOF? ');
while ~isempty(id)
   figure;
   for n=1:5
      ii=find(strcmp(moor,moororder(n)));
      subplot(3,5,n);
      plot(V(ii,id),depth(ii),'x');
      set(gca,'ydir','rev','ylim',[0 170],'xlim',[-0.5 0.5]);
      grid;
      title(moororder(n));
      if n == 1
         ylabel('Depth (m)');
      else
         set(gca,'yticklabel','');
      end
   end
   subplot(3,5,[6:10]);
   plot(ut2dn(time),S(id,id)*U(:,id));
   axis('tight');
   datetick('keeplimits');
   ylabel(['Temperature (\circC)']);
   subplot(3,5,[11:15]);
   Sdiag=diag(S);
   Sdiag(id+1:end)=0;
   Sprime=diag(Sdiag);
   tfilt=tbar+U*Sprime*V';
   plot(ut2dn(time),tfilt(:,9:16));
   axis('tight');
   datetick('keeplimits');
   id=input('Which EOF? ');
end
