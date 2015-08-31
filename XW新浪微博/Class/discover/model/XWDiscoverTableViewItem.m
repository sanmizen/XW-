//
//  XWDiscoverTableViewItem.m
//  XW新浪微博
//
//  Created by bbq on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWDiscoverTableViewItem.h"

@implementation XWDiscoverTableViewItem
+(instancetype)itemWithIcon:(NSString *)icon andTitle:(NSString *)title{
    XWDiscoverTableViewItem* item=[[XWDiscoverTableViewItem alloc]init];
    item.title=title;
    item.icon=icon;
    return item;
}


+(instancetype)itemWithTitle:(NSString *)title{
 return  [XWDiscoverTableViewItem itemWithIcon:nil andTitle:title];
}
@end
