%{
    %test with perfect
TestFile = load('PerfectArial.mat');
test = TestFile.Perfect;
temp = zeros(256,50);
temp(:,1:10) = test;
%}
%
    %test with test input
TestFile = load('drawn_numbers.mat');
test = TestFile.drawn_numbers;
temp = test;
%}
    %equal for everyone
data.X = temp;
ocr_fun(data);

clear;