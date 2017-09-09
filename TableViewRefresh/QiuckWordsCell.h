//
//  QiuckWordsCell.h
//  AutoLayoutDemo1
//
//  Created by 刘小兵 on 2017/9/7.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabViewCell.h"

@class QuickWordsModel;

@interface QiuckWordsCell : BaseTabViewCell


@property(nonatomic,strong) UILabel* labelWords;

@property(nonatomic,strong) UIImageView* imgModify;

@property(nonatomic,strong) UIImageView* imgDelete;

@property(nonatomic,strong) QuickWordsModel* data;

@end
