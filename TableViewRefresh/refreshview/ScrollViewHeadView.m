//
//  ScrollViewHeadView.m
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/9.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollViewHeadView.h"
#import "Constants.h"


#define kRefreshViewWidth  200
#define kRefreshViewHeight 80

#define kMaxPullDownDistance   84

#define MarginForRefrshing  60       //用来控制，上提多少point才调用加载更多接口

@implementation ScrollViewHeadView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0,-kRefreshViewHeight,SCREEN_WIDTH, kRefreshViewHeight)];
    if(self){
        
    }
    return self;
    
}


-(void) addTargetWith:(UIScrollView* ) scrollView {
    
    
    // self.originOffset = 70.0;
    
    self.scrollView = scrollView;
    [self.scrollView insertSubview:self atIndex:0];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
   
    //self.backgroundColor = [UIColor yellowColor];
    
    self.labelRefresh = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kRefreshViewHeight)];
    self.labelRefresh.text = @"下拉刷新数据";
    self.labelRefresh.textColor = [UIColor greenColor];
    self.labelRefresh.textAlignment = NSTextAlignmentCenter;
    self.labelRefresh.font = [UIFont systemFontOfSize:12.0];
    [self insertSubview:self.labelRefresh atIndex:0];
    
    
//    //延迟 0.2s更新位置，防止位置被遮挡
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2);
//    });
}

//override --method
-(void) setRefershState:(PullDownRefresh)refershState{
    
    if(_refershState != refershState){
    
        _refershState = refershState;
    }
    
    switch(_refershState){
            
        case PullDownRefreshNomral:{
            
            self.labelRefresh.text = @"下拉刷新数据";
        
        }break;
    
        case PullDownRefreshing:{
            
            self.labelRefresh.text = @"正在刷新,请稍后...";
        
        }break;
            
            
        case PullDownRefreshComplete:{
            
            self.labelRefresh.text = @"刷新完成";
        
        }break;
    
    }

}

-(void) refresh:(PullDownRefreshBlock)bolck{

    self.refreshingBlock = bolck;
}

-(void) refreshComplete{

    self.refershState = PullDownRefreshNomral;
    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if(self.refershState == PullDownRefreshing) return;
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        if (MarginForRefrshing + contentOffset.y <= 0) {
            
            if (!self.scrollView.tracking) {
                
                self.refershState = PullDownRefreshing;
                self.scrollView.contentInset = UIEdgeInsetsMake(kMaxPullDownDistance, 0, 0, 0);
                
                if (self.refreshingBlock) {
                    self.refreshingBlock();
                }
            }

        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
