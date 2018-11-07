function[struct_Detected]=Processing_DetectLimit(struct_Separated)
mon_num=length(struct_Separated);
Filepath='Month';

for m=1:mon_num
ttNow=struct_Separated(m).Timetable;
%����BC1��BC6����һdeltaֵ
BC6_tmp=ttNow.BC6_;
    BC1_tmp=ttNow.BC1_;
delta_tmp_BC6=zeros(length(BC6_tmp),1);
delta_tmp_BC6(~isnan(delta_tmp_BC6))=NaN;
    delta_tmp_BC1=zeros(length(BC1_tmp),1);
    delta_tmp_BC1(~isnan(delta_tmp_BC1))=NaN;
    
for j=2:length(BC6_tmp)
delta_tmp_BC6(j)=BC6_tmp(j)-BC6_tmp(j-1);
    delta_tmp_BC1(j)=BC1_tmp(j)-BC1_tmp(j-1);
end
%�Ѽ��������ÿ�������delta���ϲ���ʱ�������Ϊһ�У�deltaBC1��6
varNames = {'delta_tmp_BC6','delta_tmp_BC1'};
ttTMP1=timetable(ttNow.Date_Time,delta_tmp_BC6,delta_tmp_BC1);
ttTMP1.Properties.VariableNames=varNames;

%��ÿ��delta����λ����������Ϊ0���õ����շ���Ƶ�����ݵ�����
%ttDT=retime(ttTMP1,'daily',@nanmedian);
                                                                                    %����Hagler��ONA����˵��ƽ�����ˡ���
ttTMP1.delta_BC6=abs(ttTMP1.delta_tmp_BC6);

ttTMP1.delta_BC1=abs(ttTMP1.delta_tmp_BC1);

ttDT=retime(ttTMP1,'daily',@nanmedian);
ttDT.DT_6_1min=ttDT.delta_BC6;
    ttDT.DT_1_1min=ttDT.delta_BC1;
ttDT.DT_6_1min(ttDT.delta_BC6<0)=0;
    ttDT.DT_1_1min(ttDT.delta_BC1<0)=0;

%����60���õ�����Сʱƽ�����ݵ�������Ȼ��������3*������
ttDT.DT_6_1h=3*ttDT.DT_6_1min/60;ttDT.DT_1_1h=3*ttDT.DT_1_1min/60;

%���������ߵ����飬ÿһ��Ԫ���ظ�24�Σ��Ա��������ıȽ�
aha1=repmat(ttDT.DT_6_1h',24,1);
DT_6=reshape(aha1,length(ttDT.DT_6_1h)*24,1);
    aha2=repmat(ttDT.DT_1_1h',24,1);
    DT_1=reshape(aha2,length(ttDT.DT_1_1h)*24,1);

%��BC6��BC1�����ݷֱ�ͼ���߶Աȣ�С�ڼ���ߵ�Сʱ������NaN���档
%ɾ�������ַ����У���ʹ�ܹ��ع�ʱ�����Сʱƽ����
%ttNow = removevars(ttNow, 'Date');
%ttNow = removevars(ttNow, 'Date_Time_1');
ttHourTemp=retime(ttNow,'hourly',@nanmean);
ttHourTemp.DT6=DT_6;ttHourTemp.DT1=DT_1;
ttHourTemp.BC6_tbd=ttHourTemp.BC6_15min;
    ttHourTemp.BC1_tbd=ttHourTemp.BC1_15min;
ttHourTemp.BC6_tbd(ttHourTemp.BC6_15min<ttHourTemp.DT6)=NaN;
    ttHourTemp.BC1_tbd(ttHourTemp.BC1_15min<ttHourTemp.DT1)=NaN;

%�õ�����ֱ���ǵõ�һ��HourlyMean��ʱ�����
%ֻѡ��������
tt=ttHourTemp.Date_Time;
Year=year(ttHourTemp.Date_Time);
Month=month(ttHourTemp.Date_Time);
Day=day(ttHourTemp.Date_Time);
Hour=hour(ttHourTemp.Date_Time);
BC1_raw=ttHourTemp.BC1_;
BC1_traffic=ttHourTemp.BC6_traffic;
BC1_baseline=ttHourTemp.BC1_15min;
BC1_AFDT=ttHourTemp.BC1_tbd;
BC2=ttHourTemp.BC2_;
BC3=ttHourTemp.BC3_;
BC4=ttHourTemp.BC4_;
BC5=ttHourTemp.BC5_;
BC6_raw=ttHourTemp.BC6_;
BC6_traffic=ttHourTemp.BC6_traffic;
BC6_baseline=ttHourTemp.BC6_15min;
BC6_AFDT=ttHourTemp.BC6_tbd;
DT1=ttHourTemp.DT1;
DT6=ttHourTemp.DT6;

%������ϸ������ݣ��õ�ttHourMean
ttHourMean=timetable(tt,Year,Month,Day,Hour,BC1_raw,BC1_traffic,...
    BC1_baseline,BC1_AFDT,BC2,BC3,BC4,BC5,BC6_raw,BC6_traffic,BC6_baseline,BC6_AFDT,DT1,DT6);
%����ԭʼ�����У�һСʱ��������
ttCount=retime(ttNow,'hourly','count');
Count=ttCount.BC6_15min;
ttHourMean.Count=Count;
%������tt->Date_Time
ttHourMean.Properties.DimensionNames{1} = 'Date_Time';

%ɾ��С��30��������Сʱ,�õ�ttHourMean1
ttHourMean1=ttHourMean;
ttHourMean1.BC6_AFDT(ttHourMean.Count<30)=NaN;
ttHourMean1.BC1_AFDT(ttHourMean.Count<30)=NaN;

%ɾ��BC6>BC1��Сʱ���õ�ttHourMean2
ttHourMean2=ttHourMean1;
ttHourMean2.BC6_AFDT(ttHourMean1.BC6_AFDT>ttHourMean1.BC1_AFDT)=NaN;

%ɾ���У�Ȼ�����²�ȫʱ���
ttVamos=rmmissing(ttHourMean2);
dat_Vamos=datevec(ttVamos.Date_Time);
yy=dat_Vamos(:,1);mm=dat_Vamos(:,2);dd=dat_Vamos(:,3);
Tmp_a=size(ttVamos,1);
tv = [datetime(yy(1),mm(1),1,0,0,0):hours(1):datetime(yy(1),mm(1),dd(Tmp_a-1),23,59,00)]';

ttHourMean3 = retime(ttVamos,tv);
%ttCount2=retime(ttHourMean2,'daily','count');

%���Ϊ����õľ���~
mkdir('D:\BC_Figures\data\BC_3_DetectionLimit\BC_DTplot\',Filepath);

struct_Detected(m)=struct('Timetable',ttHourMean3,'BC1',ttHourMean3.BC1_AFDT,'BC6',ttHourMean2.BC6_AFDT);

%���Ϊexcel�ĵ�
%[Labelcell]=createLabelcell();
%titlestr=Labelcell(m);
yystr=num2str(yy(1));mmstr=num2str(mm(1));
    if (mm(1)<10&&mm(1)>=1)
        mmstr=strcat('0',mmstr);
    end
titlestr=strcat(yystr,mmstr);
    
output_path_2='D:\BC_Figures\data\BC_3_DetectionLimit\BC_Detected\Fulltime\';
output_filename_2=strcat(output_path_2,char(titlestr),'.xlsx');
[~]=fromTimetabletoExcel(ttHourMean3,output_filename_2);

output_path_3='D:\BC_Figures\data\BC_3_DetectionLimit\BC_Detected\RMmissing\';
output_filename_3=strcat(output_path_3,char(titlestr),'.xlsx');
[~]=fromOriginTimetabletoExcel(ttVamos,output_filename_3);

%��ͼ����
outputstr=strcat('D:\BC_Figures\data\BC_3_DetectionLimit\BC_DTplot\',Filepath,'\');

figure(m)
h=plot(ttHourMean2.Date_Time,ttHourMean2.BC6_baseline,'-b',...
    'LineWidth',0.3,...
    'MarkerSize',0.1);
datetick('x',26,'keepticks'); 
set(h,'Color',[0,0.749,1]);
set(gcf,'unit','centimeters','position',[0.01 5 33.3 12]) ;
hold on
h2=plot(ttHourMean3.Date_Time,ttHourMean3.BC6_AFDT,...
    'LineWidth',0.3,...
    'MarkerSize',0.1);
datetick('x',26,'keepticks'); 
legend('BC baseline','BC Method5')
title(titlestr);
%�������
Name_string=strcat(outputstr,titlestr,'_Baseline_vs_AFDT');
Full_Name_string=strcat(char(Name_string),'.jpg');
print(m,'-djpeg','-r1000',Full_Name_string); 
saveas(m,strcat(char(Name_string),'.fig'));
end

end



