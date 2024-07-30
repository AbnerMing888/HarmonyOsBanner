/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:页面Title
 * */
import router from '@ohos.router'

@Component
export struct ActionBar {
  @State title: string = "标题"
  @State hiddenBack: boolean = false
  @State hiddenRight: boolean = true

  build() {
    Stack() {
      Row() {
        Text(this.title)
          .fontColor(Color.White)
          .fontSize(16)
      }.width("100%")
      .justifyContent(FlexAlign.Center)

      Text("返回")
        .visibility(this.hiddenBack ? Visibility.Hidden : Visibility.Visible)
        .fontColor(Color.White)
        .align(Alignment.Center)
        .textAlign(TextAlign.Center)
        .alignSelf(ItemAlign.Center)
        .margin({ left: 10 })
        .fontSize(14)
        .onClick(() => {
          //销毁
          router.back()
        })

      Row() {
        Text("普通加载")
          .fontColor(Color.White)
          .fontSize(16)
          .onClick(() => {
            router.pushUrl({ url: "pages/DataBannerPage" })
          })
        Text("懒加载")
          .fontColor(Color.White)
          .fontSize(16)
          .margin({ left: 10, right: 10 })
          .onClick(() => {
            router.pushUrl({ url: "pages/LazyBannerPage" })
          })
      }.width("100%")
      .justifyContent(FlexAlign.End)
      .visibility(this.hiddenRight ? Visibility.Hidden : Visibility.Visible)
    }.height(44)
    .width("100%")
    .backgroundColor("#ff0000")
    .alignContent(Alignment.Start)
  }
}
