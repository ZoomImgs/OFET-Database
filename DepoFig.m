function [hScat,hMarks,ax] = DepoFig()

[MobSort, GroupSort, Filtered] = OFETSearch({'ElectrodeMat','Au'},'Depo');

[hScat,hMarks,ax] = GoodBox(GroupSort,MobSort);

whos Filtered

ax.XTickLabels = {'Dip-coated'; 'Drop-cast'; 'Spin-coated'};
ax.XTickLabelRotation = 0;

end
