function[aaa]=MergeSeason()

%���Ժϲ������Ǻϲ���xls�ļ��У�2017,2018��֮ǰ��������100+�еĿ��С��ֶ�ɾ���ġ�
prename={'2015Winter','2016Spring','2016Summer','2016Fall','2016Winter',...
    '2017Spring','2017Summer','2017Fall','2017Winter','2018Spring','all_Spring',...
    'all_Fall','all_Summer', 'all_Winter'};

%һһ�ҵ�ԭʼ���ݵ��ļ���
for i=1:size(prename,2)
prestr=char(prename(1,i));
 folderstring=strcat('D:\BC_Figures\data\BC_4_merge\Temp_Season\',prestr);
  cd(folderstring);
  dir;
  filepath=dir;
  filenum=size(dir,1);
  lineoftotal=0;%��ÿһ���ļ�֮ǰ���ܹ��Ѿ����˶�����
 goalexcel=strcat('D:\BC_Figures\data\BC_4_merge\Season\',prestr,'.xlsx');
 for j=3:filenum
     %��ȡ��Ӧ��excel:20yymm.xlsx
     readexcel=strcat(folderstring,'\',filepath(j).name);
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
 clear j filenum filepath lineoftotal
end


aaa=1;
end