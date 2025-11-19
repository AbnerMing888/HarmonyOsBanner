import { Banner, DataController } from '@abner/banner/Index';
import { ActionBar } from './ActionBar';

@Entry
@Component
struct DataBannerPage {
  private dataController: DataController = new DataController()
  @State private items: number[] = [1, 2, 3, 4, 5, 6]

  aboutToAppear(): void {
    this.dataController.init(this.items) //初始化数据
  }

  @Builder
  itemPage(index: number, item: Object) {
    Column() {
      Text(item.toString())
    }.backgroundColor(Color.Pink)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .margin({ left: 20, right: 20 })
  }

  build() {
    Column() {
      ActionBar({ title: "普通轮播图数据操作" })
      Banner({
        dataController: this.dataController,
        itemPage: this.itemPage,
        onChange: (position) => {
          //页面滑动监听
        }
      }).margin({ top: 20 })

      Row() {
        Button("添加").onClick(() => {
          this.dataController.add(100)
        })
        Button("删除").onClick(() => {
          this.dataController.deleteLast()
        })
        Button("删除指定").onClick(() => {
          this.dataController.deleteData(2)
        })
        Button("改变").onClick(() => {
          this.dataController.changeData(0, 1000)
        })
      }.margin({ top: 10 })
    }
  }
}