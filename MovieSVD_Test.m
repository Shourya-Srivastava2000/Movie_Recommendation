% Movie Recommendations - Remove 10% of the data to check if our system can
% accurately predict ratings. 
clear; close all; clc

load('movie_ratings.mat')

%% Remove some values for testing purposes
rng(13)
missing_ind = ismissing(A); % Find which entries of the matrix are missing
rating_ind = find(missing_ind==0); % Find which entries of the matrix are ratings
shuffle = randperm(length(rating_ind));  
n_test = floor(length(rating_ind)/10); % Number of entries to remove as test data (10%)  
test_ind = rating_ind(shuffle(1:n_test)); % Randomly shuffle the rated entries

A_orig = A; % Save original A matrix for later
A(test_ind) = missing; % Set the test data entries to missing

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

% Check the error
rmse = sqrt(sum((A_orig(test_ind)-A_final(test_ind)).^2)/n_test)




