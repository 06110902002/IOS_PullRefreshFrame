//
//  ScrollViewHeadView.h
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/9.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,PullDownRefresh){
    
    PullDownRefreshNomral = 1,
    PullDownRefreshing,
    PullDownRefreshComplete,
    
};


typedef void(^PullDownRefreshBlock)(void);

/**
 ScrollView列表的下拉刷新视图
 */
@interface ScrollViewHeadView : UIView


@property (nonatomic, strong) UIScrollView *scrollView;


//@property (nonatomic, assign) CGFloat originOffset;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) BOOL notTracking;

@property(nonatomic,strong) UILabel* labelRefresh;

@property (nonatomic, copy) PullDownRefreshBlock refreshingBlock;

@property(nonatomic,assign) PullDownRefresh refershState;


/**
 将当前视图绑定到滚动列表中
 
 @param scrollView 目标滚动列表
 */
-(void) addTargetWith:(UIScrollView* ) scrollView;



/**
 *  上提加载更多回调接口
 *  @param bolck 下拉刷新 block
 */
- (void) refresh:(PullDownRefreshBlock) bolck;


/**
 加载更多完成接口
 */
-(void) refreshComplete;



@end
