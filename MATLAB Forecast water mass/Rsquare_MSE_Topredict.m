clear
clc
x = 1:10; % x values
y = [2.3, 4.5, 7.2, 10, 17.3, 26.7, 41.2, 63.6, 98.1, 151.2]; % corresponding y values
mdl = fitlm(x,y);
%next_value = predict(mdl,11)
for n = 1:length(y)
   nv(n,1) = predict(mdl,n);
end
plot(x,y)
hold on
plot(x,nv)
% R squared
R_squared = 1 - sum((y - nv).^2) / sum((y - mean(y)).^2)
% Mean Absolute Error (MAE) calculation
MAE = mean(abs(y - nv));
% Mean Squared Error (MSE) calculation
MSE = mean(sum((y - nv).^2));
plot(x,y)
hold on
plot(x,nv,'*')
plot(R_squared)

