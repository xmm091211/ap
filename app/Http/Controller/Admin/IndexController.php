<?php

class indexController extends Controllers
{
    //后台登录
    public function login()
    {
        //验证是否已经登录
        if (isset($_SESSION[api_admin_auth]) && $_SESSION[api_admin_auth] === true) {
            return redirect('index.html');
        }
        view(ADMIN_PATH . "/login");
    }

    //接口编辑
    public function editapi()
    {
        Authentication::AdminAuth();
        //获取ID
        $id = Request::get('id');
        $data['info'] = self::$db->fetchRow(ADMIN_APIINFO, [$id]); //基本信息 

        $data['data'] = self::$db->fetchRow(ADMIN_DATACHA, [$id]); //数据绑定

        $table = self::$db->fetchAll(ADMIN_TABLESALL); //获取数据库所有表名
        //获取数据库名
        $table_name =  config('database', 'dbname');
        //出去数据库所有表名
        foreach ($table as $key => $value) {
            $d[$key] = $value['Tables_in_' . $table_name];
        }
        $data['table'] = $d;

        //判断绑定数据是否存在
        if (!$data['data']['b_table'] == null) {
            //查询数表字段
            $field = self::$db->fetchAll(ADMIN_FIELD . $data['data']['b_table']);
            //表字段处理
            foreach ($field as $key => $value) {
                $c[$key] = $value['Field'];
            }
            $data['field'] = $c;
        }
        $data['price'] = self::$db->fetchRow(ADMIN_Price, [$id]); //价格
        $data['val'] = self::$db->fetchAll(ADMIN_VALDOC, [$data['info']['l_id']]); //参数
        // dd($data['field']);
        // dd($data);

        view(ADMIN_PATH . "/editapi", ['data' => $data]);
    }

    //后台首页
    public function index()
    {
        Authentication::AdminAuth();
        //平台用户数
        $data['total'] = self::$db->fetchAll(WEB_USER);
        //注册人数
        $data['register'] = self::$db->fetchAll(WEB_USER_DAY, [date("Y-m-d", strtotime("-1 day"))]);
        //累计收益
        $mn = self::$db->fetchAll(WEB_USER_PAY);
        //api总数
        $data['api'] =  self::$db->fetchAll(WEB_USER_API);
        $m = 0;
        foreach ($mn as $key => $value) {
            $m = $m + $value['money'];
        }
        $data['profit'] = $m;
        view(ADMIN_PATH . "/index", ['data' => $data]);
    }

    //添加接口页
    public function addapi()
    {
        Authentication::AdminAuth();
        view(ADMIN_PATH . "/addapi");
    }

    //数据绑定页
    public function datainfo()
    {
        Authentication::AdminAuth();
        //接口数据查询
        $apilist = self::$db->fetchAll(ADMIN_ADDLIST);

        //获取绑定数据
        foreach ($apilist as $key => $value) {
            // if ($value['l_data'] == 1) {
            $apidata[$key] = $value;
            // }
        }
        // dd($apidata);
        $data['apilist'] = $apidata;
        //表查询
        $table = self::$db->fetchAll(ADMIN_TABLESALL);
        //获取表名
        $table_name =  config('database', 'dbname');
        foreach ($table as $key => $value) {
            $d[$key] = $value['Tables_in_' . $table_name];
        }
        $data['table'] = $d;
        view(ADMIN_PATH . "/datainfo", ['data' => $data]);
    }

    // 文件绑定页
    public function fileinfo()
    {
        Authentication::AdminAuth();
        //接口数据查询
        $apilist = self::$db->fetchAll(ADMIN_ADDLIST);
        //获取绑定数据
        foreach ($apilist as $key => $value) {
            // if ($value['l_data'] == 1) {
            $apidata[$key] = $value;
            // }
        }
        $data['apilist'] = $apidata;
        //表查询
        $table = self::$db->fetchAll(ADMIN_TABLESALL);
        //获取表名
        $table_name =  config('database', 'dbname');
        foreach ($table as $key => $value) {
            $d[$key] = $value['Tables_in_' . $table_name];
        }
        $data['table'] = $d;
        view(ADMIN_PATH . "/fileinfo", ['data' => $data]);
    }

    //参数设置页
    public function apiinfo()
    {
        Authentication::AdminAuth();
        //接口数据查询
        $data = self::$db->fetchAll(ADMIN_ADDLIST);
        view(ADMIN_PATH . "/apiinfo", ['data' => $data]);
    }

    //接口列表页
    public function apilist()
    {
        Authentication::AdminAuth();
        //数据查询
        $data = self::$db->fetchAll(ADMIN_ADDLIST);
        view(ADMIN_PATH . '/apilist', ['data' => $data]);
    }

    //网站设置页
    public function webset()
    {
        Authentication::AdminAuth();
        //获取网站数据
        $web = config('webset');
        view(ADMIN_PATH."/webset", ['web' => $web]);
    }

    //会员列表页
    public function userinfo()
    {
        Authentication::AdminAuth();

        $data = self::$db->fetchAll(ADMIN_USER);

        view(ADMIN_PATH.'/userinfo', ['data' => $data]);
    }

    //修改密码
    public function passwd()
    {
        Authentication::AdminAuth();
        view(ADMIN_PATH."/passwd");
    }

    //退出登录
    public function logout()
    {
        //清除Session
        unset($_SESSION[api_admin_auth]);
        unset($_SESSION['info']);
        redirect(ADMIN_PATH."/login.html");
    }

    //用户编辑
    public function useredit()
    {
        Authentication::AdminAuth();
        $id = Request::get('id');
        $data = self::$db->fetchRow(ADMIN_USER_ROW, [$id]);
        view(ADMIN_PATH."/useredit", ['data' => $data]);
    }

    //用户添加
    public function adduser()
    {
        Authentication::AdminAuth();
        view(ADMIN_PATH."/adduser");
    }

    //邮箱配置
    public function email()
    {
        Authentication::AdminAuth();
        $web = config('email');
        view(ADMIN_PATH."/email", ["web" => $web]);
    }

    //redis
    public function redis()
    {
        Authentication::AdminAuth();
        $web = config('redis');
        view(ADMIN_PATH."/redis", ['web' => $web]);
    }

    // 订单页
    public function order()
    {
        Authentication::AdminAuth();
        $sql = "SELECT * FROM api_order INNER JOIN api_user ON api_order.o_u_id = api_user.a_u_id ORDER BY o_id DESC";
        $data = self::$db->fetchAll($sql);
        view(ADMIN_PATH."/order", ['data' => $data]);
    }
}
