function kmeans_linear(X, k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n = size(X, 1); % size of the dataset
    d = size(X, 2); % dimension of data
    colors = ['r', 'b', 'k', 'g'];
    
    centers = X(randperm(n, k), :); % initialize the k centers randomly
    last_centers = zeros(k, d);
    distances = zeros(n, k);
    
    % plot non-clustered dataset
    plot(X(:,1), X(:,2), '.k', 'MarkerSize', 10);
    hold on;
    pause;
    
    % plot the initial guess of cluster means
    for i = 1:k
        str_center = strcat(colors(i), '+');
        plot(centers(i,1), centers(i,2), str_center, 'MarkerSize', 15, 'LineWidth', 2);
        hold on;
    end
    pause;
    iter = 1;
    while(last_centers ~= centers) % iterate until the centers do not change
        last_centers = centers;
        for i = 1:k
            distances(:, i) = sqrt(sum(bsxfun(@minus,X,centers(i, :)).^2, 2)); % compute eucledian distance from centers
        end
        [~,labels] = min(distances, [], 2); % get labels
        Y = [X labels]; % assign labels
   
        for j = 1:k
            temp = X(Y(:, end) == j, :);
            str = strcat('.', colors(j));
                        
            % plot newly assigned data points
            plot(temp(:,1), temp(:,2), str, 'MarkerSize', 10);
            hold on;
            
            centers(j, :) = sum(temp) / size(temp, 1); % update centers
        end
        pause;
        clf;
        
        % plot newly updated centers
        for i = 1:k
            str_center = strcat(colors(i), '+');
            plot(centers(i,1), centers(i,2), str_center, 'MarkerSize', 15, 'LineWidth', 2);
            hold on;
        end
        
        % plot newly assigned data points
        for j = 1:k
            temp = X(Y(:, end) == j, :);
            str = strcat('.', colors(j));
                        
            plot(temp(:,1), temp(:,2), str, 'MarkerSize', 10);
            hold on;
        end
        pause;
        %iter
        %iter = iter + 1;
    end
    %close all;
end

