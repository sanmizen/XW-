//
//  XWHomeStatusResult.h
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWStatus.h"
#import "MJExtension.h"

@interface XWHomeStatusResult : NSObject

/**
 *  返回的微博数据数组
 */
@property(nonatomic,strong) NSArray* statuses;

@end
