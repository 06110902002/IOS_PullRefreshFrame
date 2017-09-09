//
//  ScrollViewRefreshView.h
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/9.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LoadMore){
    
    LoadMoreLoading = 1,
    LoadMoreComplete,
    LoadMoreNoMoreData,
    
};





typedef void(^LoadMoreBlock)(void);

/**
 滚动列表中下拉刷新/上提加载更多的公共刷新视图
 */
@interface ScrollViewRefreshView : UIView


@property(nonatomic,assign) LoadMore loadMoreState;



/**
 初始View布局与全局属性
 */
-(void) initView;

/**
 将当前视图绑定到滚动列表中

 @param scrollView 目标滚动列表
 */
-(void) addTargetWith:(UIScrollView* ) scrollView;



/**
 *  上提加载更多回调接口
 *  @param block 加载更多 block
 */
- (void)loadMore:(void(^)())block;


/**
 加载更多完成接口
 */
-(void) loadMoreComplete;



@end
