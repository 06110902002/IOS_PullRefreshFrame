//
//  QuickWordsModel.h
//  AutoLayoutDemo1
//
//  Created by 刘小兵 on 2017/9/7.
//  Copyright © 2017年 刘小兵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"



/**
 快捷消息信息实体，因为不需要在同一个列表中显示不同的cell所以此处未实现父类的类型协议接口
 */
@interface QuickWordsModel : BaseModel

@property(nonatomic,copy) NSString* sWords;

@end
