function a = myclassify(drawn_numbers, empty_indexes)

    %filter empty squares
    drawn_numbers = drawn_numbers(:, empty_indexes);

    %% Variables
    % T : desired output
    % P : training inputs
    % Pt : inputed test


    %Load the training dataset and desired output
    Perfect = load('PerfectArial.mat');
    P = load('digitos.mat');
    Perfect = Perfect.Perfect;
    %send the zero to the end of the 'array'
    P = horzcat(P.digitos(:,51:500),P.digitos(:,1:50));

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

    % calculate the weights
    Wp = T(:,1:TOTAL_TEST_CASES) * pinv(P(:,1:TOTAL_TEST_CASES));

    %{
    data_file2 = load('P.mat');
    Pt = data_file2.P;
    %}
    Pt = drawn_numbers

    [ni, nj] = size(Pt);
    P2 = zeros(N, nj);
    for j=1:nj,
        P2(:,j) = Wp * Pt(:,j); %Analyse each case
        %Print the results
        %{
        showim(P2(:,j));
        pause();
        clf('reset')
        %}
    end


    %% Classifier

	%prompt for activation function
    temp = input('\nSelect the desired activation function.\n1 - sigmoidal\n2 - linear\n3 - hard-limit\n');
    if (temp == 1)
        transfer_function = 'logsig';
        learning_function = 'learngd';
    elseif (temp == 2)
        transfer_function = 'purelin';
        learning_function = 'learngd';
    elseif (temp == 3)
        transfer_function = 'hardlim';
        learning_function = 'learnp';
    end
    
    % initialize
    net = newp(P, T, transfer_function, learning_function);
    W = rand(N, N);
    b = rand(N, 1);
    net.IW{1, 1} = W;
    net.b{1, 1} = b;

    % training parameters
    net.performParam.ratio = 0.5; % learning rate 
    net.trainParam.epochs = 1000; % maximum epochs 
    net.trainParam.show = 35; % show 
    net.trainParam.goal = 1e-6; % goal=objective 
    net.performFcn = 'sse'; % criterion
    %net.inputs(i).processFcns = {}; %Matlab discards stuff, therefor

    % training
    net = train(net, P, T);
    W = net.IW{1, 1};
    b = net.b{1, 1};
    pause();

    % validation
    a = sim(net, P2);
    showim(a);

end