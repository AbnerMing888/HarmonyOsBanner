import { Banner, BannerDataSource } from '@abner/banner/Index';
import { ActionBar } from './ActionBar';

@Entry
@Component
struct LazyBannerPage {
  private dataSource: BannerDataSource = new BannerDataSource()
  @State private items: number[] = [1, 2, 3, 4, 5, 6]

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
      ActionBar({ title: "懒加载轮播图" })
      Banner({
        data: this.items,
        itemPage: this.itemPage,
        isLazyData: true,
        onLazyDataSource: (dataSource: BannerDataSource) => {
          this.dataSource = dataSource
        },
        onChange: (position) => {
          //页面改变
        }
      }).margin({ top: 20 })

      Row() {
        Button("添加").onClick(() => {
          this.dataSource.pushData(100)
        })
        Button("删除").onClick(() => {
          this.dataSource.deleteLast()
        })
        Button("删除指定").onClick(() => {
          this.dataSource.deleteData(2)
        })
        Button("改变数据").onClick(() => {
          this.dataSource.changeData(0, 1000)
        })
      }.margin({ top: 10 })
    }
  }
}