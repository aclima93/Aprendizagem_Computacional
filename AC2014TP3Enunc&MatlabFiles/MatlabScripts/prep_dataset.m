function [train,train_target,test,test_target] = prep_dataset(dataset,target_dataset,trainPrecentage)
   
    [NUM_LINES,NUM_COLUMNS] = size(dataset);

%% How can we do this, in a easy way?
%% http://weknowmemes.com/generator/uploads/generated/g1369409960206058073.jpg

%% Where I am, to solve all of your problems!
%% http://stackoverflow.com/questions/3274043/finding-islands-of-zeros-in-a-sequence

    % These are the steps I would take to solve
    %your problem in a vectorized way,
    %starting with a given vector sig:
    
        %to make the zeros ones and vice-versa
    tsig = (target_dataset == 0)';

    %% Next,
    %find the starting indices, ending indices,
    %and duration of each string of zeroes using the
    %functions DIFF and FIND:

    dsig = diff([1 tsig 1]);
    startIndex = find(dsig < 0);
    endIndex = find(dsig > 0)-1;
    duration = endIndex-startIndex+1;

    %% Finally,
    %use the method from my answer to the linked
    %question to generate your final set of indices:

    indices = zeros(1,max(endIndex)+1);
    indices(startIndex) = 1;
    indices(endIndex+1) = indices(endIndex+1)-1;
    indices = find(cumsum(indices));
%% YEY!!!! Thank you, our lord and saviour Stack OverFlow!!!

%% So, lets do this
    %FIXME: Now only has the crysis, and all of them
    %Get the Size of the matrix
    [~,length] = size(indices);
    disp('Number of True in the target:');
    disp(length);
    trainSize = ceil(length*trainPrecentage);
    if trainSize == length,
        trainSize = floor(length*trainPrecentage);
    end
    final_trainSize = trainSize*2;
    testSize = length - trainSize;
    final_testSize = testSize*2;
    
    %create the indices for the Not crysis
    notCrysisIndices = (find(target_dataset == 0));
    [a,~] = size(notCrysisIndices);
    notCrysisIndices = notCrysisIndices(randperm(a));
    %notCrysisIndices = notCrysisIndices(randperm(length(notCrysisIndices)));
    
    %create the output matrix
    %FIXME: falta acrescentar ao size os Not crysis
    train = zeros(final_trainSize,NUM_COLUMNS);
    train_target = zeros(final_trainSize,1);
    test = zeros(final_testSize,NUM_COLUMNS);
    test_target = zeros(final_testSize,1);
    
    %% fill the output matrix
    
    %suffle the indices
    indices = indices(randperm(length));
    
    %add the data to the train dataset
    train(1:trainSize,:) = dataset(indices(1:trainSize),:);
    train_target(1:trainSize,:) = target_dataset(indices(1:trainSize),:);
    train((trainSize+1):final_trainSize,:) = dataset(notCrysisIndices(1:trainSize),:);
    train_target((trainSize+1):final_trainSize,:) = target_dataset(notCrysisIndices(1:trainSize),:);
    
    %add the data to the test dataset
    test(1:testSize,:) = dataset(indices((trainSize+1):length),:);
    test_target(1:testSize,:) = target_dataset(indices((trainSize+1):length),:);
    test((testSize+1):final_testSize,:) = dataset(notCrysisIndices((trainSize+1):length),:);
    test_target((testSize+1):final_testSize,:) = target_dataset(notCrysisIndices((trainSize+1):length),:);
    