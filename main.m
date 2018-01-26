clc;
close;
clear;

load hw5_p1a.mat;
load Y_2.mat; % labels after 2nd iteration
load Y_final.mat; % labels after convergence
Y(Y(:,end) == 2, end) = 0;
Y2(Y2(:,end) == 2, end) = 0;

temp1 = X(Y2(:, end) == 1, :);
temp2 = X(Y2(:, end) == 0, :);
temp3 = X(Y(:, end) == 1, :);
temp4 = X(Y(:, end) == 0, :);

%%
plot(temp3(:,1), temp3(:,2), '.r', 'MarkerSize', 10);
hold on;
plot(temp4(:,1), temp4(:,2), '.b', 'MarkerSize', 10);
hold on;
%%
Y_change = [Y2(:, end) Y(:, end)];
%%
l = Y_change(:, 1);
r = Y_change(:,2);
%%
C = xor(l, r);
%%
Y = [Y C];
changes = Y(Y(:, end) == 1, 1:2);
plot(changes(:,1), changes(:,2), 'ko');

legend('Class 1', 'Class 2', 'Changed assignment since Iter 2');
title('Clusters after convergence');
