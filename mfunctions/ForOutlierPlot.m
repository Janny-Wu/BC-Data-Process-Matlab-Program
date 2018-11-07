function[aaa]=ForOutlierPlot(Datastr,tt,BC6) 
%BC_outliers\choosed_day_examine���л��õ����������

picwhether=0;
mkdir('D:\BC_Figures\data\BC_outliers\output\choosed_days\Timeseries\');
titlestr=strcat(Datastr,' BC');
outputstr=strcat('D:\BC_Figures\data\BC_outliers\output\choosed_days\Timeseries\',titlestr);

figure(1)
h=plot(tt,BC6,'-b',...
    'LineWidth',0.3,...
    'MarkerSize',0.1);
   %'MarkerFaceColor',[1,0.84314,0]);
datetick('x',31,'keepticks'); %�����Ļ����бȽ϶��X��С�̶�
set(h,'Color',[0,0.749,1]);
set(gcf,'unit','centimeters','position',[0.01 5 33.3 12]) ;

ax=gca;
ax.TickDir='out';
ax.XLabel.String='Date';
ax.YLabel.String='BC (ug/m^{3})','Fontname';'times new Roman';
ax.FontSize=10;
title(titlestr,'Fontname','times new Roman');

legend('BC Concentration');
%ax.Legend.TextColor = [1,0.84314,0]; %����ǳ�ɫ�����壬��ѽ

%��������BCʱ��ͼ����
pdfstring=strcat(outputstr,'.pdf');jpgstring=strcat(outputstr,'.jpg');
print(1,'-djpeg','-r1000',jpgstring); %�޸ķֱ��ʱ���
saveas(1,strcat(outputstr,'.fig'));

picwhether=1;


aaa=1;
end