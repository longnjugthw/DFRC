load offset_SH.mat;
load offset_BM.mat;
load offset_RM.mat;

% load offset_SH30.mat;
% load offset_BWM30.mat;
% load offset_RWM30.mat;

% load offset_narma20SH.mat;
% load offset_narma20BWM.mat;
% load offset_narma20RWM.mat;

t = tiledlayout(1,3);
xlabel(t,'Settings');
ylabel(t,'NRMSE');

ax1 = nexttile;
boxplot(SH,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% boxplot(OffsetSH30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax1,45);
ylim([0.05 0.7]);
grid on;
title('Sample & Hold','FontSize', 9);

ax2 = nexttile;
boxplot(BWM,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% boxplot(OffsetBWM30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax2,45);
ylim([0.05 0.45]);
grid on;
title('Binary Weight Mask','FontSize', 9);

ax3 = nexttile;
boxplot(RWM,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% boxplot(OffsetRWM30,'Color',[0, 0.15, 0.7410],'Notch','on','Labels',{'SIDM','DISM','DIDM'});
% xtickangle(ax3,45);
ylim([0.05 0.45]);
grid on;
title('Real Weight Mask','FontSize', 9);

lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', [0.8500 0.3250 0.0980]);
linkaxes([ax1,ax2,ax3],'y');