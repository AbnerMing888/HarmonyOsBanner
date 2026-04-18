# HarmonyOsBanner
<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="100px" /><br/>
<span style="font-size:12px;color:red;">扫码关注，千帆起航，共筑鸿蒙！</span>
</p>

banner是一个基于系统Swiper而封装的一个轮播图，旨在简化代码，扩展相关功能，使用非常简单！

主要功能点如下

- 1、**支持轮播图左右缩放效果滑动**
- 2、**支持线条指示器**
- 3、**支持系统常见的圆点、圆柱、文字等指示器**
- 4、**支持懒加载数据便捷调用**
- 5、**支持堆叠形式轮播图**
- 6、**支持轮播图进度自动指示器（仿短视频图片轮播）**

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_24_730.png" width="200px" />
</p>

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_003.jpg" width="300px" />
</p>

### 堆叠轮播图

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_001.gif" width="300px" />
</p>

### 进度自动指示器

<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_002.gif" width="300px" />
</p>

## 支持Api

Api版本：**>=12**


## 快速使用

目前有多种使用方式，比如远程依赖、本地静态共享包依赖,源码方式依赖，推荐使用**远程依赖**，方便快捷，有最新修改可以及时生效。

### 1、依赖方式使用

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

```
ohpm install @abner/banner
```

方式二：在需要的模块中的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/banner": "^1.0.7"}
```

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_001.jpg" width="300"></p>


### 2、查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个oh_modules文件，并创建源代码文件，有则成功，无则失败，如下：

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_003.jpg" width="300"></p>

## 基本使用

### 1、中间放大，两边缩小效果

测试视图

```typescript
@Builder
itemMarginPage(index: number, item: Object) {
  Column() {
    Text("item" + index)
  }
  .width("100%")
    .height("100%")
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
}
```

组件使用

```typescript

Banner({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: this.itemMarginPage,//子组件视图
  nextMargin: 20,
  prevMargin: 20,
  itemSpace: 10, //子组件之间的边距
  isLeftRightScale: true,//左右是否放大
  onChange: (position) => {
    console.log("=========" + position)
  }
})
```

### 2、堆叠轮播图

```typescript
BannerStack({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: (index: number, item: Object) => {
    this.itemStackPage(index, item)
  },
  onChange: (position) => {
    console.log("=========" + position)
  },
})
```

### 3、普通轮播图

```typescript
 Banner({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: this.itemPage,
  onChange: (position) => {
    console.log("=========" + position)
  }
})
```

### 4、指示器在底部

测试视图

```typescript
@Builder
  bottomItemPage(index: number, _: Object) {
    Column() {
      Column() {
        Text("item" + index)
      }
      .backgroundColor(Color.Pink)
      .justifyContent(FlexAlign.Center)
      .borderRadius(10)
      .width("100%")
      .height(120)

      Column().height(30)
    }.margin({ left: 20, right: 20 })
  }
```

组件使用

```typescript
 Banner({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: this.bottomItemPage,
  bannerHeight: 150,
  onChange: (position) => {
    console.log("=========" + position)
  }
})
```

### 5、圆点指示器

```typescript
 Banner({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: this.itemPage,
  onChange: (position) => {
    console.log("=========" + position)
  },
  indicator: new DotIndicator()
    .itemWidth(8)
    .itemHeight(8)
    .selectedItemWidth(8)
    .selectedItemHeight(8)
    .color(Color.Gray)
    .selectedColor(Color.Blue),
})
```

### 6、数字指示器

```typescript
  Banner({
  data: ["1", "2", "3", "4", "5", "6"],
  itemPage: this.itemPage,
  onChange: (position) => {
    console.log("=========" + position)
  },
  indicator: Indicator.digit()// 设置数字导航点样式
    .right("43%")
    .top(200)
    .fontColor(Color.Gray)
    .selectedFontColor(Color.Gray)
    .digitFont({ size: 16, weight: FontWeight.Bold })
    .selectedDigitFont({ size: 16, weight: FontWeight.Normal })
})
```
### 7、线条指示器

```typescript
Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.itemPage,
            isLineIndicator: true,
            showLineIndicator: true,
            onChange: (position) => {
              console.log("=========" + position)
            },
            lineMargin: { bottom: 10 },
          }).margin({ top: 20 })
```

### 8、进度自动指示器（防短视频图片轮播）

```typescript
@Component
export struct BannerProgressPage {
  swiperController: SwiperController = new SwiperController()
  @State isBannerScroll: boolean = false
  @State currentIndex: number = 0
  @State bannerData: ResourceStr[] = [
    $r("app.media.banner_001"),
    $r("app.media.banner_002"),
    $r("app.media.banner_003")
  ]

  @Builder
  itemPage(index: number, item: ResourceStr) {
    Image(item)
      .width("100%")
  }

  build() {
    RelativeContainer() {
      Banner({
        data: this.bannerData,
        indicator: false, //去掉自带的指示器
        swiperController: this.swiperController,
        onBannerScroll: (isStart) => {
          //是否滑动了
          this.isBannerScroll = isStart
        },
        onChange: (index) => {
          this.currentIndex = index
        },
        itemPage: (index: number, item: Object) => {
          this.itemPage(index, item as ResourceStr)
        }
      })
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      BannerProgressIndicator({
        progressSize: this.bannerData.length,
        progressWidth: "30%",
        isBannerScroll: this.isBannerScroll,
        currentIndex: this.currentIndex,
        onChange: () => {
          this.swiperController.showNext()
        }
      })
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        }).margin({ bottom: 100 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Black)
  }
}
```

### 8、相关属性

| 属性                   | 类型                                             | 概述                             |
|----------------------|------------------------------------------------|--------------------------------|
| data                 | Array<Object>                                  | 数据源                            |
| itemPage             | 回调方法BuilderParam (index: number, item: Object) | tab对应的页面                       |
| onChange             | 回调方法(position: number)                         | 页面改变监听                         |
| bannerHeight         | Length                                         | banner高度                       |
| bannerWidth          | Length                                         | banner宽度                       |
| autoPlay             | boolean                                        | 是否自动播放，默认false                 |
| interval             | number                                         | 轮播时间，默认3秒轮播一次                  |
| disableSwipe         | boolean                                        | 是否禁止滑动，默认fasle                 |
| itemSpace            | number                                         | 子组件之间的间隙                       |
| currentIndex         | number                                         | 索引                             |
| indicator            | DotIndicator / DigitIndicator/ boolean         | 指示器                            |
| isLineIndicator      | boolean                                        | 是否是自定义的线条指示器                   |
| indicatorType        | IndicatorType                                  | 设置线条指示器时的位置，默认底部居中             |
| lineIndicatorWidth   | number                                         | 设置线条指示器时的线条宽度                  |
| lineIndicatorHeight  | number                                         | 设置线条指示器时的线条高度                  |
| lineIndicatorBgColor | ResourceColor                                  | 设置线条指示器时的背景                    |
| lineMargin           | Margin / Length                                | 设置线条指示器时的线条边距                  |
| isLoop               | boolean                                        | 是否开启循环,默认是循环                   |
| customIndicator      | BuilderParam(index: number, item: Object)      | 自定义轮播指示器                       |
| dataSource           | BannerDataSource                               | 是否使用数据懒加载，设置即为懒加载，默认为undefined |
| lazyCachedCount      | number                                         | 默认懒加载缓存数量                      |
| dataController       | DataController                                 | 普通数据操作控制器，和懒加载二者选其一            |
| prevMargin           | Length                                         | 前边距，用于露出前一项的一小部分               |
| nextMargin           | Length                                         | 后边距，用于露出后一项的一小部分               |
| isLeftRightScale     | boolean                                        | 左右是否缩放                         |
| maxScale             | number                                         | 设置左右缩放时，最大放大系数，默认为1            |
| minScale             | number                                         | 设置左右缩放时，最小缩放系数，默认为0.8          |
| onBannerScroll       | (isStart: boolean) => void = undefined         | 监听滑动状态                         |

### 9、堆叠轮播图属性


| 属性                | 类型                                             | 概述                  |
|-------------------|------------------------------------------------|---------------------|
| data              | Array<Object>                                  | 数据源                 |
| itemPage          | 回调方法BuilderParam (index: number, item: Object) | tab对应的页面            |
| onChange          | 回调方法(position: number)                         | 页面改变监听              |
| bannerHeight      | Length                                         | banner高度            |
| bannerWidth       | Length                                         | banner宽度            |
| autoPlay          | boolean                                        | 是否自动播放，默认false      |
| interval          | number                                         | 轮播时间，默认3秒轮播一次       |
| onChange          | 回调方法(position: number)                         | 页面改变监听              |
| maxScale          | number                                         | 最大缩放系数，默认为1，最顶部视图   |
| minScale          | number                                         | 最小缩放系数，默认为0.8，最底部视图 |
| middleScale       | number                                         | 中间缩放系数，默认为0.9，中间视图  |
| maxOffset         | number                                         | 最大偏移量，默认为20，最顶部视图   |
| minOffset         | number                                         | 最小偏移量，默认为0，最底部视图    |
| middleOffset      | number                                         | 中间偏移量，默认为10，中间视图    |
| animationDuration | number                                         | 动画时长                |
| paddingLeft       | number                                         | 内边距距离左边             |
| paddingRight      | number                                         | 内边距距离右边             |

### 10、轮播图数据操作（增删改查）

【Demo案例可直接查看DataBannerPage和LazyBannerPage两个页面】

无论是懒加载数据方式还是普通加载方式，均提供了数据之间的操作，普通数据直接可以针对传递的数组进行操作，需要自己拿到
数组，直接对数组更改即可，懒加载方式需要获取BannerDataSource，进行数据操作。

新的语言，对于一些小伙伴而言，在系统Api数据操作上可能略有阻碍，为了更好，更便捷的让大家使用，自1.0.1版本之后，对懒加载数据和普通数据做了优化和拓展。

大家只关注两个类即可，普通数据列表使用DataController，懒加载数据列表继续使用BannerDataSource。

#### 普通数据列表操作

定义DataController全局变量，并传入轮播组件。

```typescripty

dataController: DataController = new DataController() //数据控制器

Banner({
        dataController: this.dataController,
        itemPage: this.itemPage,
        onChange: (position) => {
          //页面滑动监听
        }
      })
      
```

相关方法如下,支持任意类型数据，如下我定义的是number

```typescript
//初始化数据
this.dataController.init()
 //增加一个数据
 this.dataController.add(100)
//指定位置增加一个数据
this.dataController.addPosition(2, 999)
//数组添加
 this.dataController.addArray([200, 300, 400])
 //可变参数形式添加
this.dataController.addVariable(600, 700)
//删除第一个
this.dataController.deleteFirst()
//删除最后一个
this.dataController.deleteLast()
//删除指定一个
this.dataController.deleteData(2)
//删除全部
this.dataController.deleteAll()
//修改某一条数据
this.dataController.change(6, 1000)
```

##### DataController方法介绍


| 方法          | 参数                               | 概述                    |
|-------------|----------------------------------|-----------------------|
| add         | (item: Object )                  | 可传递任意类型，用于添加单条数据      |
| addPosition | (position: number, item: Object) | 指定位置添加数据              |
| addVariable | (...items: Object[])             | 添加可变参数数据              |
| addArray    | items: Object[]                  | 添加数组                  |
| deleteFirst | 无参                               | 删除第一条数据               |
| deleteLast  | 无参                               | 删除最后一条数据              |
| deleteData  | (position: number)               | 删除一条数据                |
| deleteAll   | 无参                               | 删除全部数据                |
| changeData  | (position: number, item: Object) | 修改数据                  |
| getDataAll  | 无参                               | 返回所有的数据 （返回值Object[]） |
| getData     | (index: number)                  | 返回某一条数据               |
| totalCount  | 无参                               | 返回数据数量（返回值number      |


#### 懒加载数据列表操作

定义BannerDataSource全局变量，并传入轮播组件之中。


```typescript
dataSource: BannerDataSource = new BannerDataSource() //数据懒加载操作对象，执行数据增删改查

Banner({
  itemPage: this.itemPage,
  dataSource: this.dataSource,
  onChange: (position) => {
    //页面改变
  }
})

```

相关方法如下：

```typescript
//增加一个
this.dataSource.pushData(100)
//指定位置增加一个
this.dataSource.pushDataPosition(2, 200)
//数组添加
this.dataSource.pushDataArray([300, 301, 302])
 //可变参数形式添加
this.dataSource.pushDataVariable(400, 401, 402)
 //删除第一个
this.dataSource.deleteFirst()
 //删除最后一个
this.dataSource.deleteLast()
//删除指定一个
this.dataSource.deleteData(2)
 //删除全部
this.dataSource.deleteAll()
//修改数据
this.dataSource.changeData(3, 9999)
```

##### BannerDataSource方法介绍


| 方法               | 参数                               | 概述                    |
|------------------|----------------------------------|-----------------------|
| pushData         | (item: Object )                  | 可传递任意类型，用于添加单条数据      |
| pushDataPosition | (position: number, item: Object) | 指定位置添加数据              |
| pushDataVariable | (...items: Object[])             | 添加可变参数数据              |
| pushDataArray    | items: Object[]                  | 添加数组                  |
| deleteFirst      | 无参                               | 删除第一条数据               |
| deleteLast       | 无参                               | 删除最后一条数据              |
| deleteData       | (position: number)               | 删除一条数据                |
| deleteAll        | 回调接口                             | 参数可选，删除全部数据           |
| changeData       | (position: number, item: Object) | 修改数据                  |
| getDataAll       | 无参                               | 返回所有的数据 （返回值Object[]） |
| getData          | (index: number)                  | 返回某一条数据               |
| totalCount       | 无参                               | 返回数据数量（返回值number      |


## 更多案例

可以查看相关Demo【右侧仓库地址】。

## 关注公众号

鸿蒙先驱者，只分享精华的鸿蒙或者移动端技术文章，可微信扫码关注

<p><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/abner.jpg" width="150px" /></p>

[鸿蒙精华技术文章列表](https://juejin.cn/column/7269566781248389178)

## License

```
Copyright (C) AbnerMing, HarmonyOsBanner Open Source Project

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
