
%Load the training dataset
Perfect = load('PerfectArial.mat');
P = load('digitos.mat');
Perfect = Perfect.Perfect;
P = P.digitos;

[N, NUMBER_OF_CASES] = size(Perfect);
[n, TOTAL_TEST_CASES] = size(P);
NUMBER_OF_SAMPLES_BY_CASE = TOTAL_TEST_CASES / NUMBER_OF_CASES;

%% Associative Memory

% adapt the Perfect matrix to the dataset
T = zeros(N,TOTAL_TEST_CASES);
for j=1:NUMBER_OF_CASES,
    for i=1:NUMBER_OF_SAMPLES_BY_CASE,
        T(:,(NUMBER_OF_SAMPLES_BY_CASE*(j-1))+i) = Perfect(:,j); 
    end   
end

% calculate the weight
Wp = T(:,1:TOTAL_TEST_CASES) * pinv(P(:,1:TOTAL_TEST_CASES));

%create the test dataset
%mpaper
data_file2 = load('P.mat'); %we're lazy, so we just load it time and time again
Ptest = data_file2.P;
[ni, nj] = size(Ptest);
P2 = zeros(N, nj);
for j=1:nj,
    P2(:,j) = Wp * Ptest(:,j); %Analyse each case
    %Print the results
    %{
    showim(P2(:,j));
    pause();
    clf('reset')
    %}
end


%% Classifier

net_perceptron = newp(P2, P);

W = rand(10, N);
b = rand(10, 1);
net.IW{1, 1} = W;
net.b{1, 1} = b;

net.performParam.ratio = 0.5; % learning rate 
net.trainParam.epochs = 1000; % maximum epochs 
net.trainParam.show = 35; % show 
net.trainParam.goal = 1e-6; % goal=objective 
net.performFcn = 'sse'; % criterion

net.inputs(i).processFcns = {}; %Matlab discards stuff, therefor

%net = train(net, P2, P);
W = net.IW{1, 1};
b = net.b{1, 1};

%a = sim(net, P2);

%temp = Wn * P2 + b; 
%A_perceptron = hardlim(temp);
%A_linear = temp;
%A_sigmoidal = logsig(temp);

