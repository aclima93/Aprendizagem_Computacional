
Perfect = load('PerfectArial.mat');
P = load('digitos.mat');
Perfect = Perfect.Perfect;
P = P.digitos;

[temp, NUMBER_OF_CASES] = size(Perfect);
[temp, TOTAL_OF_TEST_CASES] = size(P);
NUMBER_OF_SAMPLES_BY_CASE = TOTAL_OF_TEST_CASES / NUMBER_OF_CASES;

%% Associative Memory

% adapt the Perfect matrix to the dataset
T = zeros(256,TOTAL_OF_TEST_CASES);
for j=1:NUMBER_OF_CASES,
    for i=1:NUMBER_OF_SAMPLES_BY_CASE,
        T(:,(NUMBER_OF_SAMPLES_BY_CASE*(j-1))+i) = Perfect(:,j); 
    end   
end

% calculate the weight
Wp = T(:,1:TOTAL_OF_TEST_CASES) * pinv(P(:,1:TOTAL_OF_TEST_CASES));

%Load the training dataset
data_file2 = load('P.mat');
Ptest = data_file2.P;
P2 = zeros(256,TOTAL_OF_TEST_CASES);

for j=1:TOTAL_OF_TEST_CASES,
    %Analyse each case
    P2(:,j) = Wp * Ptest(:,j);
    %Print the results
    showim(P2(:,j));
    pause();
    clf('reset')
end


%% Classifier

temp = Wn * P2 + b; 
A_perceptron = hardlim(temp);
A_linear = temp;
A_sigmoidal = logsig(temp);

A_perceptron
A_linear
A_sigmoidal

%{
net=feedforwardnet(10,'trainrp');
%net=newp(P,T) ;

net = configure(cenas)

W=rand(10,256);
b=rand(10,1);
net.IW{1,1}=W;
net.b{1,1}=b;


net.performParam.ratio = 0.5; % learning rate 
net.trainParam.epochs = 1000; % maximum epochs 
net.trainParam.show = 35; % show 
net.trainParam.goal = 1e-6; % goal=objective 
net.performFcn = 'sse'; % criterion

%Matlab discards stuff, so
net.inputs(i).processFcns = {};

net=train(net,P,T);
W=net.IW{1,1};
b=net.b{1,1};

mpaper

a = sim(net,P);
%}
