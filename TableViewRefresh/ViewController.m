//
//  ViewController.m
//  TableViewRefresh
//
//  Created by 刘小兵 on 2017/9/8.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "QuickWordsView.h"
#import "Constants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self buildQuickChat];
    
    
    
    
    
}



-(void) buildQuickChat{
    
    UILabel* headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    headView.text = @"refresh...";
    headView.backgroundColor = [UIColor greenColor];
    
    
    //下面开始处理隐藏部分，默认显示快捷消息
    QuickWordsView* quickWordsView = [[QuickWordsView alloc] init];
    //quickWordsView.tableHeaderView = headView;
    quickWordsView.separatorInset = UIEdgeInsetsMake(0,10,0,10);  //top left right down
    quickWordsView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];  //删除底部多余行，及分割线
    [self.view addSubview:quickWordsView];
    
    [quickWordsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view.mas_trailing);
        make.top.equalTo(self.view.mas_top).offset(47);
        make.height.mas_equalTo(400);
        
    }];
    
    
    
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));
//    
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//        
//        quickWordsView.tableHeaderView = nil;
//        
//    });
    

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
