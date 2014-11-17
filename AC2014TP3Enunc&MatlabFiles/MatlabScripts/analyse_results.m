load('dataset/results.mat', 'results');

[num_sim, num_fields] = size(results);

counter = 1;

%{
1) = filename
2) = performance
3) = network_outputs
4) = binary_results
5) = results_data
 = [accuracy, specificity, sensitivity, t_p, t_n, f_p, f_n, 
    binary_positives, binary_negatives, invalids, expected_positives,
    expected_negatives]
%}

%% perform averages for each unique simulation
unique_sim = unique(results(:,1));
len_unique_sim = length(unique_sim);

%% performances
performance_means = zeros(len_unique_sim,1);
for i = 1:len_unique_sim
    performance_means(i) = mean( results{find( strcmp(results(:,1), unique_sim(i))==1 ), 2} );
end

figure(counter);
hold on;
plot( performance_means);
%plot( repmat([mean(performance_means)], len_unique_sim), 'r'); %average of the averages
hold off;
print(counter, '-dpng', 'images/results/performances');
counter = counter + 1;
close;



%% results data
len_results_data = length(cell2mat(results(1,5)));
results_data_means = zeros(len_unique_sim, len_results_data+1);
results_data_means(:, 1) = 1:len_unique_sim;
for i = 1:len_unique_sim
    for j = 1: len_results_data
        temp = results{find( strcmp(results(:,1), unique_sim(i))==1 ), 5};
        results_data_means(i, j+1) = mean(temp(:, j));
    end
end    

data_name = {'accuracy', 'specificity', 'sensitivity', 't_p', 't_n', 'f_p', 'f_n', 'binary_positives', 'binary_negatives', 'invalids', 'expected_positives', 'expected_negatives'};
for j = 2: len_results_data+1
    
    % save image of all results and 
    figure(counter);
    hold on;
    plot( results_data_means(:, j) );
    plot( repmat([mean(results_data_means(:, j))], len_unique_sim), 'r'); %average of the averages
    hold off;
    print(counter, '-dpng', strcat('images/results/', data_name{j-1}));
    counter = counter + 1;
    close;
    
    % get num_best best of each aspect and save their matrix
    num_best = 20;
    sorted = sortrows(results_data_means, j);
    sorted = flipud(sorted); %magia do matlab, invert ordem da matrix nas colunas (1� passa a �ltimo e vice-versa)
    best = cell(num_best, 2);
    best(:, 1) = unique_sim(sorted(1:num_best,1));
    for i = 1:num_best
        best(i, 2) = {sorted(i, j)};
    end
    save(strcat('images/results/X_best/', num2str(num_best), '_', data_name{j-1}, '.mat'), 'best');    


end


%% network outputs and binary outputs 


%% clean environment
close all;
clear all;
