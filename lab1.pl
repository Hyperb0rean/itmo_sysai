% facts
% countries
great_power('Ming').
great_power('Mamluks').
great_power('England').
great_power('Ottomans').
great_power('France').
great_power('Castile').
great_power('Timurids').
great_power('Aragon').


lesser_power('Muscovy').
lesser_power('Poland').
lesser_power('Austria').
lesser_power('Portugal').
lesser_power('Venice').


% ideas
military_idea('Aristocratic').
military_idea('Divine').
military_idea('Horde').
military_idea('Indigenous').
military_idea('Plutocratic').
military_idea('Defensive').
military_idea('Mercenary').
military_idea('Naval').
military_idea('Offensive').
military_idea('Quality').
military_idea('Quantity').


% rivals
rivals_to('England','France').
rivals_to('Muscovy','Poland').
rivals_to('France','Austria').
rivals_to('Austria','Ottomans').
rivals_to('Ottomans','Poland').
rivals_to('Aragon','Ottomans').
rivals_to('Venice','Ottomans').


friends_to('England','Portugal').
friends_to('Austria','Castile').
friends_to('Castile','Aragon').
friends_to('France','Poland').



% rules
rivals(X, Y) :- rivals_to(Y, X);rivals_to(X, Y).
friends(X, Y) :- friends_to(Y, X);friends_to(X, Y).

friends(X,Y) :- X/=Y, rivals(X,Z),rivals(Z,Y),!.

enemies(X,Y) :- rivals(X,Y), great_power(X), great_power(Y).

idea_pick(CountryX,CountryY,IdeaX, List) :- 
    enemies(CountryX,CountryY), military_idea(IdeaX),
    findall(M,military_idea(M), List).

friends_count(F, Count):-
    findall(M, friends(M, F), List), length(List, Count).

enemies_count(F, Count):-
    findall(M, enemies(M, F), List), length(List, Count).

enemies_list(F, List):-
    findall(M, enemies(M, F), List).

friends_list(F, List):-
    findall(M, friends(M, F), List).

% queries

% friends_count('Austria', Count).

% enemies_count('England', Count).

% idea_pick('England', 'France', 'Defensive', List).