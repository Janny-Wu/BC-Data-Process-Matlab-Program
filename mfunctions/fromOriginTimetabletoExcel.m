
function [whether]=fromOriginTimetabletoExcel(TimeTable,outputfilename)
sizeofTimetable=size(TimeTable,1);
tt1=datestr(TimeTable.Date_Time);
%�����:δ�޳��쳣ֵ������ʱ������_����
T1=timetable2table(TimeTable); NameT1=T1.Properties.VariableNames;

%csv�ļ�
writetable(T1, strcat(outputfilename,'.csv'));%, 'VariableNames', columns)
%csvwrite(outputfilename,N1);

%xlsx�ļ�
%����Ԫ������N1. T1�������ʱ����3�У���N1������2+4=6��
%N1=cell(sizeofTimetable+1,size(T1,2));
%��һ��
%N1(1,:)=T1.Properties.VariableNames(1,:);%VariableNames,see: help table
%��1��
%N1(2:end,1)=mat2cell(tt1,ones(size(tt1,1),1),size(tt1,2));
%��6��
%N1(2:end,2:end)=table2cell(T1(1:end,2:end));
%xlswrite(strcat(outputfilename,'.xlsx'),N1);


whether=1;
end

