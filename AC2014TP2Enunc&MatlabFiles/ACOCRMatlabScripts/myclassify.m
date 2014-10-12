function a = myclassify(drawn_numbers, empty_indexes)

    %% Variables
    % T : desired output
    % P : training inputs
    % Pt : inputed test
    
    %% Load training inputs

    %Load the training dataset and desired output
    Perfect = load('PerfectArial.mat');
    P = load('digitos.mat');
    Perfect = Perfect.Perfect;
    %send the zero to the end of the 'array'
    %P = horzcat(P.digitos(:,51:500),P.digitos(:,1:50));

    [N, NUMBER_OF_CASES] = size(Perfect);
    [n, TOTAL_TEST_CASES] = size(P);
    NUMBER_OF_SAMPLES_BY_CASE = TOTAL_TEST_CASES / NUMBER_OF_CASES;

    %% Associative Memory

    %{
    data_file2 = load('P.mat');
    Pt = data_file2.P;
    %}
    %filter empty squares
    drawn_numbers = drawn_numbers(:, empty_indexes);
    Pt = drawn_numbers;
    
    %prompt for inclusion of Associative Memory
    temp = input('\nApply Associative Memory to testing set?:\n\t1 - Yes\n\t2 - No\n');

    %purify testing data with Associative Memory
    if (temp == 1)
        % adapt the Perfect matrix to the dataset
        T = zeros(N,TOTAL_TEST_CASES);
        for j=1:NUMBER_OF_CASES,
            for i=1:NUMBER_OF_SAMPLES_BY_CASE,
                T(:,(NUMBER_OF_SAMPLES_BY_CASE*(j-1))+i) = Perfect(:,j); 
            end   
        end

        %prompt for transpose end calculate the weights
        temp = input('\nSelect the desired weighing method:\n\t1 - transpose\n\t2 - pinv\n');
        if (temp == 1)
            Wp = T(:,1:TOTAL_TEST_CASES) * P(:,1:TOTAL_TEST_CASES)' ;
        else
            Wp = T(:,1:TOTAL_TEST_CASES) * pinv(P(:,1:TOTAL_TEST_CASES));
        end

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
    end

    %% Classifier

	%prompt for activation function
    temp = input('\nSelect the desired activation function:\n\t1 - sigmoidal\n\t2 - linear\n\t3 - hard-limit\n');
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