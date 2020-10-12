<?php
infoAction();

function infoAction() {
	/**给返回参数默认值*/
	$code = -1;
	$msg = 'error';
	$data = [];

	$res = $_GET['url'];
	if (!$res) {
		$msg = '参数缺失';
	}else{
		//调用的站长工具
		$json = file_get_contents('http://icp.chinaz.com/'.$res);
		// 获取主办单位名称
		$name = GetBetween($json,'主办单位名称</span><p>','<');
		// 获取性质
		$nature = GetBetween($json,'主办单位性质</span><p><strong class="fl fwnone">','<');
		// 获取备案号
		$icp = GetBetween($json,'网站备案/许可证号</span><p><font>','<');
		// 获取网站名称
		$sitename = GetBetween($json,'网站名称</span><p>','<');
		// 获取网站首页地址
		$index = GetBetween($json,'网站首页网址</span><p class="Wzno">','<');
		// 获取审核时间
		$time = GetBetween($json,'审核时间</span><p>','<');
		if (!strstr($index,".")) {
			$code = 200;
			$msg = '未查询到备案信息';
			$data = [];
		}else{
			$code = 200;
			$msg = 'success';
			$data = [
				'url' => $res,
				'organizer_name' => $name,
				'nature' => $nature,
				'license' => $icp,
				'website_name' => $sitename,
				'website_home' => $index,
				'audit_time' => $time
			];
		}
	}
	$result = [//返回数据统一处理
		'code' => $code,
		'msg' => $msg,
        'data' => $data
    ];
    die(json_encode($result,JSON_UNESCAPED_UNICODE));    //json返回
}

function GetBetween($content,$start,$end) {
	$r = explode($start, $content);
	if (isset($r[1])) {
		$r = explode($end, $r[1]);
		return $r[0];
	}
	return '';
}
?>