import { Banner, IndicatorType } from '@abner/banner'
import { ActionBar } from './ActionBar'
import router from '@ohos.router'

@Entry
@Component
struct Index {
  @Builder
  itemPage(index: number, item: Object) {
    Column() {
      Text("item" + index)
    }.backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .margin({ left: 20, right: 20 })
  }

  build() {
    Column() {
      ActionBar({ title: "普通轮播图", hiddenBack: true })
      Row() {
        Button("数据操作")
          .onClick(() => {
            router.pushUrl({ url: "pages/DataBannerPage" })
          })
        Button("懒加载")
          .onClick(() => {
            router.pushUrl({ url: "pages/LazyBannerPage" })
          })
      }.margin({ top: 10 })

      Scroll() {
        Column() {
          Banner({
            data: ["1", "2", "3", "4", "5", "6"],
            itemPage: this.itemPage,
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