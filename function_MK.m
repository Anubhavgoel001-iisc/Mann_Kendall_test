function [H,p_value,senslope] = function_MK (data,alpha)

%%
% alpha=.05;
% [MANN,Pvalue,senslope] = function_MK(ANNUAL_mean,alpha);
% RHJRAtrend(i,:)=[RH_JRA_pet55{i,1},MANN(1),senslope];
% a=p_value;
% b=pValue_kp;
% c=pValue_adf;
% d=[a,b,c];
% m=[H,h,h_adf];
% h = 1 indicates rejection of the trend-stationary null in favor of the unit root alternative.
% h = 0 indicates failure to reject the trend-stationary null.
% h_adf = 1 indicates rejection of the unit-root null in favor of the alternative model.
% h_adf = 0 indicates failure to reject the unit-root null.
% H = 1 indicates a rejection of the null hypothesis at the alpha significance level.
% H = 0 indicates a failure to reject the null hypothesis at the alpha significance level.
%%


warning('off','all')
%% -------------------------------------
[H, p_value]= Mann_Kendall(data,alpha);

if H==0
    %'mann_kundall_Stationary'
else
    %'mann_kundall_non-Stationary'
end
p_value;

% %% -------------------------------------
% [h,pValue_kp] = kpsstest(data);
% pValue_kp;
% 
% if h==0
%     %'kpss_Stationary'
% else
%     %'kpss_non-Stationary'
% end
% 
% %% -------------------------------------
% [h_adf,pValue_adf] = adftest(data);
% pValue_adf;
% 
% if h_adf==1
%     %'adf_Stationary'
% else
%     %'adf_non-Stationary'
% end

%% --------------------------------------
[senslope]=function_senslope(data);
%% --------------------------------------
% a=p_value;
% b=pValue_kp;
% c=pValue_adf;
% d=[a,b,c];
% m=[H,h,h_adf];

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [senslope]=function_senslope(data)

count=0;
for i =1: length (data)
    for j =1: length (data)
        if i>j
            slope(count+1,1)= (data(i)-data(j))/(i-j);
            count=count+1;
            mat_slope(i,j)= (data(i)-data(j))/(i-j);
        end
    end
end
slope_sorted=sort(slope);
senslope= median(slope_sorted);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [H, p_value]= Mann_Kendall(V,alpha)
V= reshape(V,length(V),1);
alpha= alpha/2;
n= length(V);
S=0;
for i=1:n-1
    for j= i+1:n
        S= S + sign(V(j)-V(i));
    end
end
VarS= (n*(n-1)*(2*n+5))/18;
StdS= sqrt(VarS);
if S >= 0
    Z= ((S-1)/StdS)*(S~=0);
else
    Z= (S+1)/StdS;
end
p_value= 2*(1-normcdf(abs(Z),0,1));
pz= norminv(1-alpha,0,1);
H= abs(Z)>pz;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

