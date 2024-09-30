
% Sample data
x = 1:10; % x values
y = [2.3, 4.5, 7.2, 11.1, 17.3, 26.7, 41.2, 63.6, 98.1, 151.2]; % corresponding y values
% Define the exponential model function
expModel = fittype('a * exp(b * x) + c * x', 'independent', 'x', 'dependent', 'y');
% Fit the model to the data
fitResult = fit(x.', y.', expModel);
% Display the coefficients
coefficients = coeffvalues(fitResult);
a = coefficients(1);
b = coefficients(2);
c = coefficients(3);
fprintf('Fitted coefficients: a = %.4f, b = %.4f ,c = %0.2f\n', a, b, c);
% Plot the original data and the fitted curve
plot(x, y, 'o', 'DisplayName', 'Original Data');
hold on;
fittedCurve = a * exp(b * x);
plot(x, fittedCurve, 'r-', 'DisplayName', 'Fitted Curve');
hold off;
legend('show');
xlabel('x');
ylabel('y');
title('Fitting Exponential Function to Data');

nv = fittedCurve;
v = y;

% R squared
R_squared = 1 - sum((y - nv).^2) / sum((v - mean(v)).^2)
% Mean Absolute Error (MAE) calculation
MAE = mean(abs(v - nv));
% Mean Squared Error (MSE) calculation
MSE = mean(sum((v - nv).^2));

