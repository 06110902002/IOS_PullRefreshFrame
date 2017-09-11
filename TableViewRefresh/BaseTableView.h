//
//  BaseTableView.h
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollViewRefreshView.h"
#import "ScrollViewHeadView.h"

@class BaseTabViewCell;
@class BaseRefreshHeadView;





/**
 消息页面，列表基类
 */
@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,CAAnimationDelegate>


@property(nonatomic,strong)UITableView* mTableView;

@property(nonatomic,strong)NSMutableArray *dataList;

@property(nonatomic,assign) BOOL bIsRefreshing;

@property(nonatomic,assign) BOOL bIsLoading;

@property(nonatomic,strong) ScrollViewRefreshView* scrollFootView;

@property(nonatomic,strong) ScrollViewHeadView* scrollHeadView;




/**
 初始化接口，子类重载时，可初始化自身的特有的对象
 */
-(void) initAttr;

/**
 构建单元格，子类需要重载此方法，方能达到效果

 @return UITableViewCell
 */
-(BaseTabViewCell*) buildTableViewCell;


/**
 获取单元格高度，子类需要重载

 @return 单元格高度
 */
-(CGFloat) getCellHeight;



/**
 上提加载更多底部视图，子类需要扩展此类，不然后返回的底部加载更多视图是一个默认的视图

 @return 返回一个扩展了ScrollViewRefreshView的具体子类
 */
-(ScrollViewRefreshView*) buildFootView;

-(void(^)()) buildLoadMoreListener;



/**
 构建下拉刷新头部视图，子类需要扩展此类，不然后返回的下拉刷新视图是一个默认的视图

 @return 返回一个扩展了ScrollViewHeadView的具体子类
 */
//-(ScrollViewHeadView*) buildHeadView;

@end
