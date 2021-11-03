| 序号                             | 问题描述                                                     | 简答                                          | 备注                                                      |
| -------------------------------- | ------------------------------------------------------------ | --------------------------------------------- | --------------------------------------------------------- |
| 1                                | 发现在Qt5.12和5.15中都可以，但6.2不行![1](./pics/qtenv.png)  | 开发在Mac端是5.12 , Ubuntu部署在5.15          | 请确定Qt库版,所有qml依赖的主库版本号等                    |
| 2                                | .pro文件解读,这句有什么用? ![2](./pics/qtConfig.png)         | ----                                          | 添加到工程中用于编译吗？                                  |
|                                  |                                                              |                                               |                                                           |
| <font color=green >3</font>      | 设备管理 界面![3](./pics/setManger.png)                      | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=green >4</font>      | 为什么 qt creator老报这个错，可运行，注释掉还不行![4](./pics/qml_module_not_found.png) | <font color=green > **-已解决--** </font>     | -QML_IMPORT_PATH +=$$PWD/TaoQuick/imports/TaoQuick---     |
| <font color=green >5</font>      | 设备管理 界面![3](./pics/setManger.png)                      | **<font color=green > -已解决-- </font>**     | ----                                                      |
| <font color=green >6</font>      | 登录界面未全屏 1080P ![4](./pics/1080.png)                   | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=green >7</font>      | CusButton是一种什么类型 ![5](./pics/CusButton.png)           | <font color=green > **-已解决--** </font>     | 第三方控件，没有绑定Tab键功能                             |
| <font color=red >8</font>        | 查找无法输入中文，其它一输入就成加密形式![6](./pics/search.png) | ----                                          | ----                                                      |
| <font color=green >9</font>      | 切换有问题 ![8](./pics/switchissue.png)                      | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=green >10</font>     | -相机label有错位？-![9](./pics/camera.png)                   | <font color=green > **-已解决--** </font>     | ----                                                      |
| 11                               | -C++/QML调用关系澄清？-![10](./pics/qml_c++.png)--           | ----                                          | ----                                                      |
| <font color=green >12</font>     | -重复import, import 库后面加空格再带版本是qml特有语法吗？-![11](./pics/duplicateImport.png)-- | <font color=green > **-自行已解决--** </font> | ----                                                      |
| <font color=green >13</font>     | 点退出系统，弹不出登录框![12](./pics/exit.png)----           | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=orange>14</font>     | -Tao Common Quick 与QtQuick之间的关系？ 哪些是真正必须的对于本项目qml![13](./pics/TaoCommonQuick.png)--- | ----                                          | ----                                                      |
| <font color=green >15</font>     | -外部杂音code还在？-![13](./pics/nosiecode.png)--            | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=orange>16</font>     | --![14](./pics/todo.png)--                                   | ----                                          | 逻辑大部分正与云泽沟通                                    |
| <font color = orange > 17</font> | -敲回车，不跳转到下一输入框（无反应）-![15](./pics/enter.png)-- | ----                                          | ----                                                      |
| 18                               | -医生图标与字体不在同一水平线，可微调-![16](./pics/doctor.png)-- | ----                                          | ----                                                      |
| <font color = orange > 19</font> | -输入框无法输入中文字符-![17](./pics/input.png)--            | ----                                          | ----                                                      |
| <font color=green >20</font>     | -参数设置页面没有填满背景-![18](./pics/args.png)--           | <font color=green > **-已解决--** </font>     | ----                                                      |
| 21                               | -识别经络后-![19](./pics/identify.png)--                     | ----                                          | ----                                                      |
| <font color=green >22</font>     | -处方管理？背景无填满-![20](./pics/chufang.png)--            | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=green >23</font>     | -处方返回按钮无点无反应（其它条件不满足，应该不影响此按扭逻辑功能）-![21](./pics/chufangBack.png)-- | <font color=green > **-已解决--** </font>     | ----                                                      |
| <font color=green >24</font>     | -WebAssembly有什么作用？ 如何配置~-![21](./pics/WebAssembly.png)-- | <font color=green > **-none fix--** </font>   | ----                                                      |
| <font color=green >25</font>     | -登录按钮悬停效果没改-                                       | ![1](./pics/login.png)----                    | <font color=green > **-已解决--** </font>                 |
| <font color=red >26</font>       | -按回车键（登录图标区键盘）不自动登录--                      | --![1](./pics/login.png)---                   | ----                                                      |
| <font color = red > 27</font>    | -按Tab键不能在button间切换                                   | ---![1](./pics/buttonTab.png)--               | ----                                                      |
| <font color = green > 28</font>  | 开处方下所有的悬停按钮均未生效                               | <font color=green > **-已解决--** </font>     | ----                                                      |
| 29                               | 文字没对齐                                                   | -![1](./pics/buqi.png)----                    | ----                                                      |
| <font color=green > 30 </font>   | --双击生效改为单击--                                         | ![2](./pics/doubleclick.png) ----             | <font color=green > **-已解决--** </font>                 |
| 31                               | -经络名称背景图片设计未加入？                                | --![3](./pics/background.png) --              | ----                                                      |
| <font color=red >32</font>       | 开处方界面背景（透明）处按钮还可又点击，应该禁止             | -![3](./pics/treat.png) -                     | ----                                                      |
| <font color=red > 33 </font>     | 肾经（脾经等，点击一下添加两条的），删除时点一个也应全部删除。 | ![2](./pics/doubleclick.png) --------         |                                                           |
| <font color=red > 34 </font>     | 退出按钮未生效                                               | ![2](./pics/exitissue.png)                    | ----                                                      |
| <font color=red > 35 </font>     | 1. 选中的背景都标红，<br />2. 经络计划列表前加数字顺序标记（按设计的来） | ![2](./pics/add_number.png)                   | ----                                                      |
| <font color=red > 36 </font>     | 程序crashed闪退（复现规律不明）                              | ![](./pics/crashed.png)                       | ----                                                      |
| <font color=red > 37 </font>     | 动画演示界面不能伸缩填满全屏（有黑边）                       | ![](./pics/display.png)                       | ----                                                      |
| <font color=red > 38 </font>     | CusButton 下延不明显，是否可以整体上移一定间距               | ![](./pics/buttonTab.png)                     | ----                                                      |
| <font color=red > 39 </font>     | github repo 其它人的本地commit无法push（协同开发受阻）       | ----                                          | 建立公共三人都可以commit的repo,今天尝试了一下，任然未成功 |
| <font color=red >40 </font>      | UI 1.0  release 打包流程？ 哪些库是必须依赖，待澄清          | ----                                          | ----                                                      |
| ----                             | ----                                                         | ----                                          | ----                                                      |
|                                  |                                                              |                                               |                                                           |
|                                  |                                                              |                                               |                                                           |
|                                  |                                                              |                                               |                                                           |
|                                  |                                                              |                                               |                                                           |
