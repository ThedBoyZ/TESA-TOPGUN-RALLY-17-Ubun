dataPath = "C:\Users\bluep\Documents\MATLAB\Train ML\Sample1.xlsx"
hdata = readmatrix(dataPath);
dataPath;
data_select = hdata(:,11)
column_11_sum = nansum(data_select);  % Sum the values in column 11, ignoring NaN values
disp(column_11_sum);  % Display the sum of cdataPath = "C:\Users\bluep\Documents\MATLAB\Train ML\Sample1.xlsx";
