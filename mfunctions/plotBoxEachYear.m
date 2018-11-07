function[picwhether]=plotBoxEachYear(BC6,ttMonth,Datastr,Filepath,p)
mkdir('D:\BC_Figures\output\figure\Box\',Filepath);
outputstr=strcat('D:\BC_Figures\output\figure\Box\',Filepath,'\');
titlestr=Datastr;

figure(11)
if p==1
    ax=boxplot(BC6,ttMonth,...
    'Labels',{'Dec'});
title('2015 BC');
 xlabel('Month');
ylabel('BC Concentration (��g/m^{3})');
end
if p==2
ax=boxplot(BC6,ttMonth,...
    'Labels',{'Jan','Feb','Mar','Apr','May','Aug','Sept','Oct','Nov','Dec'});
title('2016 BC');
 xlabel('Month');
ylabel('BC Concentration (��g/m^{3})');
else if (p==3)
ax=boxplot(BC6,ttMonth,...
    'Labels',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'});
   title('2017 BC');
    xlabel('Month');
   ylabel('BC Concentration (��g/m^{3})');
    else if p==4
ax=boxplot(BC6,ttMonth,...
    'Labels',{'Jan','Feb','Mar','Apr'});
    title('2018 BC');
     xlabel('Month');
    ylabel('BC Concentration (��g/m^{3})');
    else if (p==5)
ax=boxplot(BC6,ttMonth,...
    'Labels',{'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sept','Oct','Nov','Dec'});
   title('2015-2018 BC');
   xlabel('Month');
   ylabel('BC Concentration (��g/m^{3})');
        end;end;end;end
PRystring1=strcat(outputstr,titlestr,'_Box_plot.jpg');
saveas(11,strcat(PRystring1,'.fig'));
print(11,'-djpeg','-r1000',PRystring1);

picwhether=1;
end
