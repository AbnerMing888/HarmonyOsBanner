# HarmonyOsBanner

<p align="center">此项目不在giee维护，于2024年5月24日转移至github，请注意！</p>
<p align="center">此项目不在giee维护，于2024年5月24日转移至github，请注意！！</p>
<p align="center">此项目不在giee维护，于2024年5月24日转移至github，请注意！！！</p>
<p align="center"><a href="https://github.com/AbnerMing888/HarmonyOsBanner">github地址</a></p>


HarmonyOsBanner是一个基于系统Api的Swiper而封装的一个轮播图，旨在简化代码，扩展相关功能。


<p align="center">
<img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_01.jpeg" width="200px" />
</p>

## 开发环境

DevEco Studio NEXT Developer Preview1,Build Version: 4.1.3.500

Api版本：**11**

hvigorVersion：4.0.2

## 快速使用

目前有多种使用方式，比如远程依赖、本地静态共享包依赖,源码方式依赖，推荐使用**远程依赖**，方便快捷，有最新修改可以及时生效。

### 1、远程依赖方式使用【推荐】

方式一：在Terminal窗口中，执行如下命令安装三方包，DevEco Studio会自动在工程的oh-package.json5中自动添加三方包依赖。

```
ohpm install @abner/banner
```

方式二：在工程的oh-package.json5中设置三方包依赖，配置示例如下：

```
"dependencies": { "@abner/banner": "^1.0.0"}
```

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_001.jpg" width="300"></p>

### 2、本地静态共享包har包使用

<p>首先，下载har包，<a href="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner-1.0.0.har">点击下载</a></p>
<p>下载之后，把har包复制项目中，目录自己创建，如下，我创建了一个libs目录，复制进去</p>
<p><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_002.jpg"></p>
<p>引入之后，进行同步项目，点击Sync Now即可，当然了你也可以，将鼠标放置在报错处会出现提示，在提示框中点击Run 'ohpm install'。</p>
<p>需要注意，<strong>@abner/banner</strong>，是用来区分目录的，可以自己定义，比如@aa/bb等，关于静态共享包的创建和使用，请查看如下我的介绍，这里就不过多介绍</p>

[HarmonyOS开发：走进静态共享包的依赖与使用](https://juejin.cn/post/7274982412245876776)

### 3、查看是否引用成功

无论使用哪种方式进行依赖，最终都会在使用的模块中，生成一个oh_modules文件，并创建源代码文件，有则成功，无则失败，如下：

<p align="center"><img src="https://vipandroid-image.oss-cn-beijing.aliyuncs.com/harmony/banner/banner_243_003.jpg" width="300"></p>

## 基本使用

### 1、普通使用

```typescript
Banner({
          data: ["1", "2", "3", "4", "5", "6"],
          itemPage: this.itemPage,
          onChange: (position) => {
            console.log("=========" + position)
          }
        }).margin({ top: 20 })
```

### 2、圆点指示器

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
        }).margin({ top: 20 })
```

### 3、文字指示器

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
        }).margin({ top: 20 })
```

### 4、线条指示器

```typescript
Banner({
          data: ["1", "2", "3", "4", "5", "6"],
          itemPage: this.itemPage,
          isLineIndicator: true,
          lineMargin: { bottom: 10, left: 10 },
          indicatorType: IndicatorType.bottomCenter,
          onChange: (position) => {
            console.log("=========" + position)
          }
        }).margin({ top: 20 })
```

### itemPage

```typescript
  @Builder
  itemPage(index: number, item: BannerData) {
    Column() {
      Text("item" + index)
    }.backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .margin({ left: 20, right: 20 })
  }
```
### 相关属性

| 属性                   | 类型                                                 | 概述             |
|----------------------|----------------------------------------------------|----------------|
| data                 | Array<BannerData>                                  | 数据源            |
| itemPage             | 回调方法BuilderParam (index: number, item: BannerData) | tab对应的页面       |
| onChange             | 回调方法(position: number)                             | 页面改变           |
| bannerHeight         | Length                                             | banner高度       |
| bannerWidth          | Length                                             | banner宽度       |
| autoPlay             | boolean                                            | 是否自动播放，默认false |
| interval             | number                                             | 默认3秒轮播一次       |
| disableSwipe         | boolean                                            | 是否禁止滑动         |
| itemSpace            | number                                             | 子组件之间的间隙       |
| currentIndex         | number                                             | 索引             |
| indicator            | DotIndicator / DigitIndicator/ boolean             | 指示器            |
| isLineIndicator      | boolean                                            | 是否是自定义的线条指示器   |
| indicatorType        | IndicatorType                                      | 默认底部居中         |
| lineIndicatorWidth   | number                                             | 线条宽度           |
| lineIndicatorHeight  | number                                             | 线条高度           |
| lineIndicatorBgColor | ResourceColor                                      | 指示器背景          |
| lineMargin           | Margin / Length                                    | 线条边距           |
| isLoop               | boolean                                            | 是否开启循环,默认是循环   |

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
