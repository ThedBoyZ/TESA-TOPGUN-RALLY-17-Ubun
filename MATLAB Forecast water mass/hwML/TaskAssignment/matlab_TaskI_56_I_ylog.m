dataPath = "C:\Users\bluep\Documents\MATLAB\hwML\dataset1.xlsx";
dataTableH1 = readtable(dataPath, 'Sheet', 'Hdata1');
dataTableQ1 = readtable(dataPath, 'Sheet', 'Qdata1');

% Handling empty cells by replacing NaN value with zeros in specific columns
nanColumnsH1 = any(ismissing(dataTableH1), 1);
dataTableH1(:, nanColumnsH1) = fillmissing(dataTableH1(:, nanColumnsH1), 'constant', 0);

nanColumnsQ1 = any(ismissing(dataTableQ1), 1);
dataTableQ1(:, nanColumnsQ1) = fillmissing(dataTableQ1(:, nanColumnsQ1), 'constant', 0);

% rearrange graph order - Month
monthOrder = {'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
tblA = dataTableH1(:, monthOrder);
tblB = dataTableQ1(:, monthOrder);
% Extracting columns of interest excluding first and last columns
dataTableH1 = dataTableH1(:, 2:end-1);
dataTableQ1 = dataTableQ1(:, 2:end-1);

% Extract the columns of interest containing daily values
dailyValuesH1 = table2array(tblA);
flattenedDataH1 = dailyValuesH1(:);
flattenedDataH1 = flattenedDataH1(flattenedDataH1 ~= 0);

dailyValuesQ1 = table2array(tblB);
flattenedDataQ1 = dailyValuesQ1(:);
flattenedDataQ1 = flattenedDataQ1(flattenedDataQ1 ~= 0);

% Plot the data
plot(flattenedDataQ1, flattenedDataH1);

% Reshape the data to column vectors
x = flattenedDataQ1(:);
y = flattenedDataH1(:);

% Remove duplicate entries
unique_indices = unique([x, y], 'rows');
unique_x = unique_indices(:, 1);
unique_y = unique_indices(:, 2);

% Normalize the data (optional but might help in some cases)
normalized_x = (unique_x - mean(unique_x)) / std(unique_x);
normalized_y = (unique_y - mean(unique_y)) / std(unique_y);

% Fit a polynomial model
polyModel = fittype('poly5');
fitResult = fit(normalized_x, normalized_y, polyModel, 'Exclude', []);

% Obtain the fitted values
fittedValues = feval(fitResult, normalized_x);

% Create new x-values for the fitted curve
new_x = linspace(min(normalized_x), max(normalized_x), 100); % Adjust the number of points as needed

% Evaluate the fitted curve at the new x-values
fittedCurve = feval(fitResult, new_x);

% Calculate R-squared for the fit
SSres = sum((normalized_y - fittedValues).^2);
SStotal = (length(normalized_y) - 1) * var(normalized_y);
R_squared = 1 - SSres / SStotal;

% Calculate Mean Squared Error (MSE)
MSE = sum((normalized_y - fittedValues).^2) / length(normalized_y);

% Display the results
fprintf('R-squared: %.4f\n', R_squared);
fprintf('Mean Squared Error (MSE): %.4f\n', MSE);

% Plot the original data and the fitted curve
figure;
scatter(normalized_x, normalized_y, 'o', 'DisplayName', 'Original Data');
hold on;
plot(new_x, fittedCurve, 'r-', 'DisplayName', 'Fitted Curve');
hold off;

legend('show');
xlabel('Q1');
ylabel('H1');
title('Fitting Custom Model to Data');