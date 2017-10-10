//=============================kdb+Wind数据接口和交易接口=============================
// 功能：在kdb+中调用wind数据接口和交易接口，基于wind COM组件 WAPIWrapperCpp
// 依赖：q/wapi.q, q/w32/qwapi.dll,q/w32/WAPIWrapperCpp.dll, q/w32/msvcp140.dll, q/w32/vcruntime140.dll
//       如果提示缺失*.DLL，请下载安装VC++运行时组件（vc_redist.x86.exe）：http://www.microsoft.com/zh-CN/download/details.aspx?id=48145
// 说明：q脚本及DLL源代码参考了itfin和FlyingOE相关代码，特此感谢! zwz 
// 更新：2015.08.05:支持 tdq（快照）和tdqsub（订阅）;改进wsq行情回传机制;qwapi.dll采用vc++2015编译;loadlibs
//====================================================================================
/读取动态库,放在前面
.wind:@[{(`:qwapi 2:(`loadlibs;1))[]};`;{'`qwapi.dll_NOT_FOUND}]; 
/共用表、函数等
.wind.req:([]time:`time$();req:`$();reqid:`long$();windcode:`$();indi:`$();dt0:`$();dt1:`$();para:`$();callback:`$();status:`$()); /保存发出的请求 
.wind.nullreplace:{ty:min(type each x) where 0h<>type each  x;if[ty=0h;ty=-11h];:@[x;where ty<>type each  x;:;((-11h;-9h;-7h;-6h)!(`;0n;0Nj;0N))[ty]]};  /处理指标值为空和一个字段的指标值类型不同的情况:取type值最小作为该字段类型，其它全替换为该类型的空值
.wind.parsedata:{[eventdata]if[4>count eventdata;:eventdata];ndt:eventdata[0];nsym:eventdata[1];nfld:2+eventdata[2];typ:eventdata[3];if[98h<>typ;:eventdata];
    :{$[`wind_code in cols x;:update sym:wind_code,sym2:sym from x;:x];} update `datetime$dt from {x0:x[0];x0:@[x0;where x0=`;:;`n];:flip x0!.wind.nullreplace each flip 1_x} (`long$1+ndt*nsym;`long$nfld)#4_eventdata}; /对event data进行加工处理：代码统一处理等 
.wind.as_dict:{:`errid`errmsg`data!@[x;2;.wind.parsedata];};
num2time:{"T"$-6#"00000",string x};  /  num2time 90102f
int2date:{`date$x};  /  int2date 2
symlist2csv:{if[11h<>type x;:x];:`$"," sv string x;};   //  `open`high`low`close  =>  `$"open,high,low,close"
codelist2csv:{:symlist2csv x;};    //   codelist2csv `600000.SH`000001.SZ  => `$"600000.SH,000001.SZ"                codelist2csv `SH600000`SZ000001
dt2sym:{if[not (type x) in (-14h;-19h;-15h;-12h);:x];if[-19h=type x;:`$string x];x:19 sublist string x; :`$ssr[ssr[ssr[x;".";""];"T";" "];"D";" "];};   // date or time or datetime => symbol
dict2sym:{if[x~();:`];if[99h<>type x;:x];x:key[x]!{$[-1h=t:type x;$[x;`Y;`N];dt2sym x]}each value x; :`$";" sv (string key x),'"=",'(string value x)};    /  `a`b!(1;2) => `$"a=1;b=2"
/以下对API函数进行封装，对参数进行检查等，建议使用这些函数
/初始化、Wind认证.  
start:{[options;options2]if[(null options)or null options2;options:options2:`];if[not all (2#-11h)=type each (options;options2);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
   `.wind.req insert (.z.T;`start;0j;options;options2;`;`;`;`;`sent);:`errid`errmsg`data!.wind.start[(options;options2;5000j;0)];};
/登录Wind认证 windmdstop[]
stop:{[]`.wind.req insert (.z.T;`stop;0j;`;`;`;`;`;`;`sent);:`errid`errmsg`data!.wind.stop[];}; 
/是否连接
isconnected:{:`errid`errmsg`data!.wind.isconnected[];};
/日期序列函数，返回选定证券品种的历史数据,包括日间的行情数据，基本面数据以及技术指标数据。 
wsd:{[windcode;indi;begindt;enddt;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(5#-11h)=type each (windcode;indi;begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsd;0j;windcode;indi;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.wsd[(windcode;indi;begindt;enddt;para;0)];};   
/截面数据函数，返回选定品种的历史截面数据，支持获取某截面日期的多品种多指标。
wss:{[windcode;indi;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];para:dict2sym[para];if[not all(3#-11h)=type each (windcode;indi;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wss;0j;windcode;indi;`;`;para;`;`sent);:.wind.as_dict .wind.wss[(windcode;indi;para;0)];};   
/分钟序列函数，返回单品种的日内分钟K 线数据(含当日数据)
wsi:{[windcode;indi;begindt;enddt;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(5#-11h)=type each (windcode;indi;begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsi;0j;windcode;indi;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.wsi[(windcode;indi;begindt;enddt;para;0)];};   
/日内跳价函数，返回当日日内盘口买卖十档快照数据和成交数据。onwsq:{show x`data;};
wst:{[windcode;indi;begindt;enddt;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(5#-11h)=type each (windcode;indi;begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wst;0j;windcode;indi;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.wst[(windcode;indi;begindt;enddt;para;0)];;};   
/返回选定品种的实时数据，请求。
wsq:{[windcode;indi;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];para:dict2sym[para];if[not all(3#-11h)=type each (windcode;indi;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsq;0j;windcode;indi;`;`;para;`;`sent);:.wind.as_dict .wind.wsq[(windcode;indi;para;0)];};   
/返回选定品种的TD实时数据，请求。
tdq:{[windcode;indi;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];para:dict2sym[para];if[not all(3#-11h)=type each (windcode;indi;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsqtd;0j;windcode;indi;`;`;para;`;`sent);:.wind.as_dict .wind.tdq[(windcode;indi;para;0)];};   
/返回选定品种的实时数据，订阅方式。
.wind.onwsqsub:{onwsqsub[.wind.as_dict x];};   /dll调用本函数
onwsqsub:{WSQSUB::x;};
wsqsub:{[windcode;indi;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];para:dict2sym[para];if[not all(3#-11h)=type each (windcode;indi;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsqsub;0j;windcode;indi;`;`;para;`onwsqsub;`sent);:`errid`errmsg`data!.wind.wsqsub[(windcode;indi;para;0)];};  
/返回选定品种的TD实时数据，订阅方式。
tdqsub:{[windcode;indi;para]windcode:codelist2csv[windcode];indi:symlist2csv[indi];para:dict2sym[para];if[not all(3#-11h)=type each (windcode;indi;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wsqtdsub;0j;windcode;indi;`;`;para;`onwsqsub;`sent);:`errid`errmsg`data!.wind.tdqsub[(windcode;indi;para;0)];};  
/返回股票，基金，债券，商品等专题统计报表的数据。
wset:{[reportname;para]para:dict2sym[para];if[not all(2#-11h)=type each (reportname;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wset;0j;reportname;`;`;`;para;`;`sent);:.wind.as_dict .wind.wset[(reportname;para;0)];};   
/返回资产管理系统AMS 统计报表数据
wpf:{[portfolioname;viewname;para]para:dict2sym[para];if[not all(3#-11h)=type each (portfolioname;viewname;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wpf;0j;portfolioname;viewname;`;`;para;`;`sent);:.wind.as_dict .wind.wpf[(portfolioname;viewname;para;0)];};   
/上传组合持仓数据到组合管理系统PMS。
wupf:{[portfolioname;tradedate;windcode;quantity;costprice;para]windcode:codelist2csv[windcode];para:dict2sym[para];if[not all(6#-11h)=type each (portfolioname;tradedate;windcode;quantity;costprice;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`wupf;0j;windcode;`$((string portfolioname)," ",(string tradedate));quantity;costprice;para;`;`sent);:.wind.as_dict .wind.wupf[(portfolioname;tradedate;windcode;quantity;costprice;para;0)];};   
/完成证券筛选功能。需要在万得终端里预先定义筛选方案
weqs:{[filtername;para]para:dict2sym[para];if[not all(2#-11h)=type each (filtername;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`weqs;0j;filtername;`;`;`;para;`;`sent);:.wind.as_dict .wind.weqs[(filtername;para;0)];}; 
/返回日历日、工作日、交易日的日期序列。
tdays:{[begindt;enddt;para]begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(3#-11h)=type each (begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tdays;0j;`;`;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.tdays[(begindt;enddt;para;0)];};   
/给定一个日期和偏移量，求另一个日期。
tdaysoffset:{[begindt;offset;para]begindt:dt2sym[begindt];para:dict2sym[para];if[not all(-11h;-7h;-11h)=type each (begindt;offset;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tdaysoffset;0j;`;`;begindt;`;para;`;`sent);:`errid`errmsg`data!.wind.tdaysoffset[(begindt;offset;para;0)];};   
/计算日期天数
tdayscount:{[begindt;enddt;para]begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(3#-11h)=type each (begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tdayscount;0j;`;`;begindt;enddt;para;`;`sent);:`errid`errmsg`data!.wind.tdayscount[(begindt;enddt;para;0)];;};   
/通过id 取消某个请求或订阅。/windcancelrequest[0j]=windcancelallrequest[]取消所有请求或订阅。
wsqunsub:unsub:cancelsub:cancelrequest:{[rid]if[-7h<>type rid;:`errid`errmsg`data!(-1j;`arg_type_err;0j)];`.wind.req insert (.z.T;`cancelrequest;0j;`$string rid;`;`;`;`;`;`sent);.wind.cancelrequest[rid];:0j;};
cancelallsub:cancelallrequest:{[]:cancelrequest[0j];};
    
/回测函数
bktstart:{[strategyname;begindt;enddt;para]begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(4#-11h)=type each (strategyname;begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktstart;0j;strategyname;`;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.bktstart[(strategyname;begindt;enddt;para;0)];};
bktquery:{[qrycode;qrytime;para]para:dict2sym[para];if[not all(3#-11h)=type each (qrycode;qrytime;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktquery;0j;qrycode;`;qrytime;`;para;`;`sent);:.wind.as_dict .wind.bktquery[(qrycode;qrytime;para;0)];};
bktorder:{[tradetime;securitycode;tradeside;tradevol;para]securitycode:codelist2csv[securitycode];para:dict2sym[para];if[not all(5#-11h)=type each (tradetime;securitycode;tradeside;tradevol;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktorder;0j;securitycode;tradetime;tradeside;tradevol;para;`;`sent);:.wind.as_dict .wind.bktorder[(tradetime;securitycode;tradeside;tradevol;para;0)];};
bktstatus:{[para]para:dict2sym[para];if[not  -11h =type (para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktstatus;0j;`;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktstatus[(para;0)];};
bktend:{[para]para:dict2sym[para];if[not  -11h =type   (para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktend;0j;`;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktend[(para;0)];};
bktsummary:{[bktid;viewname;para]para:dict2sym[para];if[not all(3#-11h)=type each (bktid;viewname;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktsummary;0j;bktid;viewname;`;`;para;`;`sent);:.wind.as_dict .wind.bktsummary[(bktid;viewname;para;0)];};
bktdelete:{[bktid;para]para:dict2sym[para];if[not all(2#-11h)=type each (bktid;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktdelete;0j;bktid;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktdelete[(bktid;para;0)];};
bktstrategy:{[para]para:dict2sym[para];if[not  -11h =type   (para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktstrategy;0j;`;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktstrategy[(para;0)];};
bktfocus:{[strategyid;para]para:dict2sym[para];if[not all(2#-11h)=type each (strategyid;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktfocus;0j;strategyid;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktfocus[(strategyid;para;0)];};
bktshare:{[strategyid;para]para:dict2sym[para];if[not all(2#-11h)=type each (strategyid;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`bktshare;0j;strategyid;`;`;`;para;`;`sent);:.wind.as_dict .wind.bktshare[(strategyid;para;0)];};
/经济数据
edb:{[windcode;begindt;enddt;para]windcode:codelist2csv[windcode];begindt:dt2sym[begindt];enddt:dt2sym[enddt];para:dict2sym[para];if[not all(4#-11h)=type each (windcode;begindt;enddt;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`edb;0j;windcode;`;begindt;enddt;para;`;`sent);:.wind.as_dict .wind.edb[(windcode;begindt;enddt;para;0)];};   
/通过错误号取错误信息
werr:{[errid]:.wind.werr(errid;1j;`)};    /  werr  -40520001
/交易函数
tlogon:{[brokerid;departmentid;accountid;password;accounttype;para]para:dict2sym[para];if[not all(6#-11h)=type each (brokerid;departmentid;accountid;password;accounttype;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tlogon;0j;brokerid;departmentid;accountid;accounttype;para;`;`sent);:.wind.as_dict .wind.tlogon[(brokerid;departmentid;accountid;password;accounttype;para;0)];};  
tlogout:{[logonid]if[not -7h=type logonid;:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tlogout;0j;`$string logonid;`;`;`;`;`;`sent);:`errid`errmsg`data!.wind.tlogout[(logonid;0;`)];};  
torder:{[windcodes;tradeside;orderprice;ordervolume;para]windcodes:codelist2csv[windcodes];para:dict2sym[para];if[not all(5#-11h)=type each (windcodes;tradeside;orderprice;ordervolume;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`torder;0j;windcodes;tradeside;orderprice;ordervolume;para;`;`sent);:`errid`errmsg`data!.wind.torder[(windcodes;tradeside;orderprice;ordervolume;para;0)];};  
tcovered:{[windcodes;tradeside;ordervolume;para]windcodes:codelist2csv[windcodes];para:dict2sym[para];if[not all(4#-11h)=type each (windcodes;tradeside;ordervolume;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tcovered;0j;windcodes;tradeside;`;ordervolume;para;`;`sent);:`errid`errmsg`data!.wind.tcovered[(windcodes;tradeside;ordervolume;para;0)];}; 
tcancel:{[ordernumber]if[not -11h=type ordernumber;:`errid`errmsg`data!(-1j;`arg_type_err;`symbol_required)];
    `.wind.req insert (.z.T;`tcancel;0j;ordernumber;`;`;`;`;`;`sent);:`errid`errmsg`data!.wind.tcancel[(ordernumber;0)];};  
.wind.parsetrade:{[rdata]if[3>count rdata;:`errid`errmsg`data!rdata];if[0>type tdata:rdata[2];:`errid`errmsg`data!rdata];if[2>count tdata;:`errid`errmsg`data!rdata];nrec:tdata[0];nfld:tdata[1];typ:tdata[2];if[98h<>typ;:`errid`errmsg`data!rdata];
    :`errid`errmsg`data!(rdata[0];rdata[1];{$[`securitycode in cols x;:update sym:securitycode  from x;:x];}  {x0:x[0];x0:@[x0;where x0=`;:;`n];:flip x0!.wind.nullreplace each flip 1_x} (`long$1+nrec;`long$nfld)#3_tdata);}; /进行加工处理：代码统一处理等 
tquery:{[qrycode;para]para:dict2sym[para];if[not all(2#-11h)=type each(qrycode;para);:`errid`errmsg`data!(-1j;`arg_type_err;0j)];
    `.wind.req insert (.z.T;`tquery;0j;qrycode;`;`;`;`;para;`sent);:.wind.parsetrade .wind.tquery[(qrycode;para;0)];};
tord:torders:{:tquery[`order;`];};   /  meta tord[]`data
ttrd:ttrade:{:tquery[`trade;`];};   /  meta ttrd[]`data
tpos:tposition:{:tquery[`position;`];};  /   tpos[]`data
tpor:tcap:tcapital:{:tquery[`capital;`];};    /   tpor[]`data
tacc:taccount:{:tquery[`account;`];};    /   tacc[]`data
tbrk:tbroker:{:tquery[`broker;`];};   / tbroker[]`data
tdep:tdepartment:{[brokerid]:tquery[`department;`$"brokerid=",string brokerid]};  / tdep[`0000]`data

/  用法:                 保存请求:  .wind.req   
/  system"l wapi.q";start[`;`]      isconnected[]       stop[]           
/  wsd[`600036.SH;`$"open,high,low,close";`20141201;`20141209;`]`data       wsd[`600036.SH;`open`high`low`close;.z.D-10;.z.D;`]`data
/  wss[`$"600000.SH,600001.SH";`$"sec_name,open,close,total_shares";`$"tradeDate=20141208"]`data
/  wsi[`$"600000.SH";`$"open,close";`$"2014-12-08 09:00:00";`$"2014-12-08 15:00:00";`$"BarSize=5"]`data
/  wst[`$"600000.SH";`$"open,last,ask,bid";`$"2015-02-09 09:00:00";`$"2015-02-09 15:00:00";`]`data
/  update t:num2time each rt_time from wsq[`$"600000.SH,600036.SH";`$"rt_time,rt_last";`]`data               wsqsub[`600000.SH;`$"rt_time,rt_last";`]    WSQSUB`data
/  .wind.onwsqsub:{ONWSQSUB::x;onwsqsub[.wind.as_dict x];}; onwsqsub:{show x`data;}           wsqsub[`$"EURUSD.FX,USDCHF.FX";`$"rt_time,rt_last";`]            wsqsub[`EURAUD.FX;`$"rt_time,rt_last";`]     cancelrequest[0]
/  tdq[`600000.SH;`$"rt_time,rt_last";`] 
/  wset[`SectorConstituent;`$"date=20150209;sector=全部A股"]`data    wset[`IndexConstituent;`$"date=20150615;windcode=000300.SH"]`data       
/  wpf[`$"test";`$"PMS.HoldingDaily";`$"startdate=20141201;enddate=20150209;reportcurrency=CNY;owner="]`data       wpf[`$"test";`$"PMS.PortfolioDaily";`$"startdate=20150101;enddate=20150209;reportcurrency=CNY;owner="]`data
/  wupf[`test;`20150209;`600036.SH;`500;`14.42;`]`data
/  weqs[`$"test1";`]`data
/  update nn:`date$n from tdays[`20140101;`20141210;`]`data
/  tdaysoffset[`20140101;-5;`]`data
/  tdayscount[`20140101;`20141210;`]`data
/  bktstart[`test1;`20150101;`20150209;`]`data        bktquery[`Capital;`20150209;`]`data   bktquery[`Position;`20150209;`]`data  bktstatus[`]`data
/  bktorder[`20150203;`600000.SH;`Buy;`100;`$"Price=Close"]`data               bktorder[`20150209;`600000.SH;`Sell;`100;`$"Price=Close"]`data
/  bktend[`]   bktsummary[`5589;`KPI;`]`data  bktsummary[`5589;`NAV;`]`data  bktsummary[`5589;`Trade;`;`] bktdelete[`5589;`]`data       bktstrategy[`$"Type=1"]`data
/  tlogon[`0000;`0;`w;`000000;`SHSZ;`]          tlogout[1j]
/  torder[`600036.SH;`buy;`14.44;`100;`]         tcancel[1j]
/  tquery[`order;`]`data    tquery[`trade;`]`data   tquery[`position;`]`data  tquery[`capital;`]`data   tquery[`account;`]`data  tquery[`broker;`]`data   tquery[`department;`$"brokerid=0000"]`data
/  "\r\n"sv {raze(string x),"[",("," sv string(value `.[x])[1]),"]"}each (value "\\f") where (value "\\f") like "w*"
