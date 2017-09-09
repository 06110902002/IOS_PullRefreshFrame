//
//  QuickWordsView.m
//  AutoLayoutDemo1
//
//  Created by 刘小兵 on 2017/9/7.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "QuickWordsView.h"
#import "QiuckWordsCell.h"
#import "QuickWordsModel.h"


@implementation QuickWordsView

-(instancetype) initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
    }
    return self;
    
}

//@override method
-(void) initAttr{
    
    [super initAttr];

    NSArray* words = [NSArray arrayWithObjects:@"能同时开发android/ios",@"我可以把简历发您看看么?",
                      @"我能去贵司面试么?",@"对不起,贵司提供的职位可能不太适合,谢谢",nil];

    for(int i = 0;i < 4; i ++){
    
        QuickWordsModel* model = [[QuickWordsModel alloc] init];
        model.sWords = words[i];
        [self.dataList addObject:model];
    }
    
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.scrollHeadView = [[ScrollViewHeadView alloc] initWithFrame:self.frame];
    
    [self.scrollHeadView addTargetWith:self];
    [self.scrollHeadView refresh:^{
        
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            [weakSelf.dataList removeAllObjects];
            for(int i = 0;i < 1; i ++){
                
                QuickWordsModel* model = [[QuickWordsModel alloc] init];
                model.sWords = [NSString stringWithFormat:@"refresh data:%d",i];
                [weakSelf.dataList addObject:model];
            }
            
            [weakSelf reloadData];
            [weakSelf.scrollHeadView refreshComplete];
        });

        
        
    }];
    
    
    //添加上拉加载更多视图
    self.scrollFootView = [[ScrollViewRefreshView alloc] initWithFrame:self.frame];
    [self.scrollFootView addTargetWith:self];
    [self.scrollFootView loadMore:^{
        
        if(weakSelf.dataList.count > 10){
            
            weakSelf.scrollFootView.loadMoreState = LoadMoreNoMoreData;
            return ;
        }
       
        double delayTime = 3.0;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            for(int i = 0;i < 3; i ++){
                
                QuickWordsModel* model = [[QuickWordsModel alloc] init];
                model.sWords = [NSString stringWithFormat:@"loadmore data:%d",i];
                [weakSelf.dataList addObject:model];
            }
            
            [weakSelf reloadData];
            [weakSelf.scrollFootView loadMoreComplete];
        });
    }];


}



//@override method
-(BaseTabViewCell*) buildTableViewCell{

    return [[QiuckWordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QiuckWordsCell"];
    
}


//@override method
-(CGFloat) getCellHeight{

    return 40.0f;
}

@end
