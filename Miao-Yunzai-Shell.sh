#!bin/bash

#进入root根目录
cd /root/

#打印菜单
function Mz()
{
	clear
	cat <<out
*******************************************************
           
                  Miao-Yunzai一键安装
项目地址：https://gitee.com/yoimiya-kokomi/Miao-Yunzai
          https://github.com/yoimiya-kokomi/Miao-Yunzai
	  本脚本适合在开启科学上网后安装
         建议先按11安装基础再去安装喵崽
        
*******************************************************    
              
1.部署喵版云崽与喵喵插件

2.插件管理

3.机器人常见问题

4.报错修复（有问题先看这个选项！！！）

5.重新配置机器人QQ号（可能需要重新验证）

6.安装python3.10版本(时间较长，约半小时)

7.安装ffmpeg

8.更改主人QQ

9.没记住各种快捷代码？再看一次！

10.友情链接

11.安装前置node

0.退出脚本

*******************************************************
out
}
function MzNum()
{
	read -p "请输入选项数字并回车：" mzNmum
	case $mzNmum in
		0)
			exit 0
			;;
		1)
			MzInstall
			;;
		2)
			Plugin
			;;
		3)
			Question
			;;
		4)
			Repaire
			;;
		5)
			Reconfig
			;;
		6)
			PythonInstall
			;;
		7)
			FfmpegInstall
			;;
		8)
			MasterQQ
			;;
		9)
			Review
			;;
		10)
			OtherLink
			;;
                11)
			nodejs
			;;
		999)
			test
			;;
		*)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            Mz
			MzNum
            ;;
    esac
}

#部署喵崽
function MzInstall()
{
	clear
	echo "您正在尝试进行机器人部署步骤，请确保全程网络通畅！"
	sleep 3s
	
	#安装git
    if ! type git >/dev/null 2>&1; then
        echo '正在准备安装git'
	    sleep 0.5s
        echo '正在准备安装git'
	    sleep 0.5s
        echo '正在准备安装git'
	    sleep 0.5s
        apt update
        apt install git -y
		if type git >/dev/null 2>&1; then
			echo 'git安装完成'
			sleep 1s
		else
			echo 'git安装失败，可能是安装过程中网络波动引起，请重新运行安装步骤重试。'
			sleep 3s
			exit
		fi
    else
        echo '已安装git，不再重复安装'
        sleep 1.5s
    fi

#安装redis
    if ! type redis-server >/dev/null 2>&1; then
        echo '正在准备安装并启动redis'
	    sleep 0.5s
	    echo '正在准备安装并启动redis'
	    sleep 0.5s
	    echo '正在准备安装并启动redis'
	    sleep 0.5s
        apt-get install redis -y
		if ! type redis-server >/dev/null 2>&1; then
			echo 'redis安装失败，请确保网络环境后重试，或自行下载'
			exit
		else
			redis-server --daemonize yes --save 900 1 --save 300 10
			echo 'redis安装且启动成功'
			sleep 1.5s
		fi
    else
        echo '已安装redis，不再重复安装'
        redis-server --daemonize yes --save 900 1 --save 300 10
        echo '已启动redis'
    fi

    #安装chroimum
    if ! type chromium-browser >/dev/null 2>&1; then
        echo '正在准备安装chromuim及中文字体'
	    sleep 0.5s
	    echo '正在准备安装chromuim及中文字体'
	    sleep 0.5
	    echo '正在准备安装chromuim及中文字体'
	    sleep 0.5
        apt install chromium-browser -y
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
	    echo '安装成功'
	    sleep 1.5s
    else
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
        echo '安装成功'
        sleep 1.5s
    fi
	
	#克隆喵崽项目
	cd /root/
	if [ -e /root/Miao-Yunzai ];then
		echo -e '已存在喵崽，是否删除该文件并重新部署？'
		read -p '请输入选项y/n：' options
		if [ $options == y ];then
			#删除文件夹
			echo '正在删除已有喵崽文件……'
			rm -rf /root/Miao-Yunzai
			if [ -e /root/Miao-Yunzai ];then
				echo '删除文件失败，可能是读写权限不足'、
				exit
			else
				echo '删除完成'
				sleep 1s
			fi
			echo '正在准备重新部署机器人项目'
			sleep 1s
			git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
			if [ -e /root/Miao-Yunzai ];then
				echo '重新部署完成'
				sleep 1s
			else
				echo '重新部署失败，可能是中途网络波动或仓库问题，请重试'
				exit
			fi
		elif [ $options == n ];then
			echo '已忽略，不再重新下载喵崽'
			sleep 1s
			fi
	else
		echo '正在准备下载喵崽……'
		sleep 1s
		git clone --depth=1 https://gitee.com/yoimiya-kokomi/Miao-Yunzai.git
		if [ -e /root/Miao-Yunzai ];then
				echo '喵崽下载完成'
				sleep 1s
		else
				echo '喵崽下载失败，可能是中途网络波动或仓库问题，请重试'
				exit
		fi
	fi
	
	#检查是否有云崽，并迁移插件和数据
	if [ -e /root/Yunzai-Bot ];then
		echo '检查到已有云崽，是否迁移插件和数据？'
		read -p '请输入选项y/n：' options
		if [ $options == y ];then
			#迁移插件
			mkdir /root/Miao-Yunzai/data
			rm -rf /root/Miao-Yunzai/plugins
			cp -r /root/Yunzai-Bot/plugins /root/Miao-Yunzai/
			#迁移token等数据
			if [ -e /root/Yunzai-Bot/data/icqq ] && [ ! -e /root/Miao-Yunzai/data/icqq ];then
				cp -r /root/Yunzai-Bot/data/icqq /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/MysCookie ] && [ ! -e /root/Miao-Yunzai/data/MysCookie ];then
				cp -r /root/Yunzai-Bot/data/MysCookie /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/NoteData ] && [ ! -e /root/Miao-Yunzai/data/NoteData ];then
				cp -r /root/Yunzai-Bot/data /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/UserData ] && [ ! -e /root/Miao-Yunzai/data/UserData ];then
				cp -r /root/Yunzai-Bot/data/UserData /root/Miao-Yunzai/data
			fi
			if [ -e /root/Yunzai-Bot/data/gachaJson ] && [ ! -e /root/Miao-Yunzai/data/gachaJson ];then
				cp -r /root/Yunzai-Bot/data/gachaJson /root/Miao-Yunzai/data
			fi
			echo '已成功迁移原云崽数据与插件！'
		elif [ $options == n ];then
			echo '取消迁移数据！'
		else
			echo '输入内容有误，默认不进行迁移，请后续自行手动迁移！'
		fi
	fi

	#安装喵喵插件
	echo '准备安装喵喵插件，支持查询游戏内角色面板，角色材料图鉴等信息'
	sleep 1s
	cd /root/Miao-Yunzai/plugins
	if  [ -e miao-plugin ];then
	read -p '已有喵喵插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载喵喵插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf miao-plugin
			git clone --depth=1 https://github.com/yoimiya-kokomi/miao-plugin.git
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://github.com/yoimiya-kokomi/miao-plugin.git
		echo '喵喵插件安装完成'
		sleep 1s
	fi

	
	#写入启动代码
	echo echo 正在启动机器人 > /usr/bin/mz
	sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd /root/Miao-Yunzai && node app' /usr/bin/mz
  chmod 777 /usr/bin/mz
 echo echo 正在后台启动机器人 > /usr/bin/mzstart
	sed -i -e '1a cd /root/Miao-Yunzai && pnpm start' /usr/bin/mzstart
	chmod 777 /usr/bin/mzstart
    echo echo 查看机器人日志 > /usr/bin/mzlog
    sed -i -e '1a cd /root/Miao-Yunzai && pnpm run log' /usr/bin/mzlog 
    chmod 777 /usr/bin/mzlog
    echo echo 正在停止机器人 > /usr/bin/mzstop
    sed -i -e '1a cd /root/Miao-Yunzai && pnpm stop' /usr/bin/mzstop
    chmod 777 /usr/bin/mzstop
	#检查是否曾使用过历史脚本
	if [ -e /usr/bin/cn ];then
		rm -rf /usr/bin/cn
		echo echo 正在启动长楠脚本 > /usr/bin/cn
		sed -i -e '1a bash <(curl -sL https://github.com/kexoub/Yunzai-Miao-ubuntu/raw/main/Miao-Yunzai-Shell.sh)' /usr/bin/cn
		chmod 777 /usr/bin/cn
	else
		echo echo 正在启动长楠脚本 > /usr/bin/cn
		sed -i -e '1a bash <(curl -sL https://github.com/kexoub/Yunzai-Miao-ubuntu/raw/main/Miao-Yunzai-Shell.sh)' /usr/bin/cn
		chmod 777 /usr/bin/cn
	fi
	clear
	
    echo -e '\033[32m执行完成\033[0m'
    echo -e '\033[32m请重新打开脚本输入11安装nodejs\033[0m'
    echo -e "重新打开本脚本请输入：\033[47;31mcn\033[0m"
    echo -e "启动机器人请输入\033[47;31mmz\033[0m"
    echo -e "机器人后台启动运行（即不显示代码启动）请输入：\033[47;31mmzstart\033[0m"
    echo -e "显示机器人日志请输入：\033[47;31mmzlog\033[0m"
    echo -e "停止机器人后台运行请输入：\033[47;31mmzstop\033[0m"
	echo -e "已安装喵喵插件，机器人正常运行后输入【\033[34m#喵喵帮助\033[0m】以查看帮助面板"
    echo -e '现在请输入\033[43;31mmz\033[0m以启动机器人并进行配置'
    echo '结束，跑路'
    echo '赞美乐神'
	echo '赞美喵佬'
    exit
}

#插件管理
function Plugin()
{
function PluginIndex()
{
	clear
    cat <<out
*******************************************************

                    plugin插件管理

*******************************************************

	1.安装插件          |          2.删除插件
	 
	3.返回              |          0.退出脚本

*******************************************************
out
}
function PluginIndexNum()
{
	read -p '请输入数字选项并回车：' indexNum
	case $indexNum in
        0)
			exit
            ;;
        1)
            PluginInstall
            ;;
        2)
            DelPlugin
            ;;
		3)
            Mz
			MzNum
			;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            echo
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            echo
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            sleep 3s
            PluginIndex
            PluginIndexNum
            ;;
    esac
}
function PluginInstall()
{
function InstallList()
{
	clear
    cat <<out
*******************************************************

                       插件列表
            本列表来源：渔火云崽插件索引目录
      gitee.com/yhArcadia/Yunzai-Bot-plugins-index

*******************************************************

 1.【锅巴插件】#锅巴帮助          可视化的云崽管理
 2.【抽卡插件】#抽卡帮助          更优化的抽卡体验
 3.【成就插件】#成就帮助            科学的成就录入
 4.【白纸插件】#白纸帮助          b站直播投稿及动态推送
 5.【闲心插件】#闲心帮助          b站推送与群聊小游戏
 6.【土块插件】#土块帮助          ai绘图为主的娱乐插件
 7.【小飞插件】#小飞帮助          群聊娱乐插件
 8.【麟插件】#lin帮助/#ai帮助     部分群聊娱乐功能
 9.【椰奶插件】#椰奶帮助          群聊管理与娱乐功能
10.【小月插件】#小月帮助          提供群聊娱乐功能
11.【虚空插件】#虚空帮助          群内决斗等娱乐功能
12.【清凉图插件】#清凉图帮助      获取一些比较清凉的图片
13.【小叶插件】#小叶帮助          模拟刷取圣遗物功能
14.【榴莲插件】#榴莲帮助          原神地下地图与b站推送
15.【ap插件】ap帮助               提供ai绘图与搜图等功能
16.【脆脆鲨插件】#脆脆鲨帮助       基于云崽的功能插件
17.【光遇插件】sky帮助            为云崽提供光遇相关插件
18.【拓展插件】#拓展帮助          为云崽提供拓展功能
19.【碎月插件】暂无帮助指令       疯狂星期四等娱乐功能 
20.【Atlas插件】暂无帮助指令      提供原神各种图鉴信息
21.【止水插件】暂无帮助指令        提供搜剧功能
22.【自动化插件】暂无帮助指令     自动群名片与一些小功能
23.【WeLM插件】#welm帮助          提供机器人对话功能
24.【图鉴插件】#图鉴帮助          原神各种图鉴资源查询

 0.返回

*******************************************************
out
}
function PluginInstallNum()
{
    read -p '请输入数字选项并回车：' pluginInstallNum
    case $pluginInstallNum in
        0)
            PluginIndex
			PluginIndexNum
            ;;
        1)
            guoba
            ;;
        2)
            gacha
            ;;
        3)
            achievement
            ;;
        4)
            zhi
            ;;
        5)
            xianxin
            ;;
        6)
            earthk
            ;;
        7)
            xiaofei
            ;;
        8)
            lin
            ;;
        9)
			yenai
			;;
		10)
			xiaoyue
			;;
		11)
			akasha
			;;
		12)
			xwy
			;;
		13)
			xiaoye
			;;
		14)
			liulian
			;;
		15)
			ap
			;;
		16)
			cuicuisha
			;;
		17)
			sky
			;;
		18)
			tuozhan
			;;
		19)
			suiyue
			;;
		20)
			altas
			;;
		21)
			zhishui
			;;
		22)
			auto
			;;
		23)
			welm
			;;
        24)
            xiaoyao
            ;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo '\n\n\n'
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            echo
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            echo
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            sleep 3s
            InstallList
            PluginInstallNum
            ;;
	esac
}

#锅巴插件安装
function guoba()
{
	cd /root/Miao-Yunzai/plugins
	if [ -e Guoba-Plugin ];then
	read -p '已有锅巴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载锅巴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Guoba-Plugin
			git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./Guoba-Plugin/
			cd /root/Miao-Yunzai && pnpm update
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./Guoba-Plugin/
		cd /root/Miao-Yunzai && pnpm update
		echo '锅巴插件安装成功'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#抽卡插件安装
function gacha()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e flower-plugin ];then
	read -p '已有抽卡插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载抽卡插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf flower-plugin
			git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./flower-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./flower-plugin/
		echo '抽卡插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#成就插件安装
function achievement()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e achievement ];then
	read -p '已有成就插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载成就插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf achievement
			git clone --depth=1 https://gitee.com/zolay-poi/achievements-plugin.git ./achievements-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/zolay-poi/achievements-plugin.git ./achievements-plugin/
		echo '成就插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#白纸插件安装
function zhi()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e zhi ];then
	read -p '已有白纸插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载白纸插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf zhi-plugin
			git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git ./zhi-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git ./zhi-plugin/
		echo '白纸插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#闲心插件安装
function xianxin()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e xianxin-plugin ];then
	read -p '已有闲心插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载闲心插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xianxin-plugin
			git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./xianxin-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./xianxin-plugin/
		echo '闲心插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#光遇插件安装
function sky()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e Tlon-Sky ];then
	read -p '已有光遇插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载光遇插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Tlon-Sky
			git clone --depth=1 https://gitee.com/Tloml-Starry/Tlon-Sky.git ./Tlon-Sky/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Tloml-Starry/Tlon-Sky.git ./Tlon-Sky/
		echo '光遇插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#土块插件安装
function earthk()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e earth-k-plugin ];then
	read -p '已有土块插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载土块插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf earth-k-plugin
			git clone --depth=1 https://gitee.com/SmallK111407/earth-k-plugin.git ./earth-k-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/SmallK111407/earth-k-plugin.git ./earth-k-plugin/
		echo '土块插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小飞插件安装
function xiaofei()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e xiaofei-plugin ];then
	read -p '已有小飞插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小飞插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaofei-plugin
			git clone --depth=1 https://gitee.com/xfdown/xiaofei-plugin.git ./xiaofei-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xfdown/xiaofei-plugin.git ./xiaofei-plugin/
		echo '小飞插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#麟插件安装
function lin()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e lin-plugin ];then
	read -p '已有麟插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载麟插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf lin-plugin
			git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./lin-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./lin-plugin/
		echo '麟插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#椰奶插件安装
function yenai()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e yenai-plugin ];then
	read -p '已有椰奶插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载椰奶插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf yenai-plugin
			git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./yenai-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./yenai-plugin/
		echo '椰奶插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小月插件安装
function xiaoyue()
{	
	cd /root/Miao-Yunzai/plugins
	if  [ -e xiaoyue-plugin ];then
	read -p '已有小月插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小月插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf recreation-plugin
			git clone --depth=1 https://gitee.com/yunxiyuan/xiaoyue-plugin.git ./xiaoyue-plugin
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yunxiyuan/xiaoyue-plugin.git ./xiaoyue-plugin
		echo '小月插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小叶插件安装
function xiaoye()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e xiaoye-plugin ];then
	read -p '已有小叶插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小叶插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaoye-plugin
			git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./xiaoye-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./xiaoye-plugin/
		echo '小叶插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#榴莲插件安装
function liulian()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e liulian-plugin ];then
	read -p '已有榴莲插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载榴莲插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf liulian-plugin
			git clone --depth=1 https://gitee.com/huifeidemangguomao/liulian-plugin.git ./liulian-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/huifeidemangguomao/liulian-plugin.git ./liulian-plugin/
		echo '榴莲插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#部署逍遥图鉴插件
function xiaoyao()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e xiaoyao-cvs-plugin ];then
	read -p '已有图鉴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载图鉴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaoyao-cv-plugin
			git clone --depth=1 https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
			echo '已删除原图鉴并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
		echo '图鉴插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#ap插件安装
function ap()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e ap-plugin ];then
	read -p '已有ap插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载ap插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf ap-plugin
			git clone --depth=1 https://gitee.com/yhArcadia/ap-plugin.git ./ap-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yhArcadia/ap-plugin.git ./ap-plugin/
		echo 'ap插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#脆脆鲨插件安装
function cuicuisha()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e Jinmaocuicuisha-plugin ];then
	read -p '已有脆脆鲨插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载脆脆鲨插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Jinmaocuicuisha-plugin
			git clone --depth=1 https://gitee.com/JMCCS/jinmaocuicuisha.git ./Jinmaocuicuisha-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/JMCCS/jinmaocuicuisha.git ./Jinmaocuicuisha-plugin/
		echo '脆脆鲨插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#拓展插件安装
function tuozhan()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e expand-plugin ];then
	read -p '已有拓展插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载拓展插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf expand-plugin
			git clone --depth=1 https://gitee.com/SmallK111407/expand-plugin.git ./expand-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/SmallK111407/expand-plugin.git ./expand-plugin/
		echo '拓展插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#清凉图插件安装
function xwy()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e yunzai-c-v-plugin ];then
	read -p '已有清凉图插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载清凉图插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf yunzai-c-v-plugin
			git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./yunzai-c-v-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./yunzai-c-v-plugin/
		echo '清凉图插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#止水插件安装
function zhishui()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e zhishui-plugin ];then
	read -p '已有止水插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载止水插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf zhishui-plugin
			git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./zhishui-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./zhishui-plugin/
		echo '止水插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#自动化插件安装
function auto()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e auto-plugin ];then
	read -p '已有自动化插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载自动化插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf auto-plugin
			git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./auto-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./auto-plugin/
		echo '自动化插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#碎月插件安装
function suiyue()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e suiyue ];then
	read -p '已有碎月插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载碎月插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf suiyue
			git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./suiyue/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./suiyue/
		echo '碎月插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#atlas插件安装
function altas()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e Altas ];then
	read -p '已有altas图鉴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载altas图鉴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Altas
			git clone --depth=1 https://gitee.com/Nwflower/atlas ./Altas/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/atlas ./Altas/
		echo 'altas图鉴插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#welm插件安装
function welm()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e WeLM-plugin ];then
	read -p '已有welm插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载welm插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf WeLM-plugin
			git clone -b master --depth=1 https://gitee.com/shuciqianye/yunzai-custom-dialogue-welm.git ./WeLM-plugin/
			cd /root/Miao-Yunzai && pnpm update
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone -b master --depth=1 https://gitee.com/shuciqianye/yunzai-custom-dialogue-welm.git ./WeLM-plugin/
		cd /root/Miao-Yunzai && pnpm update
		echo 'welm插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#虚空插件安装

function akasha()
{
	cd /root/Miao-Yunzai/plugins
	if  [ -e akasha-terminal-plugin ];then
	read -p '已有虚空插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载虚空插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf akasha-terminal-plugin
			git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git ./akasha-terminal-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git ./akasha-terminal-plugin/
		echo '虚空插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#进行一次plugin插件列表运行

InstallList
PluginInstallNum

}

#插件删除，摆烂了，就这样吧

function DelPlugin()
{
	clear
    echo -e '\n\n'
	echo '**************    已安装插件    ***************'
    echo -e '\n'
    for file in `ls /root/Miao-Yunzai/plugins`;do
        if [ "$file" != "example" ] && [ "$file" != "other" ] && [ "$file" != "system" ] && [ "$file" != "genshin" ];then
		    echo -e "\t\t\033[32m$file\033[0m"
            echo
        fi
	done
    echo
    echo '***********************************************'
    echo -e '\n\n'
    echo '请输入你要删除的插件名称,输入0并回车以返回'
    echo
	read -p '请在删除前三思，请勿误删：' pluginname
	if [ -e /root/Miao-Yunzai/plugins/$pluginname ];then
		rm -rf /root/Miao-Yunzai/plugins/$pluginname
        echo
		echo -e '正在删除插件…… '
        sleep 1s
		if [ -e /root/Miao-Yunzai/plugins/$pluginname ];then
            echo
			echo -e '插件删除失败，请重新删除'
			sleep 1.5s
            PluginIndex
            PluginIndexNum
		else
            echo
			echo -e '插件删除成功'
            sleep 1s
            PluginIndex
            PluginIndexNum
			fi
	elif [ $pluginname == 0 ];then
        PluginIndex
        PluginIndexNum
    else
        echo
		echo '输入的插件名称不正确或不存在该插件！请确保你输入了正确的插件全称！'
		sleep 1s
        DelPlugin
	fi
}

#判断是否已经有云崽项目后再进行插件管理
cd ~
if  [ -e /root/Miao-Yunzai ];then
    PluginIndex
    PluginIndexNum
else
    echo "请先部署喵崽后再进行插件管理！"
    sleep 1s
    echo "请先部署喵崽后再进行插件管理！"
    sleep 1s
    echo "请先部署喵崽后再进行插件管理！"
    sleep 1s
    Mz
	MzNum
fi

}

#报错修复
function Repaire()
{
function RepaireList()
{
	clear
    cat <<out
*******************************************************

                 请按照报错内容进行选择
				 
*******************************************************

1.QQ版本过低或禁止登录

2.puppeteer启动失败

3.返回

0.退出脚本

*******************************************************
out
}

function RepaireNum()
{
	read -p '请按照报错内容选择：' num
	case $num in
		0)
			exit
			;;
		1)
			QQ-repaire
			;;
		2)
			puppeteer-repaire
			;;
		3)
			Mz
			MzNum
			;;
		*)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            RepaireList
            RepaireNum
            ;;
    esac
}

#版本过低修复
function QQ-repaire()
{
	clear
	echo '本方法仅仅适用于部分版本过低和禁止登录问题，如多次后无法解决，请停止修复防止账号异常'
	read -p '请输入你的机器人QQ号并回车：' QQnumber
    sed -i '/platform/d' /root/Miao-Yunzai/config/config/qq.yaml
    echo platform: 6 >> /root/Miao-Yunzai/config/config/qq.yaml
    cd root/Miao-Yunzai/data/icqq/$QQnumber
    curl -o device.json https://gitee.com/fw-cn/Yunzai/raw/master/QQrepaire
	echo '已尝试进行修复'
	read -p '是否立刻启动机器人，输入1启动，输入0不启动：' num
	if [ $num == 1 ];then
		redis-server --daemonize yes --save 900 1 --save 300 10 && cd /root/Miao-Yunzai && node app
		exit
	else
		echo '不启动机器人，请后续自行启动查看是否修复完成'
		sleep 1s
	fi
}

function puppeteer-repaire()
{
	clear
    echo 请选择你的系统版本：
    echo 1.ubuntu18.04
    echo 2.ubuntu20.04
    echo 3.ubuntu22.04
    echo 4.我不知道啊，跟着教程来的
    echo 0.返回
    read -p '请输入数字选项：' num
    if [ $num == 1 ];then
        cd /root/Miao-Yunzai
        git checkout . && git pull
        pnpm config set registry https://registry.npmmirror.com && pnpm config set puppeteer_download_host=https://registry.npmmirror.com && pnpm i
        pnpm add puppeteer@19.7.0 -w
        apt-get install ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils -y
    elif [ $num == 2 ] || [ $num == 3 ];then
        cd /root/Miao-Yunzai
        git checkout . && git pull
        pnpm config set registry https://registry.npmmirror.com && pnpm config set puppeteer_download_host=https://registry.npmmirror.com && pnpm i
        pnpm add puppeteer@19.7.0 -w
        apt-get update
        apt-get install ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils -y
    elif [ $num == 4 ];then
        cd root/Miao-Yunzai
        git checkout . && git pull
        pnpm config set registry https://registry.npmmirror.com && pnpm config set puppeteer_download_host=https://registry.npmmirror.com && pnpm i
        pnpm add puppeteer@19.7.0 -w
        apt-get install ca-certificates fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgbm1 libgcc1 libglib2.0-0 libgtk-3-0 libnspr4 libnss3 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 lsb-release wget xdg-utils -y
        echo 记住了，你的系统版本是ubuntu18.04
        sleep 1.5s
    elif [ $num == 0 ];then
        RepaireList
	    RepaireNum
    else
        figlet ???
        echo 输个数字都不会输？
        echo
        echo 蔡
        sleep 3s
        puppeteer-repaire
    fi
    echo 已尝试进行修复
    sleep 1.5s
}

#进行一次报错修复列表的运行
if [ -e /root/Miao-Yunzai ]; then
RepaireList
RepaireNum
else
echo 未检查到喵崽，无需进行报错修复
sleep 1.5s
Mz
MzNum
fi

}

#重新配置机器人QQ
function Reconfig()
{
    redis-server --daemonize yes --save 900 1 --save 300 10
    cd /root/Miao-Yunzai && pnpm run login
}

#编译安装python3.10
function PythonInstall()
{
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 3s
    cd ~
    #安装依赖
    apt update
    apt install git build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget make libbz2-dev -y
    #从仓库克隆python3.10包
    git clone --depth=1 https://gitee.com/fw-cn/Yunzai-Bot-Python3.10.0
    cp /root/Yunzai-Bot-Python3.10.0/Python-3.10.0.tgz /home/
    rm -rf Yunzai-Bot-Python3.10.0
    cd /home/
    #解压
    tar -zxvf Python-3.10.0.tgz
    cd Python-3.10.0
    ./configure --enable-optimizations
    make
    make install
    rm -rf Python-3.10.0.tgz
    #软链接
    ln -sf /usr/local/bin/python3 /usr/bin/python
    ln -sf /usr/local/bin/pip3 /usr/bin/pip
    echo 'python3.10安装完成'
    echo -e 你当前的默认python版本是$(python --version)
    sleep 1.5s
	Mz
	MzNum
}

#安装ffmpeg
function FfmpegInstall()
{
    clear
	echo -e '正在准备安装ffmpeg……'
    sleep 0.5s
    echo -e '正在准备安装ffmpeg……'
    sleep 0.5s
    echo -e '正在准备安装ffmpeg……'
	sleep 3s
    if ! type git >/dev/null 2>&1; then
        apt update && apt install git -y
    fi
    git clone --depth=1 https://gitee.com/fw-cn/yunzai-ffmpeg
    if [ $(uname -m) == "aarch64" ]; then
        cp /root/yunzai-ffmpeg/arm.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf arm.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf arm.tar.gz
    elif [ $(uname -m) == "x86_64" ]; then
        cp /root/yunzai-ffmpeg/amd.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf amd.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf amd.tar.gz
    fi
    #软链接
    ln -sf /home/ffmpeg5.1.1/ffmpeg /usr/local/bin/ffmpeg
    ln -sf /home/ffmpeg5.1.1/ffprobe /usr/local/bin/ffprobe
    echo 'ffmpeg安装完成'
    echo -e 你当前的ffmpeg是：\\n$(ffmpeg -version)
    Mz
	MzNum
}

#更改主人QQ
function MasterQQ()
{
    cd /root/Miao-Yunzai/config/config
    read -p '请输入主人QQ：' yourmasterQQ
    sed -i '7d' other.yaml
    sed -i "/masterQQ:/ a\  - \\$yourmasterQQ" other.yaml
    sleep 1s
    echo '已修改主人QQ'
    sleep 1s
	Mz
	MzNum
}

#重新看一遍
function Review()
{
	clear
	echo '————————'
	echo
	echo '这里是所有快捷代码，一定要好好记住哦'
	echo
	echo '————————'
	echo
    echo -e "重新打开本脚本请输入：\033[47;31mcn\033[0m"
    echo -e "启动机器人请输入\033[47;31mmz\033[0m"
    echo -e "机器人后台启动运行（即不显示代码启动）请输入：\033[47;31mmzstart\033[0m"
    echo -e "显示机器人日志请输入：\033[47;31mmzlog\033[0m"
    echo -e "停止机器人后台运行请输入：\033[47;31mmzstop\033[0m"
    echo
    echo
    read -s -n1 -p "按任意键或直接回车以返回"
	Mz
	MzNum
}

#友情链接
function OtherLink()
{
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
	clear
	echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    figlet E a r t h - K
    echo -e '土块官网：\033[36mhttps://tukuai.one/\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    figlet t r s s . m e
    echo -e '时雨星空TRSS官网：\033[36mhttps://trss.me/\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    figlet Y X Y - Y X Y
    echo -e '云溪院个人主页：\033[36mhttps://gitee.com/yunxiyuan\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    read -s -n1 -p "按任意键或直接回车以返回 "
    Mz
	MzNum
}

function nodejs()
{
    echo -e '正在准备安装nvm~nodejs18，该步骤\033[31m可能需要10分钟\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装nvm~nodejs18，该步骤\033[31m可能需要10分钟\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装nvm~nodejs18，该步骤\033[31m可能需要10分钟\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 3s
    #安装依赖
	echo '即将开始安装依赖……'
	sleep 1s
 
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

    apt install update 
    
    nvm install 18
    
    nvm alias default 18

    npm install -g pnpm
    
    echo 'nodejs18安装完成'
    
    echo -e 你当前的默认nodejs版本是$(node --version)
    echo '请重启ubuntu再执行一次11号安装'
    echo echo 正在安装node > /usr/bin/mznvm
    sed -i -e '1a cd /root && nvm install 18 && nvm alias default 18' /usr/bin/mznvm
    chmod 777 /usr/bin/mznvm
    echo echo 正在安装nvm > /usr/bin/mznvmd
    sed -i -e '1a cd /root && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash' /usr/bin/mznvmd
    chmod 777 /usr/bin/mznvmd
    
    sleep 15.5s
	Mz
	MzNum
}

function Question()
{
    echo 还没写，咕咕咕
    sleep 3s
    Mz
    MzNum
}
if [ $(id -u) == 0 ];then
#脚本多处使用figlet，干脆直接检测一下装上得了
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
    Mz
	MzNum
else
    echo '当前运行环境不支持！'
    echo '手机用户请确保是否已安装并进入容器内，服务器用户请确保是否已切换root'
    echo '如果没有安装ubuntu请输入指令'
    echo 'curl -sL https://gitee.com/fw-cn/Yunzai/raw/master/u.sh | bash'
fi
