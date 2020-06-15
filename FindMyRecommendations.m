% Find your movie recommendations
clear; close all; clc

load('movie_recommendations.mat')

%%
% Enter your ratings below. Enter 0 for any movie you did not rate.
Avengers = 3;
Hunger_Games = 2;
Tiger_King = 0;  
Inception = 4;
Dumb_and_Dumber = 0; 
Breaking_Bad = 0;
Black_Panther = 3;
Stranger_Things = 3;
Wizard_of_Oz = 0;
Walking_Dead = 0;
The_Office = 4;
Titanic = 0;
Star_Wars = 5;
Parks_and_Rec = 0;
Avatar = 3;
Harry_Potter = 1;
Game_of_Thrones = 0;
Shawshank_Redemption = 0;
Matrix = 3;
Planet_Earth = 0;
Parasite = 0;
Get_Out = 0;
Mandalorian = 0;
Ozark = 0;
Guardians_of_the_Galaxy = 5;

myRatings = [Avengers Hunger_Games Inception Dumb_and_Dumber...
    Breaking_Bad Black_Panther Stranger_Things Ozark Walking_Dead...
    The_Office Titanic Parks_and_Rec Get_Out Avatar Harry_Potter...
    Game_of_Thrones Shawshank_Redemption Matrix Planet_Earth...
    Tiger_King Wizard_of_Oz Star_Wars Parasite...
    Mandalorian Guardians_of_the_Galaxy];

A_filled = fillmissing(A,'constant',0);
rowNumber = find(ismember(A_filled,myRatings,'rows'));

fprintf('Movie                       My Rating    Recommendation\n')
for k = 1:20
   fprintf('%-24s         %1u            %4.2f\n',movie_list(k),round(A_filled(rowNumber,k)),A_final(rowNumber,k))
end
