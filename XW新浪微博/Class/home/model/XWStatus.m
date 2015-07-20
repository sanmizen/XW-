//
//  XWStatus.m
//  XW新浪微博
//
//  Created by bbq on 15/7/19.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWStatus.h"
#import "XWPhoto.h"
#import "MJExtension.h"

@implementation XWStatus



/**
 表示XWStatus中pic_urls数组内的元素类型为XWPhoto
 */
+(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[XWPhoto class]};
}
@end
