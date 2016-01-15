function [MobSort, GroupSort, Filtered] = OFETSearch(Constants,Variable)

%OFET Search
%
% OFET Search is the grandaddy master function that takes all the marbles
% Tell it what variables you want to be held constant at what value as a
% cell array:
% {'Process Field', 'Value';...
%  'other process field', 'other value to hold constant'}
% New: 'Value' can now be a vector with [LB, UB] if a range of values is
% desired

% And what variable you want to plot mobility against (must also be a valid process field):
% 'Variable'

% Returns :
% MobSort, mobility in a column vector sorted according to the column
% vector 'GroupSort'
%
% GroupSort, a column vector (if numeric) or column cell array of
% 'Variable' values for the mobilities in 'MobSort'
%
% Filtered, a structure array with the devices that satisfy the specified
% 'Constraints'

load('OFETDatabase.mat');

% Keep the devices that satisfy all the constants

Filtered = OFETFilter(OFET,Constants);

% If this variable is only NaN's and Numbers, Use OFETNumVar, else use
% OFETTextVar

if isnumeric([Filtered(:).(Variable)])
    [MobSort, GroupSort] = OFETNumVar(Filtered,Variable);
else
    [MobSort, GroupSort] = OFETTextVar(Filtered,Variable);
end

end

function [MobSort, GroupSort] = OFETNumVar(Filtered,Variable)

% Remove Devices that don't have a reported value for "Variable"

Filtered = RemoveNans(Filtered,Variable);
Groups = zeros(length(Filtered),1);
Mobs = zeros(length(Filtered),1);

for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
    Groups(i,1) = Filtered(i).(Variable);
    Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
end

% Sort the data so the variables are in increasing order

[GroupSort, idx] = sort(Groups);    % sort the groups in ascending order
MobSort = Mobs(idx,1);  % Also apply ths sorting to mobilities

GoodScatter(GroupSort,MobSort);
xlabel(Variable)
ylabel('Mobility (cm^2/Vs)')

end

function [MobSort, GroupSort] = OFETTextVar(Filtered,Variable)

% Insert 'None' for NaN values...

Filtered = RemoveNanInsertNone(Filtered,Variable);
Groups = cell(length(Filtered),1);
Mobs = zeros(length(Filtered),1);

for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
    Groups{i,1} = Filtered(i).(Variable);
    Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
end

% Sort the data so the variables are in increasing order

[GroupSort, idx] = sort(Groups);    % sort the groups in ascending order
MobSort = Mobs(idx,1);  % Also apply ths sorting to mobilities

GoodBox(GroupSort,MobSort);
xlabel(Variable)
ylabel('Mobility (cm^2/Vs)')

end
