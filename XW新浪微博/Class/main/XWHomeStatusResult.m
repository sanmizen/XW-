//
//  XWHomeStatusResult.m
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWHomeStatusResult.h"

@implementation XWHomeStatusResult

-(NSDictionary *)objectClassInArray{
    return @{@"statuses":[XWStatus class]};
}


@end
