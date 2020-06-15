% Movie Recommendations - Use all of the data to get final recommendations
clear; close all; clc

load('movie_ratings.mat')

%% Shift the data so each row has zero mean and fill in missing with zeros
avg_user_ratings = mean(A,2,'omitnan'); % Calculate row averages and ignore missing
A_shifted = A-avg_user_ratings;
A_shifted = fillmissing(A_shifted,'constant',0); % Fill in zeros for missing entries


%% Perform the method

r = 1; % Set the rank
rating_ind = ~ismissing(A); % indices of ratings

Ak = A_shifted; % Initial guess

for k = 1:1000
    [U,S,V] = svd(Ak,'econ');
    Akplus1 = U(:,1:r)*S(1:r,1:r)*V(:,1:r)'; % Rank-r approx
    Akplus1(rating_ind) = A_shifted(rating_ind); % Reset the values with known ratings
    if norm(Ak-Akplus1) < 1e-8 % If two guesses are close, we stop
        break
    end
    Ak = Akplus1;
end

A_final = Akplus1 + avg_user_ratings; % Add back in the row averages

%% Save the results
save('movie_recommendations.mat','A','movie_list','A_final')
