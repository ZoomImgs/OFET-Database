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

Filtered = OFET; % Start with the full structure

NumConst = size(Constants,1); % How many constraints are there
if NumConst>0
    for c = 1:NumConst
        Field = Constants{c,1};
        HoldValue = Constants{c,2};
        Filtered = OFETFilter(Filtered,Field,HoldValue);
    end
else
end

% Remove Devices that don't have a reported value for "Variable"

Filtered = RemoveNans(Filtered,Variable);
Groups = cell(length(Filtered),1);
Mobs = zeros(length(Filtered),1);

if isnumeric(Filtered(1).(Variable))
    numeric = true;
else
    numeric = false;
end

if numeric
    Groups = zeros(length(Filtered),1);
else
    Groups = cell(length(Filtered),1);
end

if numeric
    for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
        Groups(i,1) = Filtered(i).(Variable);
        Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
    end
else
    for i = 1:length(Filtered)      % Build up the either numeric or string matrix 'Groups'
        Groups{i,1} = Filtered(i).(Variable);
        Mobs(i,1) = Filtered(i).RTMob;  % and the corresponding mobilities
    end
end

% Sort the data so the variables are in increasing order

[GroupSort, idx] = sort(Groups);    % sort the groups in ascending order
MobSort = Mobs(idx,1);  % Also apply ths sorting to mobilities

% [hScat,hMarks,ax] = GoodBox(GroupSort,MobSort);

end
