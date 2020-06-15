% Show Movie Rating Info
clear; close all; clc

load('movie_ratings.mat')


%% Show movie list
for k = 1:25
   fprintf('%s  \n',movie_list(k))
end

%% Number of viewers per movie:
clc
num_viewers = zeros(1,25);
for k = 1:25
    num_viewers(k) = sum(~ismissing(A(:,k)));
end

% Make a table
[~,ind] = sort(num_viewers,'descend');
fprintf('Movie                     Number of Viewers\n')
for k = ind
   fprintf('%-24s         %3u \n',movie_list(k),num_viewers(k))
end


%% Ratings by movie
clc
avg_ratings = zeros(1,25);
for k = 1:25
    avg_ratings(k) = mean(A(:,k),'omitnan');
end

% Make a table
[~,ind] = sort(avg_ratings,'descend');
fprintf('Movie                       Average Rating\n')
for k = ind
   fprintf('%-24s         %4.2f \n',movie_list(k),avg_ratings(k))
end


