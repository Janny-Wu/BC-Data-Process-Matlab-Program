
function [a,b]=fromMatrixtoTimeExcel(Matrix,tt,cellname,outputfilename)
tt1=datestr(tt);
[a,b]=size(Matrix);
N=cell(a+1,b+1);
%��һ��:��ͷ����
N(1,1)={'Date&Time'};
N(1,2:end)=cellname;
%��1�У�ʱ������
N(2:end,1)=mat2cell(tt1,ones(size(tt1,1),1),size(tt1,2));
N(2:end,2:end)=num2cell(Matrix);
xlswrite(outputfilename,N);
end