function[ttSeparation]= SmoothingTimeseries(ttTemp)
%��һ��:1h����
span=61;
BC6_smooth=smoothdata(ttTemp.BC6_,span,'includenan');
ttTemp.BC6_smooth=BC6_smooth;
    BC1_smooth=smoothdata(ttTemp.BC1_,span,'includenan');
    ttTemp.BC1_smooth=BC1_smooth;
ttTemp.BC6_hour=min(ttTemp.BC6_,ttTemp.BC6_smooth);
    ttTemp.BC1_hour=min(ttTemp.BC1_,ttTemp.BC1_smooth);
%�ڶ�����30min����
span2=31;
BC6_smooth2=smoothdata(ttTemp.BC6_hour,span2,'includenan');
ttTemp.BC6_smooth2=BC6_smooth2;
    BC1_smooth2=smoothdata(ttTemp.BC1_hour,span2,'includenan');
    ttTemp.BC1_smooth2=BC1_smooth2;
ttTemp.BC6_30min=min(ttTemp.BC6_,ttTemp.BC6_smooth2);
    ttTemp.BC1_30min=min(ttTemp.BC1_,ttTemp.BC1_smooth2);
%��������15min����Ŷ
span3=15;
BC6_smooth3=smoothdata(ttTemp.BC6_30min,span3,'includenan');
ttTemp.BC6_smooth3=BC6_smooth3;
    BC1_smooth3=smoothdata(ttTemp.BC1_30min,span3,'includenan');
    ttTemp.BC1_smooth3=BC1_smooth3;
ttTemp.BC6_15min=min(ttTemp.BC6_,ttTemp.BC6_smooth3);
    ttTemp.BC1_15min=min(ttTemp.BC1_,ttTemp.BC1_smooth3);
    
%Traffic����
ttTemp.BC6_traffic=ttTemp.BC6_-ttTemp.BC6_15min;
    ttTemp.BC1_traffic=ttTemp.BC1_-ttTemp.BC1_15min;

%ɾ��ȱʧ����
TF=isnan(ttTemp.BC6_);
ttTemp1=rmmissing(ttTemp);

%Ȼ���ٴβ�ȫʱ���
dat_1=datevec(ttTemp1.Date_Time);
yy=dat_1(:,1);mm=dat_1(:,2);dd=dat_1(:,3);
Tmp_a=size(ttTemp1,1);
tv = [datetime(yy(1),mm(1),1,0,0,0):hours(1/60):datetime(yy(1),mm(1),dd(Tmp_a-1),23,59,00)]';
ttSeparation = retime(ttTemp1,tv);

end