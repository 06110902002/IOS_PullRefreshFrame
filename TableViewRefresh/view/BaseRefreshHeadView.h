//
//  BaseRefreshHeadView.h
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/8.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>





static NSString *Refresh_normal_title  = @"正常状态";
static NSString *Refresh_pulling_title  = @"释放刷新状态";
static NSString *Refresh_Refreshing_title  = @"正在刷新";


/**
 下拉滚动列表下拉刷新头部基类视图
 */
@interface BaseRefreshHeadView : UIRefreshControl


- (instancetype)initWithTargrt:(id)target refreshAction:(SEL)refreshAction;


- (void)endRefreshing;

@end
