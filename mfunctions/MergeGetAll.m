
function[aaa]=MergeGetAll(q)
 yearstring='all';
switch q
    case{1}
        folderstring=strcat('D:\BC_Figures\data\BC_4_merge\Year\Fulltime\');
         goalexcel=strcat('D:\BC_Figures\data\BC_4_merge\Year\Fulltime\',yearstring,'.xlsx');
    case{2}
        folderstring=strcat('D:\BC_Figures\data\BC_4_merge\Year\RMmissing\');
         goalexcel=strcat('D:\BC_Figures\data\BC_4_merge\Year\RMmissing\',yearstring,'.xlsx');
end

  cd(folderstring);
  dir;
  filepath=dir;
  filenum=size(dir,1);
  lineoftotal=0;%��ÿһ���ļ�֮ǰ���ܹ����ж�����
     
 for j=3:filenum
     %��ȡ��Ӧ��excel:20yymm.xlsx
     readexcel=strcat(folderstring,'\',filepath(j).name);
    [num txt raw]=xlsread(readexcel);
    %�����ַ��ĵ�һ�У���Date&Time����Щд��ȥ����
    if j==3
        cellname1=['A1:Z1'];
       xlswrite(goalexcel,raw(1,:),cellname1);
       lineoftotal=lineoftotal+1;
    end
    lineofthis=length(raw)-1;%strlineofthis=num2str(lineofthis);
    %�趨λ�á����sheet���򣬰�����µ���������д����Ӧ��ĺϲ�excel��
    cellnames=['A',num2str(lineoftotal+1),':Z',num2str(lineoftotal+lineofthis)];
    xlswrite(goalexcel,raw(2:end,:),cellnames);
    lineoftotal=lineoftotal+lineofthis;
    clear rawq num txt cellnames  readexcel lineofthis
 end
 
 aaa=1;
 end
