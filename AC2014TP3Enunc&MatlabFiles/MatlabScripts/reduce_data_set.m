function [ reduced_data ] = reduce_data_set( data_set, target_set, num_characteristics )

    % Compute sample correlation and p-values.
    % Find significant correlations, don't count the target
    % 1 and -1 are the most important, 0 is worthless
    [r,p] = corrcoef(horzcat(data_set', target_set(1,:)'));
    [x,~] = size(p);
    indexed_corr = vertcat(abs(r(length(p),1:(x-1))), 1:(x-1));
    reduced_correlations = cell(length(indexed_corr), 1);

    for i = 1:length(indexed_corr)
        reduced_correlations{i} = indexed_corr(1,i);
    end

    % sort by correlation but maintain index information and filter the best X elements
    temp = [reduced_correlations{:}];
    [~, ind] = sort( temp(1,:), 'descend');
    best_rc_ind = ind(1:num_characteristics);
    reduced_data = data_set(best_rc_ind, :);


end

