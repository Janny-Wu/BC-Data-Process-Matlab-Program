function[aaa]=MergeHeating()

%prename={'2015Winter','2016Spring','2016Summer','2016Fall','2016Winter',...
 %   '2017Spring','2017Summer','2017Fall','2017Winter','2018Spring','all_spring',...
 %   'all_fall','all_summer', 'all_winter'};

cd D:\BC_Figures\data\BC_4_merge\Temp_Heating\Fulltime
dir;
filepath=dir;
filename=size(dir);

%һһ�ҵ�ԭʼ���ݵ��ļ���
for i=3:filename(1)
%prestr=char(prename(1,i));
 folderstring=strcat('D:\BC_Figures\data\BC_4_merge\Temp_Heating\Fulltime\',filepath(i).name);
  cd(folderstring);
  dir;
  filepath_conc=dir;
  filenum_conc=size(dir,1);
  lineoftotal=0;%��ÿһ���ļ�֮ǰ���ܹ��Ѿ����˶�����
 goalexcel=strcat('D:\BC_Figures\data\BC_4_merge\Heating\Fulltime\',filepath(i).name,'.xlsx');
 for j=3:filenum_conc
     %��ȡ��Ӧ��excel:20yymm.xlsx
     readexcel=strcat(folderstring,'\',filepath_conc(j).name);
     [num txt raw]=xlsread(readexcel);
     %T1=readtable(readexcel);
     %�����ַ��ĵ�һ�У���Date&Time����Щд��ȥ����
  if j==3
       cellname1=['A1:Z1'];
       xlswrite(goalexcel,raw(1,:),cellname1);
       lineoftotal=lineoftotal+1;
  end
    %lineofthis=���excel��������-1
    lineofthis=length(raw)-1;
   % lineofthis=size(T1,1);%strlineofthis=num2str(lineofthis);
    %�趨λ�á����sheet���򣬰�����µ���������д����Ӧ��ĺϲ�excel��
    cellnames=['A',num2str(lineoftotal+1),':Z',num2str(lineoftotal+lineofthis)];
   % xlswrite(goalexcel,table2cell(T1),cellnames);
   xlswrite(goalexcel,raw(2:end,:),cellnames);
    lineoftotal=lineoftotal+lineofthis;
    clear cellnames  readexcel lineofthis
 end
 clear j  lineoftotal
end


aaa=1;
end