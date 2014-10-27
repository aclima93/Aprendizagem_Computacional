function [train,train_target,test,test_target] = prep_dataset(train_dataset,target_dataset)

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
    %create the output matrix
    [~,length] = size(indices);
    train = zeros(length,29);
    train_target = zeros(length,1);
    
    %fill the output matrix
    train = train_dataset(indices,:);
    train_target = target_dataset(indices,:);
    
    %% LOL, the test = train :p
    test = train;
    test_target  = train_target;
    


