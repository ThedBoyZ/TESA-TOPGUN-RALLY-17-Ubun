dataPath = "C:\Users\bluep\Documents\MATLAB\hwML\dataset-3b.xlsx";
dataTable_page2 = readtable(dataPath, 'Sheet', 'QH_S1');
dataTable_page1 = readtable(dataPath, 'Sheet', 'Q1A');
TestcaseH1 = dataTable_page1(1:55,"Height_S1");

% Extract H_S1 and Q_S1 data
H1dataQ1A = TestcaseH1
Q1dataQ1A = dataTable_page1(1:55,"Discharge_S1");
Q2dataQ1A = dataTable_page1(1:55,"Discharge_S2");
Q3dataQ1A = dataTable_page1(1:55,"Discharge_S3");
dataH1 = dataTable_page2(:, "H_S1");
dataQ1 = dataTable_page2(:, "Q_S1");

% Convert table data to arrays
H1 = table2array(dataH1);
Q1 = table2array(dataQ1);
H1Q1A = table2array(H1dataQ1A);
Q1Q1A =  table2array(Q1dataQ1A);
Q2Q1A =  table2array(Q2dataQ1A);
Q3Q1A =  table2array(Q3dataQ1A);

%----------------------- Solution 1 ----------------------------------
                % Model And Pre- Processing
norm_H1 = (H1 - mean(H1)) / std(H1);
norm_Q1 = (Q1 - mean(Q1)) / std(Q1);

% Fit a polynomial model
polyDegree = 3; % Change the degree as needed
polyModel = fit(norm_H1, norm_Q1, sprintf('poly%d', polyDegree));

% Obtain the fitted values
fittedValues = feval(polyModel, norm_H1);

% Calculate R-squared for the fit
SSres = sum((norm_Q1 - fittedValues).^2);
SStotal = (length(Q1) - 1) * var(norm_Q1);
R_squared = 1 - SSres / SStotal;

% Calculate Mean Squared Error (MSE)
MSE = sum((norm_Q1 - fittedValues).^2) / length(norm_Q1);

% Display the results
fprintf('R-squared: %.4f\n', R_squared);
fprintf('Mean Squared Error (MSE): %.4f\n', MSE);

%----------------------- Solution 2 ----------------------------------
% Test set (H1 values you want to predict Q1 for)
testH1 = table2array(TestcaseH1);
norm_H1Pre = (testH1 - mean(H1)) / std(H1);
predicted_Q1 = feval(polyModel, norm_H1Pre);
predicted_Q1_denormalized = predicted_Q1 * std(Q1) + mean(Q1);

% Display or use the predicted values as needed
disp(predicted_Q1_denormalized);

% Plot the data points
figure;
plot(H1, Q1, "Marker", "+", 'LineStyle', 'none', 'DisplayName', 'Data Points');
title('Data point');
hold on;

% Plot the data points and the regression curve
figure;
plot(H1, Q1, "Marker", "+", 'LineStyle', 'none', 'DisplayName', 'Data Points');
hold on;
plot(testH1, predicted_Q1_denormalized, 'r-', 'LineWidth', 2, 'DisplayName', 'Polynomial Regression');
hold off;

xlabel('H1');
ylabel('Q1');
legend('show');
title('Polynomial Regression Model');

%------------------------ Solution 3 ---------------------------------
% Equation Q3 = Q1 + Q2 + F --- > F = Q3 - (Q1 + Q2)
fData = (Q3Q1A - Q2Q1A - Q1Q1A)

positiveValues = fData(fData >= 0);
negativeValues = fData(fData < 0);

figure;
for i = 1:length(fData)
    if fData(i) >= 0
        bar(i, fData(i), 'b');
    else
        bar(i, fData(i), 'r');
    end
    hold on;
end
hold off;

xlim([0, length(fData) + 1]);
xticks(1:length(fData));

xlabel('Data Point');
ylabel('Value');
title('Tide Graph with High and Low Tide');

% Create legend markers with desired colors
bluePatch = patch([0 1 1 0], [0 0 1 1], 'b');
redPatch = patch([0 1 1 0], [0 0 1 1], 'r');
legend([bluePatch, redPatch],'High Tide Rising', 'Low Tide Falling');