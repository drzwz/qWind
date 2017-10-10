\l wapi.q
onwsqsub:{X::x;show x`data;};    /改写onwsqsub函数，保存最新数据并显示数据
start[`;`];       /启动
wsqsub[`EURUSD.FX;`$"rt_date,rt_time,rt_pre_close,rt_open,rt_high,rt_low,rt_latest,rt_vol,rt_amt,rt_oi,rt_bid1,rt_bsize1,rt_ask1,rt_asize1";`];     /订阅EURUSD的行情时间、最新成交价
