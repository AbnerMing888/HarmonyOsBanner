/**
 * AUTHOR:AbnerMing
 * DATE:2024/2/23
 * INTRODUCE:懒加载数据
 * */
@Observed
export class BannerDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []
  private originDataArray: Object[] = []

  /*
  * Author:AbnerMing
  * Describe:初始化数据
  */
  initData(items: Array<Object>) {
    this.originDataArray = items
  }


  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回列表数量
   * */
  totalCount(): number {
    return this.originDataArray.length
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回所有的数据
   * */
  getDataAll(): Object[] {
    return this.originDataArray;
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回某一个对象
   * */
  getData(index: number): Object {
    return this.originDataArray[index]
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
   * */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener);
    }
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
   * */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1);
    }
  }

  // 通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  // 通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    })
  }

  // 通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    })
  }

  // 通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index)
    })

  }

  // 通知LazyForEach组件将from索引和to索引处的子组件进行交换
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    })
  }

  //初始化数据
  public addData(index: number, data: Object): void {
    this.originDataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  /*
  * Author:AbnerMing
  * Describe:添加一条数据
  */
  public pushData(data: Object): void {
    this.originDataArray.push(data)
    this.notifyDataAdd(this.originDataArray.length - 1)
  }

  /*
  * Author:AbnerMing
  * Describe:指定位置进行添加
  */
  public pushDataPosition(position: number, data: Object): void {
    this.originDataArray.splice(position, 0, data)
    this.notifyDataAdd(position)
  }

  /*
   * Author:AbnerMing
   * Describe:添加数组
   */
  public pushDataArray(data: Array<Object>): void {
    this.originDataArray = this.originDataArray.concat(data)
    this.notifyDataAdd(this.originDataArray.length - 1)
    if (this.refreshCallBack != undefined) {
      this.refreshCallBack(this.originDataArray)
    }
  }

  /*
   * Author:AbnerMing
   * Describe:可变参数添加
   */
  pushDataVariable(...items: Object[]) {
    this.originDataArray.push(...items)
    this.notifyDataAdd(this.originDataArray.length - 1)
  }

  /*
* Author:AbnerMing
* Describe:删除第一条数据
*/
  deleteFirst() {
    this.originDataArray.shift()
    this.notifyDataDelete(0)
  }

  /*
* Author:AbnerMing
* Describe:删除最后一条数据
*/
  deleteLast() {
    this.originDataArray.pop()
    this.notifyDataDelete(this.originDataArray.length)
  }


  /*
  * Author:AbnerMing
  * Describe:删除数据
  */
  public deleteData(index: number): void {
    this.originDataArray.splice(index, 1)
    this.notifyDataDelete(index)
  }

  /*
* Author:AbnerMing
* Describe:删除全部数据
*/
  deleteAll(callBack?: () => void) {
    this.originDataArray = []
    this.notifyDataDelete(this.originDataArray.length)
    if (this.refreshCallBack != undefined) {
      this.refreshCallBack(this.originDataArray)
    }
    //未查询到删除全部的回调监听，暂定100毫秒
    if (callBack != undefined) {
      setTimeout(callBack, 100)
    }
  }


  //交换数据
  public moveData(from: number, to: number): void {
    let temp: Object = this.originDataArray[from];
    this.originDataArray[from] = this.originDataArray[to];
    this.originDataArray[to] = temp;
    this.notifyDataMove(from, to);
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:改变单个数据
   * */
  public changeData(index: number, data: Object): void {
    this.originDataArray.splice(index, 1, data)
    this.notifyDataChange(index)
  }

  //重置所有子组件的index索引
  public reloadData(): void {
    this.notifyDataReload();
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:改变多个数据
   * */
  public modifyAllData(): void {
    this.originDataArray = this.originDataArray.map((item: Object) => {
      return item + '0';
    })
  }

  /*
* Author:AbnerMing
* Describe:刷新数组,回调更新
*/
  private refreshCallBack?: (items: Array<Object>) => void

  refreshArrayCallback(callBack: (items: Array<Object>) => void) {
    this.refreshCallBack = callBack;
  }
}