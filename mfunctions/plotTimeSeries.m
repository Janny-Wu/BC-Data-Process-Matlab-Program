function [picwhether]= plotTimeSeries(BC6,tt,Datastr,Filepath)
picwhether=0;
%ymax=nanmax(BC6);
mkdir('D:\BC_Figures\output\figure\Timeseries\',Filepath);
titlestr=strcat(Datastr,' BC Concentration');
outputstr=strcat('D:\BC_Figures\output\figure\Timeseries\',Filepath,'\',titlestr);

figure(1)
h=plot(tt,BC6,'-b',...
    'LineWidth',0.3,...
    'MarkerSize',0.1);
   %'MarkerFaceColor',[1,0.84314,0]);
datetick('x',26,'keepticks'); %�����Ļ����бȽ϶��X��С�̶�
set(h,'Color',[0,91,255]/255);
set(gcf,'unit','centimeters','position',[0.01 5 33.3 12]) ;

ax=gca;
ax.TickDir='out';
ax.XLabel.String='Date';
ax.YLabel.String='BC (��g/m^{3})','Fontname';'times new Roman';
ax.FontSize=10;
%ax.YLim=[0 ymax];
title(titlestr,'Fontname','times new Roman');
%hold on
%plot([datetime(2015,12,17,0,0,0) datetime(2015,12,17,0,0,0)], [0 ymax],'--k');
%plot([datetime(2015,12,5,0,0,0) datetime(2015,12,5,0,0,0)], [0 ymax],'--k');

legend('BC Concentration');
%ax.Legend.TextColor = [1,0.84314,0]; %����ǳ�ɫ�����壬��ѽ

%��������BCʱ��ͼ����
pdfstring=strcat(outputstr,'.pdf');jpgstring=strcat(outputstr,'.jpg');
print(1,'-djpeg','-r1000',jpgstring); %�޸ķֱ��ʱ���
saveas(1,strcat(outputstr,'.fig'));
%saveas(gcf,pdfstring,'pdf');
%saveas(gcf,pngstring,'png');
%saveas(gcf,'myfig.jpg');

picwhether=1;
end
