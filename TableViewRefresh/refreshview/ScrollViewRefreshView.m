//
//  ScrollViewRefreshView.m
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/9.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ScrollViewRefreshView.h"
#import "Constants.h"



#define kRefreshViewWidth  200
#define kRefreshViewHeight 80

#define kMaxPullUpDistance   84
#define MarginForLoadMore  60       //用来控制，上提多少point才调用加载更多接口


@interface ScrollViewRefreshView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, copy) LoadMoreBlock loadMoreBlock;


@property(nonatomic,strong) UILabel* labelRefresh;

@end


@implementation ScrollViewRefreshView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:CGRectMake(0,CGRectGetHeight(frame), SCREEN_WIDTH, kRefreshViewHeight)];
    
    if(self){
        
    }
    return self;

}

-(void) initView{
    
    
    self.labelRefresh = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.frame.size.width, 40)];
    self.labelRefresh.text = @"上提加载更多";
    self.labelRefresh.backgroundColor = [UIColor greenColor];
    [self insertSubview:self.labelRefresh atIndex:0];

}

-(void) addTargetWith:(UIScrollView* ) scrollView {
    
    self.scrollView = scrollView;
    [self.scrollView insertSubview:self atIndex:0];
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    self.hidden = NO;
    

    self.labelRefresh = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.labelRefresh.text = @"上提加载更多";
    self.labelRefresh.textColor = [UIColor greenColor];
    self.labelRefresh.textAlignment = NSTextAlignmentCenter;
    self.labelRefresh.font = [UIFont systemFontOfSize:12.0];
    [self insertSubview:self.labelRefresh atIndex:0];
    
    
    //延迟 0.2s更新位置，防止位置被遮挡
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2);
    });
}


- (void)loadMore:(void (^)())block{
    self.loadMoreBlock = block;
}

-(void)loadMoreComplete{

    self.loadMoreState  = LoadMoreComplete;

    self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2);
}

//override method
-(void) setLoadMoreState:(LoadMore)loadMoreState{
    
    if(_loadMoreState != loadMoreState){
    
         _loadMoreState = loadMoreState;
    }

    switch(_loadMoreState){
    
        case LoadMoreLoading:{
            self.labelRefresh.text = @"正在加载,请稍后...";
            
        }break;
            
        case LoadMoreComplete:{
        
            self.labelRefresh.text = @"上提加载更多";
            
        }break;
        case LoadMoreNoMoreData:{
            
            self.labelRefresh.text = @"---HAPPY END----";
        
        }break;
    
    }

}


#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        self.contentSize = [[change valueForKey:NSKeyValueChangeNewKey] CGSizeValue];
        if (self.contentSize.height >= CGRectGetHeight(self.scrollView.frame)) {
            self.hidden = NO;
        }
        self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2); //防止下拉刷新时，位置显示不对的情况
    }
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if(self.loadMoreState == LoadMoreLoading || self.loadMoreState == LoadMoreNoMoreData) return;
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        
        if (contentOffset.y >= MarginForLoadMore) {
            
            if (!self.scrollView.tracking ) {
                self.hidden = NO;
                self.center = CGPointMake(self.center.x, self.contentSize.height + kRefreshViewHeight/2);
                self.loadMoreState = LoadMoreLoading;
                self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.labelRefresh.frame.size.height, 0);
                if (self.loadMoreBlock) {
                    self.loadMoreBlock();
                }

            }
            
        }
    }
}

#pragma mark - dealloc
- (void)dealloc {
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end











