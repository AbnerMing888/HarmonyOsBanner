/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/23
 * INTRODUCE:自定义Banner
 * */
import { BannerDataSource } from './BannerDataSource'
import { DataController } from './DataController'
import { IndicatorType } from './IndicatorType'

@Component
export struct Banner {
  private _privateSwiperController: SwiperController = new SwiperController()
  @Prop @Watch("changeData") data: Array<Object> = [] //数据源
  @BuilderParam itemPage: (index: number, item: Object) => void //banner对应的页面
  onChange?: (position: number) => void
  bannerHeight: Length = 150 //banner高度
  bannerWidth: Length = "100%" //banner宽度
  autoPlay: boolean = false //是否自动播放，默认false
  interval: number = 3000 //默认3秒轮播一次
  disableSwipe: boolean = false //是否禁止滑动
  itemSpace: number = 0 //子组件之间的间隙
  @State currentIndex: number = 0 //默认选中第0个
  indicator: DotIndicator | DigitIndicator | boolean = true //指示器
  isLineIndicator: boolean = false //是否是自定义的线条指示器
  indicatorType: IndicatorType = IndicatorType.bottomCenter //默认底部居中
  lineIndicatorWidth: number = 100 //线条宽度
  lineIndicatorHeight: number = 5 //线条高度
  lineIndicatorBgColor: ResourceColor = Color.Black
  lineMargin: Margin | Length = 0 //线条边距
  isLoop: boolean = true //是否开启循环,默认是循环
  @BuilderParam customIndicator?: (index: number, item: Object) => void //自定义轮播指示器
  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:底部居中
   * */
  private privateIndicatorRules: Record<string, Record<string, string | VerticalAlign | HorizontalAlign>> = {}
  isLazyData: boolean = false //是否使用数据懒加载
  private _lazyData: BannerDataSource = new BannerDataSource() //懒加载数据
  lazyCachedCount: number = 1 //默认缓存数量
  onLazyDataSource?: (dataSource: BannerDataSource) => void
  dataController: DataController = new DataController() //数据控制器

  /*
 * Author:AbnerMing
 * Describe:数据发生了变化
 */
  changeData() {
    this.dataController.refreshArray(this.data)
  }

  aboutToAppear(): void {
    if (this.isLineIndicator || this.customIndicator != null) {
      this.indicator = false
    }

    if (this.isLazyData) {
      //懒加载数据
      this._lazyData.initData(this.data)
      this._lazyData.refreshArrayCallback((items: Array<Object>) => {
        this.data = items
      })
    }
    if (this.onLazyDataSource != null) {
      this.onLazyDataSource(this._lazyData)
    }

    //不是懒加载，进行数据操作
    if (!this.isLazyData && this.dataController != null) {
      this.dataController.init(this.data)
      this.dataController.refreshArrayCallback((items: Array<Object>) => {
        this.data = items
      })
    }

    switch (this.indicatorType) {
      case IndicatorType.topLeft: //左上
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start }
        }
        break
      case IndicatorType.topRight: //右上
        this.privateIndicatorRules = {
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End }
        }
        break
      case IndicatorType.topCenter: //上中
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End }
        }
        break
      case IndicatorType.center: //居中
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
          'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
      case IndicatorType.centerLeft: //居中左边
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
          'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
      case IndicatorType.centerRight: //居中右边
        this.privateIndicatorRules = {
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
          'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
      case IndicatorType.bottomCenter: //下居中
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
      case IndicatorType.bottomLeft: //下左
        this.privateIndicatorRules = {
          'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
      case IndicatorType.bottomRight: //下右
        this.privateIndicatorRules = {
          'right': { 'anchor': '__container__', 'align': HorizontalAlign.End },
          'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom }
        }
        break
    }
  }

  @Builder
  getSwiperItem() {
    //判断是否是懒加载
    if (this.isLazyData) {
      LazyForEach(this._lazyData, (item: Object, index: number) => {
        this.itemPage(index, item)
      }, (item: Object, index: number) => JSON.stringify(item) + "_" + index)
    } else {
      ForEach(this.data, (item: Object, index: number) => {
        this.itemPage(index, item)
      }, (item: Object, index: number) => JSON.stringify(item) + "_" + index)
    }
  }

  build() {
    RelativeContainer() {
      Swiper(this._privateSwiperController) {
        this.getSwiperItem()
      }
      .onChange((position) => {
        //当前位置
        this.currentIndex = position
        if (this.onChange != null) {
          this.onChange(position)
        }
      })
      .index(this.currentIndex)
      .height(this.bannerHeight)
      .width(this.bannerWidth)
      .autoPlay(this.autoPlay) //是否自动播放
      .interval(this.interval)
      .disableSwipe(this.disableSwipe)
      .itemSpace(this.itemSpace)
      .indicator(this.indicator)
      .nestedScroll(SwiperNestedScrollMode.SELF_FIRST)
      .loop(this.isLoop)
      .cachedCount(this.lazyCachedCount)
      .id("swiper")

      if (this.isLineIndicator) {
        //线条指示器
        Row() {
          ForEach(this.data, (_: Object, index: number) => {
            Line().width(this.lineIndicatorWidth / this.data.length)
              .height(this.lineIndicatorHeight)
              .backgroundColor(this.currentIndex == index ? Color.White : Color.Transparent)
          })
        }
        .width(this.lineIndicatorWidth)
        .height(this.lineIndicatorHeight)
        .backgroundColor(this.lineIndicatorBgColor)
        .id("line")
        .alignRules(this.privateIndicatorRules)
        .margin(this.lineMargin)
      }

    }
    .width('100%')
    .height(this.bannerHeight)
  }
}