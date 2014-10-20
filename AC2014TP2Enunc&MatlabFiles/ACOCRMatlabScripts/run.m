%
%test with perfect
%
TestFile = load('PerfectArial.mat');
test = TestFile.Perfect;
temp = zeros(256,50);
temp(:,1:10) = test;
%

%{
%test with test input
TestFile = load('drawn_numbers.mat');
test = TestFile.drawn_numbers;
temp = test;
%}

%equal for everyone
data.X = temp;
%ocr_fun(data);

% automated param choice
training_set = 'digitos.mat';
for i=1:2,
    for j=1:2,
        for k=1:3
            user_choice = [i,j,k]
            automated_ocr_fun(data, user_choice, training_set);
            pause;
            close all;
        end
    end
end
% manual param choice
%ocr_fun(data, training_set);

