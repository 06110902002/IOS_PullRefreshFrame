//
//  BaseTableView.m
//  BossJob
//
//  Created by 刘小兵 on 2017/8/29.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "BaseTableView.h"
#import "Constants.h"
#import "BaseModel.h"
#import "BaseTabViewCell.h"


#import "BaseRefreshHeadView.h"

@implementation BaseTableView

-(instancetype) initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
    
        [self initAttr];
    
    }
    return self;

}

-(void) initAttr{

    self.dataList = [NSMutableArray array];
    self.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
    self.delegate = self;
    self.dataSource = self;
    [self reloadData];
    

    [self addSubview:[self buildFootView]];
    [[self buildFootView] loadMore:[self buildLoadMoreListener]];

}

-(BaseTabViewCell*) buildTableViewCell{

    NSLog(@"这里必须重载");
    return [[BaseTabViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BaseTabViewCell"];;
}

-(CGFloat) getCellHeight{

    return 0.0f;
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataList count];

}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BaseTabViewCell* cell = [self buildTableViewCell];
    
    [cell setFrame:CGRectMake(0, 0, SCREEN_WIDTH, [self getCellHeight])];
    
    cell.backgroundColor = [UIColor colorWithRed:235.0 / 255.0 green:238.0/255.0 blue:237.0/255.0 alpha:1.0];
    
    BaseModel* data = ((BaseModel* )self.dataList[indexPath.row]);
    
    [cell bindData:data];

    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getCellHeight];
}

//-------------------uitableView 协议方法结束-----------------------


-(ScrollViewRefreshView*) buildFootView{

    if(!self.scrollFootView){
        self.scrollFootView = [[ScrollViewRefreshView alloc] initWithFrame:self.frame];
        [self.scrollFootView addTargetWith:self];
    }
    return self.scrollFootView;
}

-(void(^)()) buildLoadMoreListener{

    LoadMoreBlock loadMore = ^(){
        
        
        double delayTime = 3.0;
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delayTime * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            
            [self buildFootView].loadMoreState = LoadMoreNoMoreData;
        });
    };
    
    return loadMore;
}




@end
