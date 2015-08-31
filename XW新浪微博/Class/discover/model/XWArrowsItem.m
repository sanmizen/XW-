//
//  XWArrowsItem.m
//  XW新浪微博
//
//  Created by bbq on 15/8/16.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWArrowsItem.h"

@implementation XWArrowsItem
+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title{
    XWArrowsItem* item=[[XWArrowsItem alloc]init];
    item.title=title;
    item.icon=icon;
    return item;
}
@end
