function[whether]=Processing_MergeAndSort()

%===========================Month,Year=====================================
for i=1:2
[struct_Detected]=restructForVamosMerge(i);
%��ÿ�����������ڵ���
[struct_Vamos]=MergeGetWeek(struct_Detected); %OK
%�Ѻ���Weekday�����ݿ�����Month��,��Fulltime��RMmissing
[aaa]=MergeTempWeek(struct_Vamos,i); %OK
[aaa]=MergeGetAll_Month(i);

%�źô�Merge��Temp_year,������ϵõ�Year���ݡ���Fulltime��RMmissing
[aaa]=MergeTempYear(struct_Vamos,i);
%�õ�Year_all����
[aaa]=MergeGetAll(i);
end

%===========================Temp_Month=====================================
%�Ѳ���weekday�����ݿ�����Temp_Month��
[aaa]=MergeCopyMonth();
    %Դ�ļ�Ŀǰ�ǣ�\BC_3_DetectionLimit\BC_Detected\RMmissing
    %Ŀ���ļ�Ŀǰ�ǣ�\BC_4_merge\Temp_Month\Fulltime�Լ�RMmissing

%========================Mkdir_TempSeason==================================
%[aaa]=MergeTempSeason(struct_Vamos); �ڷֵ�Temp_Season����һ����û�е���
[bbb]=mkdirMergeTempSeason(struct_Vamos);
    %�ⲽ����Struct����һ��YearseasonList�����ڴ˴����ļ��ж���
    %Ȼ���2018Winter�ֶ�ɾ����...
    %����MergeTempSeason���п�����һ�£������ܲ��ܵ�SeasonҲ�Զ�����ֻ��Ҫ�Լ�����Winter,Heating,Week)
%==========================================================================
whether=1;
end