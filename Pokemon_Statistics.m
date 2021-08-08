clear all
close all
clc

T = readtable('weight.xlsx');

White_Data = [];
w = 1;

Green_Data = [];
g = 1;

All_Data = T{:,4};

for i = 1:length(T{:,1})
    if double(string(T{i,5})) == NaN
        continue
    end


    color = string(T{i,5});
    if color == 'White'
        White_Data(w) = str2num(string(T{i,4}));

        w = w + 1;
    elseif color == 'Green'
        Green_Data(g) = str2num(string(T{i,4}));

        g = g + 1;
    end
end


%Plot white and gather stats
figure('Name','Pokemon');
subplot(1,3,1)
xlabel('White Data')
w_nbins = round(length(White_Data)) ;
histogram(White_Data, w_nbins)
White_Mean = mean(White_Data);
White_std = std(White_Data);
[h,p,w_ci,stats] = ttest(White_Data);
line([White_Mean, White_Mean], ylim, 'LineWidth', 2, 'Color', 'r');
line([w_ci(1),w_ci(1)], ylim, 'LineWidth', 1, 'Color', 'g');
line([w_ci(2),w_ci(2)], ylim, 'LineWidth', 1, 'Color', 'g');


%Plot green and gather stats
subplot(1,3,2)
title('Green Data')
g_nbins = round(length(Green_Data)/1.5) ;
histogram(Green_Data, g_nbins)
Green_Mean = mean(Green_Data);
Green_std = std(Green_Data);
[h,p,g_ci,stats] = ttest(Green_Data);
line([Green_Mean, Green_Mean], ylim, 'LineWidth', 2, 'Color', 'r');
line([Green_Mean, Green_Mean], ylim, 'LineWidth', 2, 'Color', 'r');
line([g_ci(1),g_ci(1)], ylim, 'LineWidth', 1, 'Color', 'g');
line([g_ci(2),g_ci(2)], ylim, 'LineWidth', 1, 'Color', 'g');


%Plot all and gather stats
subplot(1,3,3)
title('All Data')
a_nbins = round(length(All_Data)) ;
histogram(All_Data, g_nbins)
All_Mean = mean(All_Data);
All_std = std(All_Data);
[h,p,a_ci,stats] = ttest(All_Data);
line([All_Mean, All_Mean], ylim, 'LineWidth', 2, 'Color', 'r');
line([All_Mean, All_Mean], ylim, 'LineWidth', 2, 'Color', 'r');
line([a_ci(1),a_ci(1)], ylim, 'LineWidth', 1, 'Color', 'g');
line([a_ci(2),a_ci(2)], ylim, 'LineWidth', 1, 'Color', 'g');