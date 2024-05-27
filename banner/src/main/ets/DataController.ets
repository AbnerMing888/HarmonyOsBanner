/**
 * AUTHOR:AbnerMing
 * DATE:2024/5/10
 * INTRODUCE:数据控制器
 * */
export class DataController {
  private items: Array<Object> = []
  private refreshCallBack?: (items: Array<Object>) => void

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回列表数量
   * */
  totalCount(): number {
    return this.items.length
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回所有的数据
   * */
  getDataAll(): Object[] {
    return this.items;
  }

  /**
   * AUTHOR:AbnerMing
   * INTRODUCE:返回某一个对象
   * */
  getData(index: number): Object {
    return this.items[index]
  }

  /*
  * Author:AbnerMing
  * Describe:初始化数据
  */
  init(items: Array<Object>) {
    this.items = items
  }

  /*
  * Author:AbnerMing
  * Describe:添加单条数据
  */
  add(item: Object) {
    this.items.push(item)
  }

  /*
 * Author:AbnerMing
 * Describe:指定位置添加数据
 */
  addPosition(position: number, item: Object) {
    this.items.splice(position, 0, item)
  }

  /*
    * Author:AbnerMing
    * Describe:添加可变参数
    */
  addVariable(...items: Object[]) {
    this.items.push(...items)
  }

  /*
   * Author:AbnerMing
   * Describe:添加数组
   */
  addArray(items: Object[]) {
    this.items = this.items.concat(items)
    if (this.refreshCallBack != undefined) {
      this.refreshCallBack(this.items)
    }
  }



  /*
  * Author:AbnerMing
  * Describe:刷新数组,回调更新
  */
  refreshArrayCallback(callBack: (items: Array<Object>) => void) {
    this.refreshCallBack = callBack;
  }

  /*
  * Author:AbnerMing
  * Describe:刷新数组
  */
  refreshArray(items: Array<Object>) {
    this.items = items;
  }

  /*
* Author:AbnerMing
* Describe:删除第一条数据
*/
  deleteFirst() {
    this.items.shift()
  }

  /*
* Author:AbnerMing
* Describe:删除最后一条数据
*/
  deleteLast() {
    this.items.pop()
  }

  /*
 * Author:AbnerMing
 * Describe:删除一条数据
 */
  deleteData(position: number) {
    this.items = this.items.filter((_, index) => index !== position)
    if (this.refreshCallBack != undefined) {
      this.refreshCallBack(this.items)
    }
  }

  /*
 * Author:AbnerMing
 * Describe:删除全部数据
 */
  deleteAll() {
    this.items = []
    if (this.refreshCallBack != undefined) {
      this.refreshCallBack(this.items)
    }
  }

  /*
  * Author:AbnerMing
  * Describe:修改数据
  */

  changeData(position: number, item: Object) {
    if (position < this.items.length) {
      this.items.splice(position, 1, item)
    } else {
      console.error("ERROR:索引超过了数组的长度")
    }
  }
}