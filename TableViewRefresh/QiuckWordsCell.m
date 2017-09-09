//
//  QiuckWordsCell.m
//  AutoLayoutDemo1
//
//  Created by 刘小兵 on 2017/9/7.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import "QiuckWordsCell.h"
#import "Masonry.h"
#import "QuickWordsModel.h"

@implementation QiuckWordsCell

//ovride
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self initItemView];
    }
    return self;
}

//ovride super class method for initView
-(void) initItemView{
    
    self.selectionStyle = UITableViewCellSelectionStyleNone; //取消点击时背景色
    
    self.labelWords = [[UILabel alloc] init];
    self.labelWords.textColor = [UIColor blackColor];
    self.labelWords.text = @"韦小宝";
    self.labelWords.font = [UIFont systemFontOfSize:14];
    [self addSubview: self.labelWords];
    [self.labelWords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self).offset(10.0);
        make.centerY.equalTo(self.mas_centerY);
        make.trailing.equalTo(self.mas_trailing).offset(-90);
    }];
    
    
    
    self.imgModify = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_quick_reply_edit.png"]];
    self.imgModify.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imgModify];
    [self.imgModify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labelWords.mas_trailing).offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24.0));
    }];
    self.imgModify.userInteractionEnabled = YES;//打开用户交互
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgActionDown:)];
    //singleTap.delegate = self;
    [self.imgModify addGestureRecognizer:singleTap];
    
    self.imgDelete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_quick_reply_delete.png"]];
    self.imgDelete.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.imgDelete];
    [self.imgDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imgModify.mas_trailing).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(24, 24.0));
    }];
    
    self.imgDelete.userInteractionEnabled = true;
    [self.imgDelete addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgActionDown:)]];
   
    
    
    
}


//ovride super class method
-(void) bindData:(BaseModel*_Nonnull) data{
    
    if(self.data != (QuickWordsModel*) data){
    
        self.data = (QuickWordsModel*) data;
        self.labelWords.text = self.data.sWords;
    }
    
}

-(void)imgActionDown:(UITapGestureRecognizer*) gestureRecognizer{
  
    UIView* viewClicked=[gestureRecognizer view];
    if (viewClicked == self.imgModify) {
        
        NSLog(@"90---------self.imgModify");
    }
    else if(viewClicked==self.imgDelete)
    {
        NSLog(@"94---------self.imgDelete");
    }
    
    
    
}


@end
