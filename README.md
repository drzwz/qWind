# WindKdb+���ݼ����׽ӿ� kdb+/q interface for Wind API (WAPI, COM Version)

([www.dajiangzhang.com](http://www.dajiangzhang.com/q?fc42e518-3ced-4b97-833e-5f6673a7127b) )

**WindKdb+�ӿ�**��ʵ����kdb+/q��ֱ�ӵ���Wind�����ӿڡ����л�������1��Wind�����ӿڸ��˰������棻��2��32λkdb+ for Windows, 3.0���ϰ汾����3��32λ��64λWindows 7/8/10��Windows Server 2008/2012��

**WindKdb+ V1.1**������Wind C++V1.1�°�ӿڣ�COM�汾������V1.0�Ĳ�֮ͬ����һ����ȡ���ݺ���Ϊͬ��������Ӧ�ý�Ϊ�򵥣����ǽ��׺������򻯡���������еġ�Wind Kdb+���ݼ����׽ӿ�V1.1���°棩˵������WindKdb+ V1.0�ɰ�(<http://www.dajiangzhang.com/q?f418132f-351a-480d-9511-155b709238ea>)�ɼ���ʹ�ã������Ƽ������°�WindKdb+�ӿڣ�V1.1����

**��������**���Ҳ���wind�ӿ��ļ����������WIND �ӿ�DLL���ڵ�·������ D:\Wind\WAPI.PE\bin���ӵ� PATH���������

**Wind�����ӿ�** ���й����������쵼��Wind��Ѷ�Ƴ���ǿ������ݽӿںͽ��׽ӿڣ��ٷ�֧��Excel��VBA��Matlab��R��Python��C#��C/C++�����ԣ�֧�ָ�����Ѱ桢�����շѰ�ͻ����棬���<http://www.dajiangzhang.com>��

**kdb+/q**������kx��˾������һ��һ�廯����Ӧ��ƽ̨���߱�CEP���ڴ����ݿ⡢���ݲֿ⡢ʱ�����з������������㡢����ʽ����ʽ���Եȹ��ܣ�kdb+32λ�汾�������ʹ��,Kdb+3.3 2015.08.23�����һ����������ð汾���й�kdb+���<http://www.kx.com>��<http://itfin.f3322.org/opt/cgi/wiki.pl/KdbPlus>��

*��л��麣��itfin��Freddie Wu/FlyingOE��!*

 
**�Ƽ�FlyingOE������kdb+/q interface for Wind APIs (non-COM version)<https://github.com/FlyingOE/q_Wind>**



# WindKdb+���ݼ����׽ӿ�ʹ��˵�� 

Ŀ¼

 һ���������
 
 ������װ��ʹ�� 
 
 1���������� 
 
 ��1����װWind�����ӿڲ��޸� 
 
 ��2����װWindKdb+�ӿ� 
 
 ��3�����ԣ���ʷ������ȡ 
 
 ��4�����ԣ�ʵʱ������� 
 
 ��5�����ԣ����׽ӿ� 
 
 2���ӿڹ淶 
 
 �����ӿں��� 
 
 1���ӿڵ�¼��start�� 
 
 2���ӿ��˳���stop�� 
 
 3���������У�wsd�� 
 
 4���������ݣ�wss�� 
 
 5���������У�wsi�� 
 
 6���������ۣ�wst�� 
 
 6��ʵʱ���ݿ��գ�wsq�� 
 
 7��ʵʱ���ݶ��ģ�wsqsub�� 
 
 8��ʵʱ�����˶���cancelsub�� 
 
 9�����ݼ���wset�� 
 
 10���ʹܺ�����wpf�� 
 
 11������ϴ�����(wupf) 
 
 12��֤ȯɸѡ(weqs) 
 
 13���ض������պ�����tdays�� 
 
 14������ƫ�ƺ�����tdaysoffset�� 
 
 15��������ͳ�ƣ�tdayscount�� 
 
 16��������Ϣ��werr�� 
 
 17���ز⺯����bkt...�� 
 
 18����¼�����˻���tlogon�� 
 
 19���˳������ʻ���¼��tlogout�� 
 
 20���µ���torder�� 
 
 21��������tcancel�� 
 
 22����ѯ�ʽ𡢳ֲ֡�ί�еȣ�tquery�� 
 
 �ġ����� 
 
 1����Ҫ�ļ� 
 
 2��������͸��˰� 
 
 3���Ƿ�֧��Windows XP��Windows Server 2003�� 
 
 4������ 
 
 5��kdb+��ӵ���Wind�ӿ� 
 

## һ���������

**2015.12.03**����1�������ڴ�й¶���⣻��2��wsqsub΢�����ظ������鲻�����͡�ע�ⷵ�صı���ֶθ������ܲ�ͬ��

**2015.08.16**����1��֧�� tdq�����գ���tdqsub�����ģ��� **��Ҫ��ͨȨ��** ;��2���Ľ�����ش����ƣ���3��qwapi.dll����vc++2015���롣

**2015.03.16**����1������BUG����2���Ľ�ʵʱ����ش����ƣ���3���������͸�������֤ȯ�����֧��symbol��Ԫ��\`$&quot;600000.SH,600001.SH&quot;��֧��symbol������\`600000.SH\`600001.SH�����ڼ�֧��symbol��\`20150316��֧��date��2015.03.16��ѡ���֧��symbol��\`$&quot;startdate=20141201;enddate=20141210;reportcurrency=CNY;owner=&quot;��֧��dict��\`startdate\`enddate\`reportcurrency\`owner!(2014.12.01;2014.12.10;\`CNY;\`)��

**2015.02.13**������Wind C++�°�ӿ�V1.1��


## ������װ��ʹ��

### 1����������

#### **��1����װWind�����ӿڲ��޸�**

�Ӵ�����վ<http://www.dajiangzhang.com>���ء���װ���°�ӿڵ��������COM���������״�ʹ��ǰ��Ҫע��COM���������һ������InstallShell.exe��ѡ��װC++�������������ֱ������\wapi.pe\bin\initWAPI.exe�����������û���ͨ���ն����&quot;����&quot;�˵�&quot;�޸�C++&quot;�����޸���ִ��\wind\bin\initWAPI.exe��


#### **��2����װWindKdb+�ӿ�**

��windkdb.zip��ѹ����һĿ¼�����¼���Ϊd:\windkdb���� [www.kx.com](http://www.kx.com)����q for Windows��Ѱ棬��q.exe����d:\windkdb\q\w32����q.k����d:\windkdb\q\��

ע��������ʱ��ʾȱʧDLL�ļ������������������VC++����ʱ�����vc\_redist.x86.exe����

[http://www.microsoft.com/zh-CN/download/details.aspx?id=48145](http://www.microsoft.com/zh-CN/download/details.aspx?id=48145)

#### **��3�����ԣ���ʷ������ȡ**

����d:\windkdb\windkdb.bat����һ���Ѽ�����windkdb�ӿڽű���wapi.q����kdb+����q)������start[\`;\`]�����ӿڣ��ڵ�����Wind��¼��������Wind�˺ź�������¼��

ִ��������䣺

q)r:wsd[\`000001.SZ;\`open\`high\`low\`close; 2015.02.03;2015.02.07;\`]  //����ƽ������2015.2.3-2.7�Ŀ��ߵ������ݲ������������r�����С�

����������ȡ������&quot;�����ӿں���&quot;��

#### **��4�����ԣ�ʵʱ�������**

����d:\windkdb\windwsqsub.bat��

windwsqsub.bat ������wsqsub\_sample.q�����������£�

\l wapi.q

onwsqsub:{X::x;show x\`data;};    /��дonwsqsub�����������������ݲ���ʾ����

start[\`;\`];       /����

wsqsub[\`EURUSD.FX;\`$&quot;rt\_time,rt\_latest&quot;;\`];    /����EURUSD������ʱ�䡢���³ɽ���

#### **��5�����ԣ����׽ӿ�**

����d:\windkdb\windkdb.bat�������������ݣ�

q) start[\`;\`]     //��¼wind�ӿ�

q) tquery[\`broker;\`][\`data]   //��ȡȯ��/�������б�

q) tlogon[\`00000010;\`0;\`$&quot;M:13xxxxxxxxx01&quot;;\`yyyyyy;\` shsza;\`]  // 13xxxxxxxxxΪ��ע��ģ�⽻�׵��ֻ��ţ�yyyyyyΪ���룬�������&quot;��������&quot;&quot;ģ�⽻��&quot;��

q) tquery[\`account;\`][\`data]  //��ѯ�˻�

q) tquery[\`order;\`][\`data]  //��ѯί��

q) tquery[\`trade;\`][\`data]  //��ѯ�ɽ�

q) tquery[\`position;\`][\`data]  //��ѯ�ֲ�

q) tquery[\`capital;\`][\`data] //��ѯ�ʽ�

q) ����������

q) tlogout[1j]  //�˳��˻���¼,����logonid=1j

q) stop[]   //�˳��ӿ�

### 2���ӿڹ淶

- windcode������Wind֤ȯ���룬 symbol�ͣ��� \`600000.SH���������룩��\`$&quot;600000.SH,600001.SH,000001.SZ&quot;��\`600000.SH\`600001.SH\`000001.SZ��������룩

- indi�������ֶΡ�ָ�꣬symbol�ͣ������������ַ������ĵȣ���������ʾ��\`$&quot;��..&quot;����\`$&quot;open,high,low,close&quot;��\`open\`high\`low\`close��

- begindt��enddt��������ֹ���ڣ�symbol�ͻ�date�ͣ���\`20150101��2015.01.01��

- para������ѡ�symbol�ͻ�dict�ͣ���\`tradedate=20150101��(1#\`tradedate)!(1#2015.01.01)��

- ���ص������У�����dt�ֶ�Ϊdatetime�����⣬����������ָ�귵��float����ֵ������\`datetime$...����ת��Ϊdatetime�����磬���ص����ݱ�MYDATA����ipo_date��last_trade_day�������ֶΣ���update \`datetime$ipo\_date,\`datetime$last\_trade\_day from MYDATA��ʱ����ָ�귵��float����ֵ������num2time����ת������num2time[93001f]��update newtime:num2time each rt\_time from MYDATA��

- �����ķ���ֵͨ��Ϊһ��dict��dict[\`errid]Ϊ0��ʾ�ɹ�������ʧ�ܣ�dict[\`errmsg]Ϊ��ʾ��Ϣ��dict[\`data]Ϊ���ص����ݣ�ͨ��Ϊһtable��

- **��WindNavigator.exe������ز������������������ݵȵ���ϸ�����ο�Wind C++�ӿڻ��������ӿڵ�ʹ���ֲᡣ**

## �����ӿں���

### 1���ӿڵ�¼��start��

������start[options;options2]

���ܣ���ʼ����Wind��֤��ʹ�����ݽӿ�ǰӦ��ִ�б�����

���ӣ�start[\`;\`]   / ��ʾ��½�Ի���

### 2���ӿ��˳���stop��

������stop[]

### 3���������У�wsd��

������wsd[windcode,indi,begindt,enddt,para]

���ܣ�����ѡ��֤ȯƷ�ֵ���ʷ����,�����ռ���������ݣ������������Լ�����ָ��

���ӣ�wsd[\`600036.SH;\`$&quot;open,high,low,close&quot;; \`20141201;\`20141209;\`]

wsd[\`600036.SH;\`open\`high\`low\`close; 2014.12.01;2014.12.09;()]

wsd[\`600036.SH;\`open\`high\`low\`close; \`20141201;\`20141209; ()]

### 4���������ݣ�wss��

������wss[windcode,indi,para]

���ܣ�����ѡ��Ʒ�ֵ���ʷ��������

���ӣ�wss[\`$&quot;600000.SH,600001.SH&quot;;\`$&quot;sec\_name,open,close,total\_shares&quot;; \`$&quot;tradeDate=20141208&quot;]

wss[\`600000.SH\`600001.SH;\`sec_name\`open\`close\`total\_shares; (1#\`tradeDate)!1#.z.D]

### 5���������У�wsi��

������wsi[windcode,indi,begindt,enddt,para]

���ܣ��������ڷ���K ������,��������

���ӣ�wsi[\`$&quot;600000.SH&quot;;\`$&quot;open,close&quot;;\`$&quot;2014-12-08 09:00:00&quot;; \`$&quot;2014-12-08 15:00:00&quot;;\`$&quot;BarSize=5&quot;]

wsi[\`600000.SH;\`open\`close;2014.12.08T09:00:00; 2014.12.08T15:00:00;(1#\`BarSize)!1#5]

### 6���������ۣ�wst��

������wst[windcode,indi,begindt,enddt,para]

���ܣ����������̿�����ʮ���������ݺͳɽ�����

���ӣ�wst[\`$&quot;600000.SH&quot;;\`$&quot;open,last,ask,bid&quot;;\`$&quot;2014-12-10 09:00:00&quot;;\`$&quot;2014-12-10 15:00:00&quot;;\`]

wst[\`600000.SH;\`open\`last\`ask\`bid;.z.D;.z.Z;\`]

### 6��ʵʱ���ݿ��գ�wsq/tdq��

������wsq[windcode,indi,para]

���ܣ�����ѡ��Ʒ�ֵ�ʵʱ���ݿ���

���ӣ�wsq[\`600000.SH;\`$&quot;rt\_last,rt\_open,rt\_high,rt\_low&quot;;\`]

wsq[\`600000.SH;\`rt\_last\`rt_open\`rt\_high\`rt_low;\`]

tdq�÷���wsq��ͬ������Ҫ��ͨ���Ȩ��!

### 7��ʵʱ���ݶ��ģ�wsqsub/tdqsub��

������wsqsub[windcode,indi,para]

���ܣ�����ѡ��Ʒ�ֵ�ʵʱ���ݣ�ʵʱ����ͨ��onwsqsub�������أ����Ը�д�ú�����

���ӣ�onwsqsub:{MYDATA::x;show x\`data;};

wsqsub[\`600000.SH;\`$&quot;rt\_time,rt\_last&quot;;\`]

wsqsub[\`600000.SH;\`rt\_time\`rt_last;\`]

tdqsub�÷���wsqsub��ͬ������Ҫ��ͨ���Ȩ��!

### 8��ʵʱ�����˶���cancelsub��

������cancelsub[rid]

���ܣ��˶�ָ������ID ��ʵʱ���ݣ�����Ϊ0j���˶����ж��ģ����� cancelsub[0j]��ͬ��cancelallsub[]

���ӣ�cancelrequest[1j]

### 9�����ݼ���wset��

������wset[reportname,para]

���ܣ����ع�Ʊ������ծȯ����Ʒ��ר��ͳ�Ʊ��������

���ӣ�wset[\`SectorConstituent;\`$&quot;date=20141209;sector=ȫ��A��&quot;]

wset[\`SectorConstituent;\`date\`sector!(.z.D;\`$&quot;ȫ��A��&quot;)]

### 10���ʹܺ�����wpf��

������wpf[portfolioname,viewname,para]

���ܣ������ʲ�����ϵͳAMS��PMSͳ�Ʊ��������

���ӣ�wpf[\`$&quot;test&quot;;\`$&quot;PMS.PortfolioDaily&quot;; \`$&quot;startdate=20141201;enddate=20141210;reportcurrency=CNY;owner=&quot;]

wupf[\`test;\`20150209;\`600036.SH;\`500;\`14.42;\`]\`data

### 11������ϴ�����(wupf)

������wupf[portfolioname,tradedate,windcode,quantity,costprice,para]

���ܣ��ϴ���ϳֲ����ݵ�PMS ��Ϲ���ϵͳ

���ӣ�wupf[\`test;\`20141210;\`600036.SH;\`100;\`14.12;\`]

### 12��֤ȯɸѡ(weqs)

������weqs[filtername,para]

���ܣ������ն�֤ȯɸѡ��֤ȯ��

���ӣ�weqs[\`$&quot;ţ��&quot;;\`]

### 13���ض������պ�����tdays��

������tdays[begindt,enddt,para]

���ܣ�ָ���ض������������գ���begindt��enddt������(��������)���б�

���ӣ�tdays[\`20140101;\`20141210;\`]

### 14������ƫ�ƺ�����tdaysoffset��

������tdaysoffset[begindt,offset,para]

���ܣ���begindt�� OffSet(ƫ�ƣ�&gt;0���ƣ�&lt;0ǰ��)��Period�����ڣ�������

���ӣ�tdaysoffset[\`20140101; -5j;\`]

### 15��������ͳ�ƣ�tdayscount��

������tdayscount[begindt,enddt,para]

���ܣ���begindt��enddt������(��������)����

���ӣ�tdayscount[\`20140101;\`20141210;\`]

### 16��������Ϣ��werr��

������werr[errid]

���ܣ����ݴ���ID��ȡ������Ϣ

���ӣ�werr[-40520001]

### 17���ز⺯����bkt...��

���»ز⺯���Ĳ�����Ϊsymbol���ͣ��������塢����ֵ���÷��ȼ����ز�ƽ̨ʹ���ֲᡷ��

bktstart[strategyname;begindt;enddt;para]

bktquery[qrycode;qrytime;para]

bktorder[tradetime;securitycode;tradeside;tradevol;para]

bktstatus[para]

bktend[para]

bktsummary[bktid;viewname;para]

bktdelete[bktid;para]

bktstrategy[para]

### 18����¼�����˻���tlogon��

������tlogon[brokerid,departmentid,logonaccount,password,accounttype]

���ܣ���¼�ʽ��˺Ż���ģ���˺š���½�ɹ�ʱϵͳ�Զ�����һ����¼��logonid��

brokerid�������̴��룬ͨ��tquery[\`broker;\`]��ȡ��\`0000 ΪWTTS ģ���̨

departmentid��Ӫҵ�����룬\`0 ��ʾ������д

logonaccount���ʽ��˺ţ�WFT �û�ģ���˺Ź�ƱΪWind�˺�+01���ڻ�ΪWind�˺�+02��

password���ʽ�����

accounttype���г��б�ȡֵ���£�

�˻����ͣ��京�����¡�

\`SH��\`SZ��\`SHSZ �����Ϻ�A

\`SZB ����B

\`SHB �Ϻ�B

\`CZC ֣����Ʒ

\`SHF �Ϻ���Ʒ

\`DCE ������Ʒ

\`CFE ��ָ��Ʒ

���ӣ�tlogon[\`0000;\`0;\`W888888801;\`W888888801;\`shsz]

### 19���˳������ʻ���¼��tlogout��

������logout[logonid]

���ܣ��˳���¼��

���ӣ�logout[1j]

### 20���µ���torder��

������torder[windcodes;tradeside;orderprice;ordervolume;para]

���ܣ�ί���µ�

windcodes��֤ȯ���룬��\`600000.SH��\`000001.SZ

tradeside�����׷���

\`Buy ���뿪��(��ͬ=֤ȯ����)

\`Short ��������

\`Cover ����ƽ��

\`Sell ����ƽ��(��ͬ=֤ȯ����)

\`CoverToday ����ƽ���

\`SellToday ����ƽ���

orderprice��ί�м۸�

ordervolume:��������

para��

OderTypeί�з�ʽ��Ĭ��Ϊ�޼۽��ס�

LMT �޼�ί��

BOC �Է����ż۸�ί��

BOP �������ż۸�ί��

ITC ��ʱ�ɽ�ʣ�೷��

B5TC �����嵵ʣ�೷��

FOK ȫ��ɽ�����ί��

B5TL �����嵵ʣ��ת�޼�

Ŀǰ�����֧�����г����һ�֣��Ͻ���ֻ֧��LMT��

B5TC �� B5TL ����

HedgeType�Ƿ�ΪͶ���ױ���SPEC ΪͶ�������ѡ���ױ���Ҫר

�ŵ��ױ��˺š�

LogonID��¼�ţ����˺ű���ָ����

���ӣ�torder[\`600036.SH;\`buy;\`14.44;\`100;\`]

### 21��������tcancel��

������tcancel[ordernumber]

���ܣ�ȡ��ί�У�ordernumberί�б�ţ�Ϊsymbol���͡�

���ӣ�tcancel[\`1]

### 22����ѯ�ʽ𡢳ֲ֡�ί�еȣ�tquery��

������tquery[qrycode,para]

���ܣ������ʽ𡢳ֲ֡�ί�еȲ�ѯ

����ί�в�ѯ��tquery[\`order;\`]

���ճɽ���ѯ��tquery[\`trade;\`]

�ֲֲ�ѯ��tquery[\`position;\`]

�ʽ��ѯ��tquery[\`capital;\`]

�ɶ��˺Ż�֤���˺Ų�ѯ��tquery[\`account;\`]

�����̱�Ų�ѯ��tquery[\`broker;\`]

## �ġ�����

### 1����Ҫ�ļ�

d:\windkdb\windkdb.bat������һ��kdb+ʵ����������wapi.q��

d:\windkdb\windwsqsub.bat������ʵʱ����������ӣ�

d:\windkdb\q\wapi.q��windkdb�ӿڽű���

d:\windkdb\q\wsqsub\_sample.q��ʵʱ����������ӽű���

d:\windkdb\q\qusers���û������ļ�����&quot;:&quot;�ָ����û������룩

d:\windkdb\q\w32\q.exe��q 3.x��Ѱ棬���kx��վ���أ�

d:\windkdb\q\w32\qwapi.dll���ӿ�DLL��

d:\windkdb\q\w32\WAPIWrapperCpp.dll��wind�ӿڷ�װdll��

d:\windkdb\q\w32\msvcp120.dll��VC����ʱ��

d:\windkdb\q\w32\vcruntime140.dll��VC����ʱ��

d:\windkdb\q\w64\qwapi.dll��64λ�ӿ�DLL����Ҫ64λq��

d:\windkdb\q\w64\WAPIWrapperCpp.dll��64λwind�ӿڷ�װdll����Ҫ64λq��

### 2��������͸��˰�

ͬʱ��װ�л�����͸��˰�ӿ�ʱ������PATH����������ָ��wind�ӿ��ļ�����·��������windkdb+�ӿ�ʹ���ĸ��汾��

### 3������

������GBK���롣�ű��ļ�����ΪANSI/GBK���롣�������studio for kdb+ִ�нӿں���������C:\Users\[username]\.studioforkdb\studio.properties�����һ�У�encoding=GBK��

### 4��kdb+��ӵ���Wind�ӿ�

��ӵ��ã�kdb+�ȵ���R��Matlab��Python�����kx��վ����R��Matlab��Python�ٵ���Wind�ӿڣ����������վ����

