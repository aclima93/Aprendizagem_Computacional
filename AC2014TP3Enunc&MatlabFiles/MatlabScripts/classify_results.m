function [binary_results, results_data] = classify_results(method, results, expected_results)
    
    %% convert results to binary code
    % >= 0.5 --> 1
    %  < 0.5 --> 0
    
    binary_results = results;
    i_ones = find(binary_results >= 0.5);
    [x, y] = size(binary_results);
    indexes = 1:(x*y);
    i_zeros = setdiff(indexes, i_ones);
    binary_results(i_ones) = 1;
    binary_results(i_zeros) = 0;
    
    %% evaluate binary results based on classification method
    if strcmp(method, '10 consecutive ictals') == 1
        window_size = 10;
        positives_size = 10;
    elseif strcmp(method, 'at least 5 of the last 10 are ictals') == 1
        window_size = 10;
        positives_size = 5;
    elseif strcmp(method, 'single point') == 1
        window_size = 1;
        positives_size = 1;
    end
   

    %% classify points
    ictal_class = zeros(y - window_size, 1);
    for i=1:y - window_size
        
        %Check if current window has at least one valid value
        end_ind = i + window_size - 1;
        invalid_counter = (length(find(binary_results(1,i:end_ind) == 0 & binary_results(2,i:end_ind) == 0)) );
        temp = length(find(binary_results(1,i:end_ind) == 1 & binary_results(2,i:end_ind) == 1));
        invalid_counter = invalid_counter + temp;
        
        %All the values are invalid, so the correspondent result is invalid
        if (invalid_counter == window_size)
            ictal_class(i) = -1;
        
        else
            num_ones = length(find(binary_results(1,i:end_ind) == 0 & binary_results(2,i:end_ind) == 1));
            ictal_class(i) = (num_ones >= positives_size);
        end
    end

    %% count number of true/false positives/negatives
    b_r_p = find(binary_results == 1);
    b_r_n = find(binary_results == 0);
    e_r_p = find(expected_results == 1);
    e_r_n = find(expected_results == 0);
    
    t_p = length( intersect(b_r_p, e_r_p));
    f_p = length( intersect(b_r_p, e_r_n));
    t_n = length( intersect(b_r_n, e_r_n));
    f_n = length( intersect(b_r_n, e_r_p));
    
    %% calculate specificity and sensitivity
    sensitivity = t_p / (t_p + f_n);
    specificity = t_n / (t_n + f_p);
    
    binary_positives = length(e_r_p);
    binary_negatives = length(e_r_n);
    invalids = find(binary_results == -1);
   
    expected_positives = length(e_r_p);
    expected_negatives = length(e_r_n);
    
    results_data = [specificity, sensitivity, t_p, t_n, f_p, f_n, binary_positives, binary_negatives, invalids, expected_positives, expected_negatives];


end