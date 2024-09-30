

% Sample data
x = 1:10; % x values
y = 2 * x +1;
% Define the composite model function using fittype with multiple functions
compositeModel = fittype('a*x+b', 'coefficients', {'a', 'b'}, 'independent', 'x', 'dependent', 'y');
% Fit the composite model to the data
fitResult = fit(x.', y.', compositeModel);
% Display the coefficients
coefficients = coeffvalues(fitResult);
a = coefficients(1);
b = coefficients(2);
%c = coefficients(3);
%d = coefficients(4);
fprintf('Fitted coefficients: a = %.4f, b = %.4f', a, b);
% Plot the original data and the fitted curve
plot(x, y, 'o', 'DisplayName', 'Original Data');
hold on;
fittedCurve = a * x + b;
plot(x, fittedCurve, 'r-', 'DisplayName', 'Fitted Curve');
hold off;
legend('show');
xlabel('x');
ylabel('y');
title('Fitting Composite Model to Data');