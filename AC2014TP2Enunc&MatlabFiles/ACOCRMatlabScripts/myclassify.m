function a = myclassify(drawn_numbers, used_indexes)
    
    %% Variables
    % T : desired output
    % P : training inputs
    % Pt : inputed test
    
    %% Load training inputs

    %Load the training dataset and desired output
    Perfect = load('PerfectArial.mat');
    Perfect = Perfect.Perfect;
    P = load('digitos.mat');
    P = P.P;
    

    % include the Perfect in the training dataset
    [N, TOTAL_TRAIN_CASES] = size(P);
    P = horzcat(P,Perfect);
    
    [N, NUMBER_OF_CASES] = size(Perfect);
    NUMBER_OF_SAMPLES_BY_CASE = TOTAL_TRAIN_CASES / NUMBER_OF_CASES;
    [~, TOTAL_TEST_CASES] = size(used_indexes);
    %% Associative Memory
    
    %{
    data_file2 = load('P.mat');
    Pt = data_file2.P;
    %}
    %filter empty squares
    Pt = drawn_numbers(:, used_indexes);
    
    %prompt for inclusion of Associative Memory
    temp = input('\nApply Associative Memory to test set?:\n 1 - Yes\n 2 - No\n');

    %purify testing data with Associative Memory
    if (temp == 1)
        % adapt the Perfect matrix to the dataset
        T = zeros(N,TOTAL_TRAIN_CASES);
        for j=1:NUMBER_OF_CASES,
            for i=1:NUMBER_OF_SAMPLES_BY_CASE,
                T(:,(NUMBER_OF_SAMPLES_BY_CASE*(j-1))+i) = Perfect(:,j); 
            end   
        end
        
        %to include the perfects
        T = horzcat(T,Perfect);
        
        %prompt for transpose end calculate the weights
        temp = input('\nSelect the desired weighing method:\n 1 - transpose\n 2 - pinv\n');
        if (temp == 1)
            Wp = T(:,1:TOTAL_TRAIN_CASES+10) * P(:,1:TOTAL_TRAIN_CASES+10)' ;
        else
            Wp = T(:,1:TOTAL_TRAIN_CASES+10) * pinv(P(:,1:TOTAL_TRAIN_CASES+10));
        end

        [ni, nj] = size(Pt);
        P2 = zeros(N, nj);
        for j=1:nj,
            P2(:,j) = Wp * Pt(:,j); %Analyse each case
        end
        %Print the results
        %showim(P2);
        Pt = P2;
    end

    %% Classifier

	%prompt for activation function
    temp = input('\nSelect the desired activation function:\n1 - sigmoidal\n2 - linear\n3 - hard-limit\n');
     
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
    
    T = zeros(10,TOTAL_TRAIN_CASES);
    ClassPerfect = eye(10);
    for j=1:NUMBER_OF_CASES,
        for i=1:NUMBER_OF_SAMPLES_BY_CASE,
            T(:,(NUMBER_OF_SAMPLES_BY_CASE*(j-1))+i) = ClassPerfect(:,j); 
        end   
    end
    T = horzcat(T,ClassPerfect);
    % initialize
    net = newp(P, T, transfer_function, learning_function);
    W = rand(10, N);
    b = rand(10, 1);
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
    

    % validation
    results = sim(net, Pt);
    a = zeros(1,TOTAL_TEST_CASES);
    for i=1:TOTAL_TEST_CASES,
        temp = find(results(:,i)==1);
        [t,~] = size(temp);
        if t>0
            a(i) = temp(1); 
        else
            a(i) = -1;
        end
    end
    %showim(a);

end
