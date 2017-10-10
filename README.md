# WindKdb+数据及交易接口 kdb+/q interface for Wind API (WAPI, COM Version)

([www.dajiangzhang.com](http://www.dajiangzhang.com/q?fc42e518-3ced-4b97-833e-5f6673a7127b) )

**WindKdb+接口**：实现在kdb+/q中直接调用Wind量化接口。运行环境：（1）Wind量化接口个人版或机构版；（2）32位kdb+ for Windows, 3.0以上版本；（3）32位或64位Windows 7/8/10或Windows Server 2008/2012。

**WindKdb+ V1.1**：基于Wind C++V1.1新版接口（COM版本），与V1.0的不同之处，一是提取数据函数为同步函数，应用较为简单；二是交易函数大大简化。详见附件中的《Wind Kdb+数据及交易接口V1.1（新版）说明》。WindKdb+ V1.0旧版(<http://www.dajiangzhang.com/q?f418132f-351a-480d-9511-155b709238ea>)可继续使用，不过推荐改用新版WindKdb+接口（V1.1）。

**常见问题**：找不到wind接口文件。解决：把WIND 接口DLL所在的路径（如 D:\Wind\WAPI.PE\bin）加到 PATH环境变量里。

**Wind量化接口** ：中国金融数据领导者Wind资讯推出的强大的数据接口和交易接口，官方支持Excel、VBA、Matlab、R、Python、C#、C/C++等语言，支持个人免费版、个人收费版和机构版，详见<http://www.dajiangzhang.com>。

**kdb+/q**：美国kx公司开发的一款一体化数据应用平台，具备CEP、内存数据库、数据仓库、时间序列分析、向量运算、函数式交互式语言等功能，kdb+32位版本个人免费使用,Kdb+3.3 2015.08.23是最后一个可免费商用版本，有关kdb+详见<http://www.kx.com>或<http://itfin.f3322.org/opt/cgi/wiki.pl/KdbPlus>。

*感谢朱洪海、itfin、Freddie Wu/FlyingOE等!*

 
**推荐FlyingOE大侠的kdb+/q interface for Wind APIs (non-COM version)<https://github.com/FlyingOE/q_Wind>**



# WindKdb+数据及交易接口使用说明 

目录

 一、最近更新
 
 二、安装与使用 
 
 1、快速入门 
 
 （1）安装Wind量化接口并修复 
 
 （2）安装WindKdb+接口 
 
 （3）测试：历史数据提取 
 
 （4）测试：实时行情接收 
 
 （5）测试：交易接口 
 
 2、接口规范 
 
 三、接口函数 
 
 1、接口登录（start） 
 
 2、接口退出（stop） 
 
 3、日期序列（wsd） 
 
 4、快照数据（wss） 
 
 5、分钟序列（wsi） 
 
 6、日内跳价（wst） 
 
 6、实时数据快照（wsq） 
 
 7、实时数据订阅（wsqsub） 
 
 8、实时数据退订（cancelsub） 
 
 9、数据集（wset） 
 
 10、资管函数（wpf） 
 
 11、组合上传函数(wupf) 
 
 12、证券筛选(weqs) 
 
 13、特定交易日函数（tdays） 
 
 14、日期偏移函数（tdaysoffset） 
 
 15、交易日统计（tdayscount） 
 
 16、错误信息（werr） 
 
 17、回测函数（bkt...） 
 
 18、登录交易账户（tlogon） 
 
 19、退出交易帐户登录（tlogout） 
 
 20、下单（torder） 
 
 21、撤单（tcancel） 
 
 22、查询资金、持仓、委托等（tquery） 
 
 四、其它 
 
 1、主要文件 
 
 2、机构版和个人版 
 
 3、是否支持Windows XP或Windows Server 2003？ 
 
 4、编码 
 
 5、kdb+间接调用Wind接口 
 

## 一、最近更新

**2015.12.03**：（1）修正内存泄露问题；（2）wsqsub微调：重复的行情不再推送。注意返回的表的字段个数可能不同。

**2015.08.16**：（1）支持 tdq（快照）和tdqsub（订阅）， **需要开通权限** ;（2）改进行情回传机制；（3）qwapi.dll采用vc++2015编译。

**2015.03.16**：（1）修正BUG；（2）改进实时行情回传机制；（3）参数类型更合理，如证券代码既支持symbol型元素\`$&quot;600000.SH,600001.SH&quot;又支持symbol型数组\`600000.SH\`600001.SH，日期既支持symbol型\`20150316又支持date型2015.03.16，选项既支持symbol型\`$&quot;startdate=20141201;enddate=20141210;reportcurrency=CNY;owner=&quot;又支持dict型\`startdate\`enddate\`reportcurrency\`owner!(2014.12.01;2014.12.10;\`CNY;\`)。

**2015.02.13**：基于Wind C++新版接口V1.1。


## 二、安装与使用

### 1、快速入门

#### **（1）安装Wind量化接口并修复**

从大奖章网站<http://www.dajiangzhang.com>下载、安装。新版接口调用了相关COM组件，因此首次使用前需要注册COM组件：方法一是运行InstallShell.exe并选择安装C++插件；方法二是直接运行\wapi.pe\bin\initWAPI.exe。（机构版用户请通过终端里的&quot;量化&quot;菜单&quot;修复C++&quot;进行修复或执行\wind\bin\initWAPI.exe）


#### **（2）安装WindKdb+接口**

把windkdb.zip解压到任一目录，以下假设为d:\windkdb。从 [www.kx.com](http://www.kx.com)下载q for Windows免费版，将q.exe放在d:\windkdb\q\w32，将q.k放在d:\windkdb\q\。

注：若启动时提示缺失DLL文件，请从以下链接下载VC++运行时组件（vc\_redist.x86.exe）：

[http://www.microsoft.com/zh-CN/download/details.aspx?id=48145](http://www.microsoft.com/zh-CN/download/details.aspx?id=48145)

#### **（3）测试：历史数据提取**

运行d:\windkdb\windkdb.bat启动一个已加载了windkdb接口脚本（wapi.q）的kdb+。在q)后输入start[\`;\`]启动接口，在弹出的Wind登录窗口输入Wind账号和密码后登录。

执行以下语句：

q)r:wsd[\`000001.SZ;\`open\`high\`low\`close; 2015.02.03;2015.02.07;\`]  //请求平安银行2015.2.3-2.7的开高低收数据并将结果保存在r变量中。

其它数据提取函数见&quot;二、接口函数&quot;。

#### **（4）测试：实时行情接收**

运行d:\windkdb\windwsqsub.bat。

windwsqsub.bat 加载了wsqsub\_sample.q，其内容如下：

\l wapi.q

onwsqsub:{X::x;show x\`data;};    /改写onwsqsub函数，保存最新数据并显示数据

start[\`;\`];       /启动

wsqsub[\`EURUSD.FX;\`$&quot;rt\_time,rt\_latest&quot;;\`];    /订阅EURUSD的行情时间、最新成交价

#### **（5）测试：交易接口**

运行d:\windkdb\windkdb.bat，输入以下内容：

q) start[\`;\`]     //登录wind接口

q) tquery[\`broker;\`][\`data]   //读取券商/经纪商列表

q) tlogon[\`00000010;\`0;\`$&quot;M:13xxxxxxxxx01&quot;;\`yyyyyy;\` shsza;\`]  // 13xxxxxxxxx为你注册模拟交易的手机号，yyyyyy为密码，详见大奖章&quot;个人中心&quot;&quot;模拟交易&quot;。

q) tquery[\`account;\`][\`data]  //查询账户

q) tquery[\`order;\`][\`data]  //查询委托

q) tquery[\`trade;\`][\`data]  //查询成交

q) tquery[\`position;\`][\`data]  //查询持仓

q) tquery[\`capital;\`][\`data] //查询资金

q) 运行其它。

q) tlogout[1j]  //退出账户登录,假设logonid=1j

q) stop[]   //退出接口

### 2、接口规范

- windcode参数：Wind证券代码， symbol型，如 \`600000.SH（单个代码），\`$&quot;600000.SH,600001.SH,000001.SZ&quot;或\`600000.SH\`600001.SH\`000001.SZ（多个代码）

- indi参数：字段、指标，symbol型，若含有特殊字符或中文等，可这样表示：\`$&quot;…..&quot;。如\`$&quot;open,high,low,close&quot;或\`open\`high\`low\`close。

- begindt、enddt参数：起止日期，symbol型或date型，如\`20150101或2015.01.01。

- para参数：选项，symbol型或dict型，如\`tradedate=20150101或(1#\`tradedate)!(1#2015.01.01)。

- 返回的数据中，除了dt字段为datetime类型外，其它日期型指标返回float型数值，请用\`datetime$...或者转换为datetime，例如，返回的数据表MYDATA含有ipo_date、last_trade_day等日期字段，则update \`datetime$ipo\_date,\`datetime$last\_trade\_day from MYDATA。时间型指标返回float型数值，请用num2time函数转换，如num2time[93001f]或update newtime:num2time each rt\_time from MYDATA。

- 函数的返回值通常为一个dict。dict[\`errid]为0表示成功，否则失败，dict[\`errmsg]为提示信息，dict[\`data]为返回的数据，通常为一table。

- **用WindNavigator.exe生成相关参数；参数、返回数据等的详细情况请参考Wind C++接口或者其它接口的使用手册。**

## 三、接口函数

### 1、接口登录（start）

函数：start[options;options2]

功能：初始化及Wind认证。使用数据接口前应先执行本函数

例子：start[\`;\`]   / 显示登陆对话框

### 2、接口退出（stop）

函数：stop[]

### 3、日期序列（wsd）

函数：wsd[windcode,indi,begindt,enddt,para]

功能：返回选定证券品种的历史数据,包括日间的行情数据，基本面数据以及技术指标

例子：wsd[\`600036.SH;\`$&quot;open,high,low,close&quot;; \`20141201;\`20141209;\`]

wsd[\`600036.SH;\`open\`high\`low\`close; 2014.12.01;2014.12.09;()]

wsd[\`600036.SH;\`open\`high\`low\`close; \`20141201;\`20141209; ()]

### 4、快照数据（wss）

函数：wss[windcode,indi,para]

功能：返回选定品种的历史截面数据

例子：wss[\`$&quot;600000.SH,600001.SH&quot;;\`$&quot;sec\_name,open,close,total\_shares&quot;; \`$&quot;tradeDate=20141208&quot;]

wss[\`600000.SH\`600001.SH;\`sec_name\`open\`close\`total\_shares; (1#\`tradeDate)!1#.z.D]

### 5、分钟序列（wsi）

函数：wsi[windcode,indi,begindt,enddt,para]

功能：返回日内分钟K 线数据,包含当天

例子：wsi[\`$&quot;600000.SH&quot;;\`$&quot;open,close&quot;;\`$&quot;2014-12-08 09:00:00&quot;; \`$&quot;2014-12-08 15:00:00&quot;;\`$&quot;BarSize=5&quot;]

wsi[\`600000.SH;\`open\`close;2014.12.08T09:00:00; 2014.12.08T15:00:00;(1#\`BarSize)!1#5]

### 6、日内跳价（wst）

函数：wst[windcode,indi,begindt,enddt,para]

功能：返回日内盘口买卖十档快照数据和成交数据

例子：wst[\`$&quot;600000.SH&quot;;\`$&quot;open,last,ask,bid&quot;;\`$&quot;2014-12-10 09:00:00&quot;;\`$&quot;2014-12-10 15:00:00&quot;;\`]

wst[\`600000.SH;\`open\`last\`ask\`bid;.z.D;.z.Z;\`]

### 6、实时数据快照（wsq/tdq）

函数：wsq[windcode,indi,para]

功能：请求选定品种的实时数据快照

例子：wsq[\`600000.SH;\`$&quot;rt\_last,rt\_open,rt\_high,rt\_low&quot;;\`]

wsq[\`600000.SH;\`rt\_last\`rt_open\`rt\_high\`rt_low;\`]

tdq用法与wsq相同，但需要开通相关权限!

### 7、实时数据订阅（wsqsub/tdqsub）

函数：wsqsub[windcode,indi,para]

功能：订阅选定品种的实时数据，实时行情通过onwsqsub函数返回，可以改写该函数。

例子：onwsqsub:{MYDATA::x;show x\`data;};

wsqsub[\`600000.SH;\`$&quot;rt\_time,rt\_last&quot;;\`]

wsqsub[\`600000.SH;\`rt\_time\`rt_last;\`]

tdqsub用法与wsqsub相同，但需要开通相关权限!

### 8、实时数据退订（cancelsub）

函数：cancelsub[rid]

功能：退订指定订阅ID 的实时数据，参数为0j则退订所有订阅，即： cancelsub[0j]等同于cancelallsub[]

例子：cancelrequest[1j]

### 9、数据集（wset）

函数：wset[reportname,para]

功能：返回股票，基金，债券，商品等专题统计报表的数据

例子：wset[\`SectorConstituent;\`$&quot;date=20141209;sector=全部A股&quot;]

wset[\`SectorConstituent;\`date\`sector!(.z.D;\`$&quot;全部A股&quot;)]

### 10、资管函数（wpf）

函数：wpf[portfolioname,viewname,para]

功能：返回资产管理系统AMS、PMS统计报表的数据

例子：wpf[\`$&quot;test&quot;;\`$&quot;PMS.PortfolioDaily&quot;; \`$&quot;startdate=20141201;enddate=20141210;reportcurrency=CNY;owner=&quot;]

wupf[\`test;\`20150209;\`600036.SH;\`500;\`14.42;\`]\`data

### 11、组合上传函数(wupf)

函数：wupf[portfolioname,tradedate,windcode,quantity,costprice,para]

功能：上传组合持仓数据到PMS 组合管理系统

例子：wupf[\`test;\`20141210;\`600036.SH;\`100;\`14.12;\`]

### 12、证券筛选(weqs)

函数：weqs[filtername,para]

功能：返回终端证券筛选的证券集

例子：weqs[\`$&quot;牛人&quot;;\`]

### 13、特定交易日函数（tdays）

函数：tdays[begindt,enddt,para]

功能：指定特定交易所交易日，从begindt到enddt交易日(或日历日)的列表

例子：tdays[\`20140101;\`20141210;\`]

### 14、日期偏移函数（tdaysoffset）

函数：tdaysoffset[begindt,offset,para]

功能：从begindt起， OffSet(偏移，&gt;0后推，&lt;0前推)个Period（周期）的日期

例子：tdaysoffset[\`20140101; -5j;\`]

### 15、交易日统计（tdayscount）

函数：tdayscount[begindt,enddt,para]

功能：从begindt到enddt交易日(或日历日)总数

例子：tdayscount[\`20140101;\`20141210;\`]

### 16、错误信息（werr）

函数：werr[errid]

功能：根据错误ID获取错误信息

例子：werr[-40520001]

### 17、回测函数（bkt...）

以下回测函数的参数均为symbol类型，参数含义、返回值、用法等见《回测平台使用手册》。

bktstart[strategyname;begindt;enddt;para]

bktquery[qrycode;qrytime;para]

bktorder[tradetime;securitycode;tradeside;tradevol;para]

bktstatus[para]

bktend[para]

bktsummary[bktid;viewname;para]

bktdelete[bktid;para]

bktstrategy[para]

### 18、登录交易账户（tlogon）

函数：tlogon[brokerid,departmentid,logonaccount,password,accounttype]

功能：登录资金账号或者模拟账号。登陆成功时系统自动生成一个登录号logonid。

brokerid：经纪商代码，通过tquery[\`broker;\`]获取。\`0000 为WTTS 模拟柜台

departmentid：营业部代码，\`0 表示不必填写

logonaccount：资金账号，WFT 用户模拟账号股票为Wind账号+01，期货为Wind账号+02。

password：资金密码

accounttype：市场列表，取值如下：

账户类型，其含义如下。

\`SH、\`SZ、\`SHSZ 深圳上海A

\`SZB 深圳B

\`SHB 上海B

\`CZC 郑州商品

\`SHF 上海商品

\`DCE 大连商品

\`CFE 股指商品

例子：tlogon[\`0000;\`0;\`W888888801;\`W888888801;\`shsz]

### 19、退出交易帐户登录（tlogout）

函数：logout[logonid]

功能：退出登录号

例子：logout[1j]

### 20、下单（torder）

函数：torder[windcodes;tradeside;orderprice;ordervolume;para]

功能：委托下单

windcodes：证券代码，如\`600000.SH、\`000001.SZ

tradeside：交易方向

\`Buy 买入开仓(等同=证券买入)

\`Short 卖出开仓

\`Cover 买入平仓

\`Sell 卖出平仓(等同=证券卖出)

\`CoverToday 买入平今仓

\`SellToday 卖出平今仓

orderprice：委托价格

ordervolume:交易数量

para：

OderType委托方式，默认为限价交易。

LMT 限价委托

BOC 对方最优价格委托

BOP 本方最优价格委托

ITC 即时成交剩余撤销

B5TC 最优五档剩余撤销

FOK 全额成交或撤销委托

B5TL 最优五档剩余转限价

目前，深交所支持所有除最后一种，上交所只支持LMT，

B5TC 、 B5TL 三种

HedgeType是否为投机套保。SPEC 为投机，如果选择套保需要专

门的套保账号。

LogonID登录号，多账号必须指定。

例子：torder[\`600036.SH;\`buy;\`14.44;\`100;\`]

### 21、撤单（tcancel）

函数：tcancel[ordernumber]

功能：取消委托，ordernumber委托编号，为symbol类型。

例子：tcancel[\`1]

### 22、查询资金、持仓、委托等（tquery）

函数：tquery[qrycode,para]

功能：进行资金、持仓、委托等查询

当日委托查询：tquery[\`order;\`]

当日成交查询：tquery[\`trade;\`]

持仓查询：tquery[\`position;\`]

资金查询：tquery[\`capital;\`]

股东账号或保证金账号查询：tquery[\`account;\`]

经纪商编号查询：tquery[\`broker;\`]

## 四、其它

### 1、主要文件

d:\windkdb\windkdb.bat（启动一个kdb+实例，加载了wapi.q）

d:\windkdb\windwsqsub.bat（启动实时行情接收例子）

d:\windkdb\q\wapi.q（windkdb接口脚本）

d:\windkdb\q\wsqsub\_sample.q（实时行情接收例子脚本）

d:\windkdb\q\qusers（用户密码文件，由&quot;:&quot;分隔的用户和密码）

d:\windkdb\q\w32\q.exe（q 3.x免费版，请从kx网站下载）

d:\windkdb\q\w32\qwapi.dll（接口DLL）

d:\windkdb\q\w32\WAPIWrapperCpp.dll（wind接口封装dll）

d:\windkdb\q\w32\msvcp120.dll（VC运行时）

d:\windkdb\q\w32\vcruntime140.dll（VC运行时）

d:\windkdb\q\w64\qwapi.dll（64位接口DLL，需要64位q）

d:\windkdb\q\w64\WAPIWrapperCpp.dll（64位wind接口封装dll，需要64位q）

### 2、机构版和个人版

同时安装有机构版和个人版接口时，可在PATH环境变量中指定wind接口文件搜索路径来决定windkdb+接口使用哪个版本。

### 3、编码

中文用GBK编码。脚本文件保存为ANSI/GBK编码。（如果在studio for kdb+执行接口函数，请在C:\Users\[username]\.studioforkdb\studio.properties中添加一行：encoding=GBK）

### 4、kdb+间接调用Wind接口

间接调用：kdb+先调用R、Matlab、Python（详见kx网站），R、Matlab、Python再调用Wind接口（详见大奖章网站）。

