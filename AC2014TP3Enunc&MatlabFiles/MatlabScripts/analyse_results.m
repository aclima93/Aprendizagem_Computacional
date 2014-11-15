load('dataset/results.mat', 'results');

[num_sim, num_fields] = size(results);

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

% performances
performance_means = zeros(len_unique_sim,1);
for i = 1:len_unique_sim
    performance_means(i) = mean( results{find( strcmp(results(:,1), unique_sim(i))==1 ), 2} );
end
%{
hold on;
plot( performance_means);
plot( mean(performance_means), 'r'); %average of the averages
hold off;
pause;
%}

% results data
len_results_data = length(results(1,5));
results_data_means = zeros(len_unique_sim, len_results_data);
for i = 1:len_unique_sim
    for j = 1: len_results_data
        temp = results{find( strcmp(results(:,1), unique_sim(i))==1 ), 5};
        results_data_means(i, j) = mean( temp(:, j) );
    end
end    

% print the network outputs and binary outputs just for show in report?


