%mpaper();

%test with perfect
Perfect = load('PerfectArial.mat');
drawn_numbers = Perfect.Perfect;
temp = zeros(256,50);
temp(:,1:10) = drawn_numbers;
data.X = temp;
ocr_fun(data);


clear;