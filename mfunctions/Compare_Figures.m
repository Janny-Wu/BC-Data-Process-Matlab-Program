function[aaa]=Compare_Figures()

%str={'Spring','Summer','Fall','Winter','Weekdays','Weekends','Heating','NonHeating'};
%str={'Spring','Summer','Fall','Winter',...%ÿ�����ڵ�4��Ƚ� 4
  %  '2016Seasons','2017Seasons','AllSeason',...%ͬһ���е�4���Ƚ� 7
   % 'Weekdays','Weekends',...%����)�����յ�4��Ƚ� 9
   % '2016Week','2017Week','AllWeek',...%ͬһ���еĹ�����/�ǹ����ձȽ� 12
   % '2015WinterWeek','2016WinterWeek','2017WinterWeek','AllWinterWeek'...%16 ͬһ��"����"�еĹ�����/�ǹ����ձȽ�
  %  'Heating','NonHeating',...%���ǣ���ů���Ķ���Ƚ�18 
  %  '2016Heating','2017Heating','AllHeating','Last2Heating',...%22ͬһ���еĲ�ů/�ǲ�ů���Ƚ�
  %  'Years',...%2016��2017��ıȽ� 23
  %  'Traffic_Winter','Traffic_Summer','Traffic_Fall','Traffic_Spring',... %27
  %  'Traffic_2016Seasons','Traffic_2017Seasons',...%29
   % 'Traffic_2016Week','Traffic_2017Week','Traffic_AllWeek',... %32
 %   'Traffic_2015WinterWeek','Traffic_2016WinterWeek','Traffic_2017WinterWeek','Traffic_AllWinterWeek',...%36
 %   'Traffic_2016Heating','Traffic_2017Heating','Traffic_AllHeating','Traffic_Last2Heating',...%40
  %  'Traffic_Year'};%41
str={ 'Weekdays','Weekends',...%����)�����յ�4��Ƚ� 9
    '2016Week','2017Week','AllWeek',...%ͬһ���еĹ�����/�ǹ����ձȽ� 12
    '2015WinterWeek','2016WinterWeek','2017WinterWeek','AllWinterWeek',...%16 ͬһ��"����"�еĹ�����/�ǹ����ձȽ�
    'Traffic_Winter','Traffic_Summer','Traffic_Fall','Traffic_Spring',... %27
    'Traffic_2016Seasons','Traffic_2017Seasons',...%29
    'Traffic_2016Week','Traffic_2017Week','Traffic_AllWeek',... %32
    'Traffic_2015WinterWeek','Traffic_2016WinterWeek','Traffic_2017WinterWeek','Traffic_AllWinterWeek',...%36
    'Traffic_2016Heating','Traffic_2017Heating','Traffic_AllHeating','Traffic_Last2Heating',...%40
    'Traffic_Year',...
    'Traffic_2015WinterQ','Traffic_2016WinterQ','Traffic_2017WinterQ',...
    'Traffic_2016Q','Traffic_2017Q'};%41

%colorcell=cell(1,3);
colorall(:,:,1)=[255 255 0]/255;
colorall(:,:,2)=[255 106 106]/255;
colorall(:,:,3)=[0 255 255]/255;
colorall(:,:,4)=[127 255 0]/255;
colorall(:,:,5)=[255 0 255]/255;
colorall(:,:,6)=[255 236 139]/255;


for k=1:size(str,2)
Filepath=char(str(k))
mkdir ('D:\BC_Figures\output\figure\Distribution\Comparison\',Filepath);

aastr=strcat('D:\BC_Figures\data\BC_4_merge\Comparison\',Filepath);
cd (aastr)
dir;
filepath=dir;
filenum=size(dir);

wenjian=filenum(1)-2;

%��ȡ����õ������ļ�
for p=3:filenum
    parta=strcat(aastr,'\');
    partb=filepath(p).name;
read_data_name=strcat(parta,partb);
%Datastr=extractBefore(partb,'.');
%��ȡʱ���
may0=readtable(read_data_name);
may1=table2timetable(may0);
a=size(may1,1);b=size(may1,2); 
%�õ�ʱ���ʱ�����
tt=may1.Date_Time;
dat_1=datevec(may1.Date_Time);
yy=dat_1(:,1);mm=dat_1(:,2);dd=dat_1(:,3); hh=dat_1(:,4);mimi=dat_1(:,5);ss=dat_1(:,6);
%���BC %ת��Ϊug/m3
BC6=may1.BC6_AFDT/1000;
%BC6(1:size(tt,1),p-2)=BC6temp;
%clear may0 may1 a b tt dat_1 yy mm dd ss hh
str_num=p-2;
if k<=9
mergeBC(str_num)=struct('cluster',BC6);
else 
    traffic=may1.traffic;
mergeBC(str_num)=struct('cluster',BC6,'traffic',traffic);
end
end

%����Ƶ�ʷֲ�ֱ��ͼ
%titlestr = strcat(Datastr,' Distribution');
outputstr=strcat('D:\BC_Figures\output\figure\Distribution\Comparison\',Filepath,'\',Filepath);
%================3.��׼��Ϊ1��Ƶ��ֱ��ͼ=======================]
pattern='all';
TF = contains(filepath(end).name,pattern);

if TF

if k<=9
figure(3)%��׼��Ϊ1��Ƶ��ֱ��ͼ
for q=1:wenjian-1
%h1 = histogram(mergeBC(q).cluster,10,'Normalization','probability');
[n,bins]=hist(mergeBC(q).cluster,20);
h1=bar(bins,n/length(mergeBC(q).cluster));
set(h1,'FaceColor',colorall(:,:,q),'LineWidth',1,'EdgeColor','w','BarWidth',1);
hold on
end
yyaxis left
ax=gca;ylabel('Frequency');
hold on
yyaxis right  % ���ұߵ�y��չʾ
for q=1:wenjian
cdfplot(mergeBC(q).cluster);
ax=gca;
ax.XLim=[0 35];
end
xlabel('BC Concentration[��g/m^{3}]','Fontname','times new Roman');
ylabel('Empirical CDF');
YGrid='on';
else
    figure(3)%��׼��Ϊ1��Ƶ��ֱ��ͼ
for q=1:wenjian-1
%h1 = histogram(mergeBC(q).cluster,10,'Normalization','probability');
[n,bins]=hist(mergeBC(q).traffic,20);
h1=bar(bins,n/length(mergeBC(q).traffic));
set(h1,'FaceColor',colorall(:,:,q),'LineWidth',1,'EdgeColor','w','BarWidth',1);
hold on
end
yyaxis left
ax=gca;ylabel('Frequency');
hold on
yyaxis right  % ���ұߵ�y��չʾ
for q=1:wenjian
cdfplot(mergeBC(q).cluster);
ax=gca;
ax.XLim=[0 1];
end
xlabel('Traffic Ratio','Fontname','times new Roman');
ylabel('Empirical CDF');
YGrid='on';
end

if k<=9
title(strcat(Filepath,' BC Distribution'),'Fontname','times new Roman');
else 
    title(strcat(Filepath,'Traffic Ratio Distribution'),'Fontname','times new Roman');
end
legendcell=cell(1,wenjian*2-1);
    for j=1:wenjian-1
legendcell(1,j)=cellstr(extractBefore(filepath(j+2).name,'.xlsx'));
    end
    for j=wenjian:wenjian*2-1
legendcell(1,j)=cellstr(extractBefore(filepath(j-wenjian+3).name,'.xlsx'));
    end
legend(legendcell);

else    
if k<=9
figure(3)%��׼��Ϊ1��Ƶ��ֱ��ͼ
for q=1:wenjian
%h1 = histogram(mergeBC(q).cluster,10,'Normalization','probability');
[n,bins]=hist(mergeBC(q).cluster,20);
h1=bar(bins,n/length(mergeBC(q).cluster));
set(h1,'FaceColor',colorall(:,:,q),'LineWidth',1,'EdgeColor','w','BarWidth',1);
hold on
end
yyaxis left
ax=gca;ylabel('Frequency');
hold on
yyaxis right  % ���ұߵ�y��չʾ
for q=1:wenjian
cdfplot(mergeBC(q).cluster);
ax=gca;
ax.XLim=[0 35];
end
xlabel('BC Concentration[��g/m^{3}]','Fontname','times new Roman');
ylabel('Empirical CDF');
YGrid='on';
else
    figure(3)%��׼��Ϊ1��Ƶ��ֱ��ͼ
for q=1:wenjian-1
%h1 = histogram(mergeBC(q).cluster,10,'Normalization','probability');
[n,bins]=hist(mergeBC(q).traffic,20);
h1=bar(bins,n/length(mergeBC(q).traffic));
set(h1,'FaceColor',colorall(:,:,q),'LineWidth',1,'EdgeColor','w','BarWidth',1);
hold on
end
yyaxis left
ax=gca;ylabel('Frequency');
hold on
yyaxis right  % ���ұߵ�y��չʾ
for q=1:wenjian
cdfplot(mergeBC(q).cluster);
ax=gca;
ax.XLim=[0 1];
end
xlabel('Traffic Ratio','Fontname','times new Roman');
ylabel('Empirical CDF');
YGrid='on';
end
if k<=9
title(strcat(Filepath,' BC Distribution'),'Fontname','times new Roman');
else 
    title(strcat(Filepath,'Traffic Ratio Distribution'),'Fontname','times new Roman');
end


legendcell=cell(1,wenjian*2);
    for j=1:wenjian
legendcell(1,j)=cellstr(extractBefore(filepath(j+2).name,'.xlsx'));
    end
    for j=wenjian+1:wenjian*2
legendcell(1,j)=cellstr(extractBefore(filepath(j-wenjian+2).name,'.xlsx'));
    end
legend(legendcell);

end
%����ͼƬ
PRystring3=strcat(outputstr,'_All_ProbN1+ECDF.jpg');
saveas(3,PRystring3,'jpg');
saveas(3,strcat(outputstr,'_All_ProbN1+ECDF','.fig'));
print(3,'-djpeg','-r1000',PRystring3);
clear mergeBC
close all
end

aaa=1;


end
