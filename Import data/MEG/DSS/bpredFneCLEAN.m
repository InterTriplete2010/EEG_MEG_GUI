function [h,CR_test,y_test2,ypred_test2]=bpredFneCLEAN(x,y,h,y2,conds,segno)
% DeltaH will be reset to 0.005 in the function
% At least 10 iterations will be done
% After 10 iterations, prediction error works as the stop criterion

% unequal length of y and y2
MaxIter=1e3;
DeltaH=0.005;
hstr=[];
BestPos=0;

TSlen=size(x,2)/10/conds; %testing sample number
SGlen=size(x,2)/conds;  % length of each condition
% TSlen=floor(TSlen);
ts_rg=[1:TSlen]+TSlen*segno;
testing_range=[];
for ind=2:conds
  ts_rg2(ind,:)=[1:TSlen]+TSlen*segno+(ind-1)*SGlen;
  testing_range=[testing_range ts_rg2(ind,:)];
end
training_range=setdiff([1:SGlen],testing_range);
x_test=x(:,ts_rg(1,:));y_test=y(:,ts_rg(1,:));
x_test2=x(:,testing_range);
x=x(:,training_range);y=y(:,training_range);
y_test2=y2(:,testing_range);

for iter=1:MaxIter
  ypred_now=y*0;
  ypred_test=y_test*0;
  ypred_test2=y_test2*0;
  for ind=1:size(h,1)
    ypred_now=ypred_now+filter(h(ind,:),1,x(ind,:));
    ypred_test=ypred_test+filter(h(ind,:),1,x_test(ind,:));
    ypred_test2=ypred_test2+filter(h(ind,:),1,x_test2(ind,:));
  end
  
  rg=[size(h,2)/2+1]:length(y);
  CR_train(iter)=sum(y(rg).*ypred_now(rg))/sqrt(sum(ypred_now(rg).*ypred_now(rg))*sum(y(rg).*y(rg)));
  TrainE(1:size(h,1))=sum((y(rg)-ypred_now(rg)).^2);
  Str_TrainE(iter)=sum(TrainE);
  
  for indss=1:(conds-1)
    rg=[[size(h,2)/2+1]:TSlen]+(indss-1)*TSlen;
    CR_test2(indss,iter)=sum(y_test2(rg).*ypred_test2(rg))...
      /sqrt(sum(ypred_test2(rg).*ypred_test2(rg))*...
      sum(y_test2(rg).*y_test2(rg)));
  end
  ypred_tests(iter,:)=ypred_test;
  TestE(1:size(h,1))=sum((y_test(1:TSlen)-ypred_test(1:TSlen)).^2);
  Str_testE(iter)=sum(TestE);
  
  if iter>10 && Str_testE(iter)>Str_testE(iter-1) && Str_testE(iter-1)>Str_testE(iter-2) && Str_testE(iter)>Str_testE(iter-3)
    [dum,iter]=min(Str_testE);iter=iter+1;
    try h=squeeze(hstr(iter-2,:,:));
    catch h=h*0;
    end
    if size(h,2)==1
      h=h';
    end
    DeltaH=DeltaH*0.5;
%     disp('Precision doubled')
%     disp(DeltaH)
    if DeltaH<0.005
%       clf;hold on;plot(Str_testE/Str_testE(1), '-*');plot(Str_TrainE/Str_TrainE(1), '-rx')
%       plot(Str_testE(1:iter)/Str_testE(1), '-o');plot(Str_TrainE(1:iter)/Str_TrainE(1), '-ro')
%       disp('It is alreayd recise enough')
      break;
    end
  end
  
  MinE(1:size(h,1))=sum((y-ypred_now).^2);
  for ind1=1:size(h,1)
   for ind2=1:size(h,2)
    ypred=ypred_now+DeltaH*[zeros(1,ind2-1) x(ind1,1:end-ind2+1)];
    e1=sum((y-ypred).^2);
        
    ypred=ypred_now-DeltaH*[zeros(1,ind2-1) x(ind1,1:end-ind2+1)];
    e2=sum((y-ypred).^2);
    
    if e1>e2
      e=e2;
      IncSignTmp=-1;
    else
      e=e1;
      IncSignTmp=1;
    end
    if e<MinE(ind1)
      BestPos(ind1)=ind2;
      IncSign(ind1)=IncSignTmp;
      MinE(ind1)=e;
    end
   end
  end
  if sum(abs(BestPos))==0;
    DeltaH=DeltaH*0.5;
%     disp('Precision doubled')
%     disp(DeltaH)
    if DeltaH<0.005
%         disp('It is alreayd recise enough')
        break;
    end
    continue;
  end
  [dum, bestfil]=min(MinE);
  h(bestfil,BestPos(bestfil))=h(bestfil,BestPos(bestfil))+IncSign(bestfil)*DeltaH;
  BestPos=BestPos*0;
  hstr(iter,:,:)=h;
  try
  if sum(abs(h-hstr(iter-2,:)))==0
      disp(iter)
      break
  elseif sum(abs(h-hstr(iter-3,:)))==0
      disp(iter)
      break
  end
  end
end

CR_test=CR_test2(:,iter);
