function[struct_Daily]=Processing_DailyMerge(struct_Detected)
mon_num=length(struct_Detected);
Filepath='Month';
%mkdir('D:\BC_Figures\data\BC_3_DetectionLimit\BC_DTplot\',Filepath);
%outputstr=strcat('D:\BC_Figures\data\BC_3_DetectionLimit\BC_DTplot\',Filepath,'\');

%���������ݵĺϲ��ļ�csv,�ֳ�ÿ��һ���ļ�
Meteo_Month_path='D:\BC_Figures\data\Meteorology_data\Meteo_Month';

%�������������ļ�
cd (Meteo_Month_path);
dir;
filepath=dir;
filenum=size(dir,1);

ttFirst=table2timetable(readtable(filepath(3).name));
TFirst=ttFirst.Date_Time(1);
ttLast=table2timetable(readtable(filepath(filenum(1)).name));
TLast=ttLast.Date_Time(end);

tvv=[TFirst:day(1):TLast];
%tv=[datetime(2015,12,1):day(1):datetime(2018,4,5)];


for m=1:mon_num
%����hour������BC����,����Ϊdaily����
ttBCtable=struct_Detected(m).Timetable;
ttBC=retime(ttBCtable,'daily',@nanmean);
%����daily�������¶�Meteo����
ttMeteotable=table2timetable(readtable(filepath(m+2).name));
%ttMeteotablea=timetable(ttMeteotable,'RowTimes',ttMeteotable.Data_Time);

ttMerge=synchronize(ttBC,ttMeteotable);
if m==1
    ttAll=synchronize(ttMerge,tvv);
else
    ttAll=synchronize(ttMerge,ttAll,tvv);
end

%��ÿ�µ����ϰ�Timetable:ttMerge����Ϊ�ṹ��
struct_Daily(m)=struct('Timetable',ttMerge);

%���Ϊexcel�ĵ�
[dat_Vamos,yy,mm,yystr,mmstr,titlestr]=createDat(ttMerge);

%BC   
output_path_1='D:\BC_Figures\data\BC_5_Meteo\BC_Daily\';
output_filename_1=strcat(output_path_1,char(titlestr),'.xlsx');
[~]=fromOriginTimetabletoExcel(ttBC,output_filename_1);
%Meteo
output_path_2='D:\BC_Figures\data\BC_5_Meteo\Meteo_Daily\';
output_filename_2=strcat(output_path_2,char(titlestr),'.xlsx');
[~]=fromOriginTimetabletoExcel(ttMeteotable,output_filename_2);
%Month:ttMerge
output_path_3='D:\BC_Figures\data\BC_5_Meteo\Synchronized\Month\';
output_filename_3=strcat(output_path_3,char(titlestr),'.xlsx');
[~]=fromOriginTimetabletoExcel(ttMerge,output_filename_3);
%All:ttAll
output_path_4='D:\BC_Figures\data\BC_5_Meteo\Synchronized\All\';
output_filename_4=strcat(output_path_4,'All_BC_Meteo','.xlsx');
[~]=fromOriginTimetabletoExcel(ttAll,output_filename_4);

end

end






