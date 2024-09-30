dataPath = "C:\Users\bluep\Documents\MATLAB\hwML\dataset1.xlsx";
dataTableH1 = readtable(dataPath, 'Sheet', 'Hdata1');
dataTableQ1 = readtable(dataPath, 'Sheet', 'Qdata1');

% Handling empty cells by replacing NaN value with zeros in specific columns
nanColumnsH1 = any(ismissing(dataTableH1), 1);
dataTableH1(:, nanColumnsH1) = fillmissing(dataTableH1(:, nanColumnsH1), 'constant', 0);

nanColumnsQ1 = any(ismissing(dataTableQ1), 1);
dataTableQ1(:, nanColumnsQ1) = fillmissing(dataTableQ1(:, nanColumnsQ1), 'constant', 0);

% rearrange graph order - Month
monthOrder = {'Date', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'};
tblA = dataTableH1(:, monthOrder);
tblB = dataTableQ1(:,monthOrder);


% Display the extracted data
disp(tblB);

% Change format to display full decimal number
format longG;
total_sum = sum(tblA{:, 2});
fprintf("Total = %.2f\n", total_sum);

[rowCount, ~] = size(tblA);
fprintf("Number of rows = %d\n", rowCount);
% Extract the columns of interest containing daily values
dailyValuesH1 = table2array(tblA(:, 2:end));  % Excludes the first column

% Flatten the data into a single column
flattenedDataH1 = dailyValuesH1(:);  % Reshapes all the columns into a single column

% Ensure the resulting size is 365x1 (or adjust it accordingly)
flattenedDataH1 = flattenedDataH1(1:365);  % Considering only the first 365 values if they exist
disp(flattenedDataH1)
% Extract the columns of interest containing daily values
dailyValuesQ1 = table2array(tblB(:, 2:end));  % Excludes the first column

% Flatten the data into a single column
flattenedDataQ1 = dailyValuesQ1(:);  % Reshapes all the columns into a single column

% Ensure the resulting size is 365x1 (or adjust it accordingly)
flattenedDataQ1 = flattenedDataQ1(1:365);  % Considering only the first 365 values if they exist
disp(flattenedDataQ1)

x = flattenedDataQ1;
y = flattenedDataH1;
mdl = fitlm(x, y);

% Predict values using the model for each data point in y
predicted_values = predict(mdl, x);

% Calculate Mean Squared Error (MSE)
MSE = mean((y - predicted_values).^2)/1000;
fprintf("MSE = %.2f\n",MSE)

% Calculate R-squared (R^2)
R_squared = 1- mdl.Rsquared.Ordinary;

fprintf("R_square = %.2f",R_squared)