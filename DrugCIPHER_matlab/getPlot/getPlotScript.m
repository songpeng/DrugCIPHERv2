%% get known gene-drug pair plot
g2d_pair = load('g2d_pair.txt');
location = g2d_pair(randperm(7438), :);
location = location(1:30, :);
getPlot( g2d_closeness, c2d_similarity, location, 6, 5 );


%% get random gene-drug pair plot
% x = transpose(randperm(13388));
% y = transpose(randperm(3545));
% location(:, 1) = x(1:30);
% location(:, 2) = y(1:30);
% getPlot( g2d_closeness, c2d_similarity, location, 6, 5 );
