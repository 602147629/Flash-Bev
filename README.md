### 一、Flex-Bev框架简介

SuperMap Flex Bev是基于SuperMap iClient for Flex产品开发的一套支持用户自定义扩展功能集成显示框架，该框架具备可定制，可装卸，配置方便，界面美等特点，主要面向二次开发用户以及快速制作原型系统的人员。
![b17eca8065380cd7065146c3a044ad3459828155](http://h.hiphotos.baidu.com/album/s%3D1100%3Bq%3D90/sign=ecfb4f4f0eb30f24319ae802f8a5ea32/b17eca8065380cd7065146c3a044ad3459828155.jpg)
演示地址：http://support.supermap.com.cn:8090/DemoCenter/SuperMap.iClient.Flex.Sample/FlexBev2/index.html

### 二、产品定位

1.快速搭建WebGIS项目应用。

2.针对复杂的项目应用能提供灵活便利的底层逻辑，便于上层应用的扩展增强。

### 三、产品特点

1.基于配置的组件生成

  通过XML节点的形式，按照插件通信规则来建立节点，程序启动后会自动实例化插件。

2.可浮动停靠的组件管理容器

  插件一般放置在组件管理容器---面板中。面板按照标签页---插件的方式进行管理。下图则展示了一个包含有四个标签页的面板。
  ![6d81800a19d8bc3e6400e4e4838ba61ea8d34590](http://f.hiphotos.baidu.com/album/s%3D1100%3Bq%3D90/sign=c4ea7ef28b13632711edc632a1bf9b9d/6d81800a19d8bc3e6400e4e4838ba61ea8d34590.jpg)
  
  上述面板中的标签页区域支持拖拽，停靠，锁定等操作。
  
3.灵活易用的插件机制

  框架里的浮动面板FloatPanel用来承载业务逻辑组件，业务逻辑容器使用插件机制管理内部各个组件。如添加，移除，事件传递等常规操作。
  
4.基于标签式的属性注入

  框架本身支持元数据标签Inject属性注入方式来定制开发。目前主要是针对基础组件(BaseComponent)与命令(Command)的属性注入。
  Inject属性注入的使用方式比较简便，在常规的变量声明上添加Inject元数据标签即可。如下面两行代码便是Inject属性注入的使用示例。
  [Inject]  
  public var qContainer:QueryContainer;

5.事件总线

  框架本身还提供了一种集中处理事件监听与回调的机制——事件总线。它对应的主要逻辑对象是EventBus(BaseEventDispatcher)。
  在实现IPlugin接口的组件中，直接用EventBus即可。
  对于框架之外的组件，可以使用BaseEventDipatcher.getInstance()来达到同样的效果。

6.兼容Flex Cairngrom框架内核

  框架内部已经集成了对Command(命令部分)的兼容处理，而Control(控制部分)也通过EventBus(事件总线)得以实现，熟悉这个特性的读者会很快熟悉SuperMap Flex Bev框架。

7.Module模块以及可切换的统一模板

  Module是为了减小项目编译体积而使用的一种优化方案，该方案是为了设计出来相对独立的功能逻辑，然后编译为独立的SWF文件，当项目程序需要这部分功能时动态进行加载或卸载。通过这种方式可以优化程序结构，减少网络负载，改善用户体验。
  框架本身提供了BaseGear类(com.supermap.framework.components.BaseGear)与BaseTemplate类(com.supermap.framework.components.BaseTemplate)来实现单一的模块类以及具备统一样式的模板皮肤类。

### 四、主要功能

1.提供针对SuperMap CloudLayer云服务图层数据的查询插件(可选组件，预先不加载)
  ![6d81800a19d8bc3e6400e4e4838ba61ea8d34590](http://f.hiphotos.baidu.com/album/s%3D1100%3Bq%3D90/sign=c4ea7ef28b13632711edc632a1bf9b9d/6d81800a19d8bc3e6400e4e4838ba61ea8d34590.jpg)
  
2.提供书签，要素标绘插件(可选组件，预先加载)

3.提供常用的打印插件(可选组件，预先加载)
![4bed2e738bd4b31cc772709586d6277f9e2ff856](http://a.hiphotos.baidu.com/album/s%3D1100%3Bq%3D90/sign=8e684c08fcfaaf5180e385bebc64af9f/4bed2e738bd4b31cc772709586d6277f9e2ff856.jpg)
 
4.提供地图导航条等功能插件(可选组件，预先加载)

5.微博接口与地图功能整合（实现中，后续提供）
![d31b0ef41bd5ad6ed91580c480cb39dbb6fd3c2b](http://e.hiphotos.baidu.com/album/s%3D1100%3Bq%3D90/sign=21fc05342934349b70066a84f9da2ebf/d31b0ef41bd5ad6ed91580c480cb39dbb6fd3c2b.jpg)


### 五、使用说明

1.Flex-Bev工程下载后解压后得到Flex-Bev项目源代码，可直接导入到Flash Builder里编译运行。更加详细的使用步骤说明请参见"FlexBev2用户指导手册.pdf"。
2.Flex-Bev工程里依赖的Flex-Bev-Lib库项目也是开源项目。需要深度定制框架可参考Flex-Bev-Lib库代码。
  Flex-Bev-Lib开源项目：https://github.com/SuperMap/Flex-Bev-Lib/

### 六、技术支持与服务

**电话支持服务：**

技术支持与客户监督热线：400-8900-866

**在线支持服务：**


BBS在线网址：http://www.gisforum.net

公 司 网 址 ：http://www.supermap.com.cn

**电子邮件支持服务：**

如果您对公司的产品有什么问题，可以直接发到我们的技术支持电子邮箱里，我们会及时收取您的信件，并尽快解决您的问题。

技术支持电子邮箱：support@supermap.com

如果您有投诉或建议，可以直接发到我们的客户监督电子邮箱里，我们会及时收取您的信件，并尽快解决您的问题。

客户监督电子邮箱：cs@supermap.com

**信件支持服务：**

公司地址：北京市朝阳区酒仙桥北路甲10号院201号楼E门3层

邮政编码：100015

**其他支持服务：**

如果您有一些特别的需求，我们也可以提供一些特别的支持方式，例如：提供例程来实现一些功能需求。


我们真心希望支持服务能够给您带来更高的工作效率。

我们的服务宗旨就是专业、及时、真诚、周到的支持服务，尽我们最大的努力让用户满意，您的满意是我们最大的欣慰。

