function[whether]=Processing_MergeAndSort_5Meteo()

%===========================Month,Year=====================================
%for i=1:2
[struct_Detected]=restructForVamosMerge_5Meteo();
%��ÿ�����������ڵ���
[struct_Vamos]=MergeGetWeek_5Meteo(struct_Detected); %OK
%�Ѻ���Weekday�����ݿ�����Month��,��Fulltime��RMmissing
[aaa]=MergeTempWeek_5Meteo(struct_Vamos); %OK
[aaa]=MergeGetAll_Month_5Meteo();

%��ͼ֮ǰ����Ҫ����һ�£�ʹ��\Month�����Ŀ¼�¾��Ǹ���excel�������źû�ͼ��

%�źô�Merge��Temp_year,������ϵõ�Year���ݡ���Fulltime��RMmissing
[aaa]=MergeTempYear_5Meteo(struct_Vamos);
%�õ�Year_all����
[aaa]=MergeGetAll_5Meteo();
%end

%===========================Temp_Month=====================================
%�Ѳ���weekday�����ݿ�����Temp_Month����������ﲻ��Ҫ��ֱ���ֶ�������hh

%[aaa]=MergeCopyMonth();
    %���߲����ֶ�����Դ�ļ��ĳɣ�\D:\BC_Figures\data\BC_5_Meteo\Synchronized\Month
    %Ŀ���ļ��ĳɣ�D:\BC_Figures\data\BC_5_Meteo\Synchronized\Temp_Month

%========================Mkdir_TempSeason==================================
%[aaa]=MergeTempSeason(struct_Vamos); �ڷֵ�Temp_Season����һ����û�е���
[bbb]=mkdirMergeTempSeason_5Meteo(struct_Vamos);
    %�ⲽ����Struct����һ��YearseasonList�����ڴ˴����ļ��ж���
    %Ȼ���2018Winter�ֶ�ɾ����...
    %����MergeTempSeason���п�����һ�£������ܲ��ܵ�SeasonҲ�Զ�����ֻ��Ҫ�Լ�����Winter,Heating,Week)

%==================�ź�Temp�Ժ󣬵õ�Season================================
[aaa]=MergeSeason_5Meteo();

%iii)�ֶ��ֳ�Winter������(fulltime)

%iv)�ֶ��ֳ�Temp_Heating,Ȼ���������µ�Merge,�õ�[Heating]:��fulltime)
[aaa]=MergeHeating_5Meteo();

%ͨ������Year,Month,Season,Winter,Heating,�������ڴ����õ�[Week]
[aaa]=MergeWeek_5Meteo();

whether=1;
end