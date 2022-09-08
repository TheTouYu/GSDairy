# 这个是7月中旬在家里的记录。

### 比较遗憾，华为的备忘录不可以批量导出。简要 介绍一下利用adb自动脚本 操作

- 打开开发者模式
  
  1. 手机关于 > 版本号多点几下 > 搜索usb调试 > 开启调试，顺便把底下**指针位置**也打开
  
  2. 电脑上安装adb驱动。windows自行百度;linux用户安装**android-tools**软件包
  
  3. 如果一切顺利，在终端(windows是cmd命令行)输入
     
     ```bash
     adb devices #应该可以看到你的设备。
     # 请注意usb连接电脑时选择'传输文件'
     adb shell # 如果可以进入手机shell说明ok
     adb tcpip 5555 #可选操作，解决华为手机没有无线调试的问题
     # 配合termux(手机linux终端模拟器)安装android-tools
     # 可以在手机上使用adb自动化,十分awsome
     ```
  
  4. 编写bash脚本，记录位置，设计点击逻辑
     
     推荐安装**scrcpy**显示并控制你的手机，这里我用来方便点击和记录坐标
     
     > 750 500  列表坐标
     > 
     > 1000 500
     > 
     > ...
     > 
     > 2000 500 到底了划一下把 坐标变为750,如此循环
     > 
     >  
     > 
     > 187 2305 分享
     > 
     > 286  1907  选择类型
     > 
     > 286 1933
     > 
     > 91 167 返回
     
     几条基本adb input 指令
     
     - adb shell input tap 255 345 #点击屏幕
     
     - adb shell input swipe 342 23 234 434 1000 #用1秒划过这两个点
     
     - adb shell input keyevent 23 #发送键盘事件，可以实现开关机呀，音量控制，锁屏扽等等快捷操作。我们用不到，有兴趣自行百度
     
     - 一下代码仅供参考。不同的手机，睡眠时间，分辨率和DPI，会有不同（坐标不同）  建议仅作为学习使用
       
       [adb.sh](adb.sh)
     
     ```bash
     x=500
     y=750
     
     cmd='adb shell input'
     S='sleep 1'
     function loop(){
             $S; $cmd tap 187 2305
             $S; $cmd tap 286 1907
             $S; $cmd tap 286 1933
             $S; $cmd tap 91 167
             sleep 2
     }
     
     for i in $(seq 1 20);do
             adb shell input tap $x $y
             let y+=250
     
             loop
     
     
             if [[ $y -eq 2000 ]];then
                     $cmd swipe $x $y $x 750 2000
                     y=750
             fi
     done
     ```
     
  5. 下边把刚刚的文件从手机导出并配置markdown
   
   - linux下（arch）我推荐android-file-transfer,因为它支持gui和cli
   
   - 通过这条命令批量转换成markdown引用格式
     
     ```bash
     ls *|sed -E 's/^(.*)$/[\1]("\1")/g' > list.md
     ```
   
   - ok, 同步一下
     
     ```bash
     git add *
     git commit -m '之前的日记配置'
       ```

### [点我查看](Old/list.md)       
       
     
     
