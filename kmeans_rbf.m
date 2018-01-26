function kmeans_rbf(X, K, sigma)
%UNTITLED Summary of this function goes here

    n = size(X, 1); % size of the dataset
    d = size(X, 2); % dimension of data
    colors = ['r', 'b', 'k', 'g'];
    distances = zeros(size(X, 1), K);
    iterate = true;
    
    % plot non-clustered dataset
    plot(X(:,1), X(:,2), '.k', 'MarkerSize', 10);
    hold on;
    pause;
    
    rand_bin = round(1 + rand(size(X, 1), 1)); % randomly generate binary(1 or 2) values
    Y = [X, rand_bin]; % assign labels
    
    rbf = @(x_n, x_m) (exp(-(sum((x_n - x_m).^2)) / (2 * sigma ^ 2))); % rbf kernel
       
    while iterate
        clf;
        for p = 1:K
            temp = X(Y(:, end) == p, :);
            str = strcat('.', colors(p));
                        
            % plot newly assigned data points
            plot(temp(:,1), temp(:,2), str, 'MarkerSize', 10);
            hold on;
        end
        disp('Computing next iteration...');
        pause;
        
        for n = 1:size(X, 1) % compute distances for every object n
            for k = 1:K % for every cluster k
                N_k = size(Y(Y(:, end) == k, :), 1);
                temp1 = 0;
                temp2 = 0;
                for m = 1:size(X, 1)
                    temp1 = temp1 + (Y(m, end) == k) .* rbf(X(n, :), X(m, :));
                    for r = 1:size(X, 1)
                        temp2 = temp2 + (Y(m, end) == k) .* (Y(r, end) == k) .* rbf(X(m, :), X(r, :));
                    end
                end
                temp1 = 2 * temp1 / N_k;
                temp2 = temp2 / (N_k ^ 2);
                temp3 = rbf(X(n, :), X(n, :));
                distances(n, k) = temp3 - temp1 + temp2;
            end
        end
        [~,labels] = min(distances, [], 2); % get labels
        if(sum(Y(:, end) == labels) == size(X, 1))
            iterate = false;
            disp('exiting loop.');
        else
            disp('Updating...');
            Y = [X labels]; % Update assignment of labels
        end
    end
    disp('Convergence has reached.');
    title('Clusters after convergence.');
end