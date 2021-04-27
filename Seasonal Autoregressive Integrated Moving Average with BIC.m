i = 1;
load('power.mat');
panjang_data = length(power1);
panjang_val_test = 24*7*4;

train = power1(1:(panjang_data - panjang_val_test),1); 

%% Seasonal ARIMA Tuning

for s = 24:24:168
    for p = 1:12
        for q = 1:12


        display('Fitting SARIMA Model Number');display(i);
        mod = arima('Constant',0,'ARLags',p,'D',0,'MALags',q,'Seasonality',s,...
       'SMALags',1,'SARLags',1);
        [fit,~,logL] = estimate(mod,train,'Display','off');
        [~,bic] = aicbic(logL,p+q+1+1,length(train));
        simpan(i,1) = p; simpan(i,2) = 0; simpan(i,3) = q;
        simpan(i,4) = s; simpan(i,5) = 1; simpan(i,6) = 0;
        simpan(i,7) = 1; simpan(i,8) = bic;
        
        i = i+1;
        display('Minimum BIC');
        display(min(simpan(:,8)));
        
        end
     end
end

xlswrite('SARIMA_Tuning.xlsx',simpan);

%% Seasonal AR Tuning

for s = 24:24:168
    for p = 1:12
        for q = 0


        display('Fitting SAR Model Number');display(i);
        mod = arima('Constant',0,'ARLags',p,'D',0,'Seasonality',s,...
        'SARLags',1);
        [fit,~,logL] = estimate(mod,train,'Display','off');
        [~,bic] = aicbic(logL,p+q+1+1,length(train));
        simpan(i,1) = p; simpan(i,2) = 0; simpan(i,3) = q;
        simpan(i,4) = s; simpan(i,5) = 1; simpan(i,6) = 0;
        simpan(i,7) = 0; simpan(i,8) = bic;
        
        i = i+1;
        display('Minimum BIC');
        display(min(simpan(:,8)));
        
        end
     end
end

xlswrite('SAR_Tuning.xlsx',simpan);
%% Seasonal MA Tuning

for s = 24:24:168
    for q = 1:12
        for p = 0


        display('Fitting SMA Model Number');display(i);
        mod = arima('Constant',0,'MALags',q,'D',0,'Seasonality',s,...
        'SMALags',1);
        [fit,~,logL] = estimate(mod,train,'Display','off');
        [~,bic] = aicbic(logL,p+q+1+1,length(train));
        simpan(i,1) = p; simpan(i,2) = 0; simpan(i,3) = q;
        simpan(i,4) = s; simpan(i,5) = 0; simpan(i,6) = 0;
        simpan(i,7) = 1; simpan(i,8) = bic;
        
        i = i+1;
        display('Minimum BIC');
        display(min(simpan(:,8)));
        
        end
     end
end

xlswrite('SMA_Tuning.xlsx',simpan);
%% Non Seasonal AR Tuning 

%% Non Seasonal MA Tuning 

for s = 0
    for q = 1:12
        for p = 0


        display('Fitting MA Model Number');display(i);
        mod = arima('Constant',0,'MALags',q,'D',0);
        [fit,~,logL] = estimate(mod,train,'Display','off');
        [~,bic] = aicbic(logL,p+q+1+1,length(train));
        simpan(i,1) = p; simpan(i,2) = 0; simpan(i,3) = q;
        simpan(i,4) = s; simpan(i,5) = 0; simpan(i,6) = 0;
        simpan(i,7) = 0; simpan(i,8) = bic;
        
        i = i+1;
        display('Minimum BIC');
        display(min(simpan(:,8)));
        
        end
     end
end

xlswrite('SMA_Tuning.xlsx',simpan);

%% Non Seasonal ARIMA Tuning 