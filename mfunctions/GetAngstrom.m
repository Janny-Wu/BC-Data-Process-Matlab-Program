function[aaa]=GetAngstrom()
str1={'Year','Month','Season','Winter','Heating','Week\All'};
%computeAngstrom(str,q),���q��������ʵ����st2��YearĿ¼��û����Fulltime�ˣ���str1��
%��������һ�¶�ȡ·����aastr->read_data_name)Ҫ��ôд
str1={'Week\All'};
[c1]=computeAngstrom(str1,1);
str1={'Week\Plus'};
[c1]=computeAngstrom(str1,1);
%str2={'Week\Fulltime\Year','Week\Fulltime\Month',...
%    'Week\Fulltime\Season','Week\Fulltime\Winter','Week\Fulltime\Heating'};
%[c2]=computeAngstrom(str2,2);

aaa=1;
end