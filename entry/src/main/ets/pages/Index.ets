import { Banner, IndicatorType } from '@abner/banner'
import { ActionBar } from './ActionBar'

@Entry
@Component
struct Index {
  @Builder
  itemPage(index: number, item: Object) {
    Column() {
      Text("item" + index)
    }
    .backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .width("100%")
    .height("100%")
    .margin({ left: 20, right: 20 })
  }

  @Builder
  bottomItemPage(index: number, item: Object) {
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

  @State selectPosition: number = 0

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

  build() {
    Column() {
      ActionBar({ title: "轮播图", hiddenBack: true, hiddenRight: false })
      Scroll() {
        Column() {
          // 左右显示，两边缩小，滑动到中间变大
          Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.itemMarginPage,
            nextMargin: 20,
            prevMargin: 20,
            itemSpace: 10, //子组件边距
            isLeftRightScale: true,
            onChange: (position) => {
              this.selectPosition = position
              console.log("=========" + position)
            }
          }).margin({ top: 20 })

          //普通加载
          Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.itemPage,
            onChange: (position) => {
              console.log("=========" + position)
            },
            onAnimationStart: (index: number, targetIndex: number) => {

            }
          }).margin({ top: 20 })

          // 指示器
          Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.bottomItemPage,
            bannerHeight: 150,
            onChange: (position) => {
              console.log("=========" + position)
            }
          }).margin({ top: 20 })

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

          Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.itemPage,
            isLineIndicator: true,
            lineMargin: { bottom: 10, left: 30 },
            indicatorType: IndicatorType.bottomLeft,
            onChange: (position) => {
              console.log("=========" + position)
            }
          }).margin({ top: 20 })
        }
      }.padding({ bottom: 90 })
    }
  }
}