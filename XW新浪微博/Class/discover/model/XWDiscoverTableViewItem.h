//
//  XWDiscoverTableViewItem.h
//  XW新浪微博
//
//  Created by bbq on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
////描述一个tabelviewItem

#import <Foundation/Foundation.h>

@interface XWDiscoverTableViewItem : NSObject
/**
 *  点击要跳转到的控制器
 */
@property(nonatomic,strong) UIViewController* destinationController;

/**
 *  标题
 */
@property(nonatomic,copy) NSString* title;
/**
 *  子标题
 */
@property(nonatomic,copy) NSString* subTitle;
/**
 *  图标
 */
@property(nonatomic,copy) NSString* icon;
/**
 *  点击执行的block
 */
@property(nonatomic,copy) void (^operation)();

+(instancetype)itemWithIcon:(NSString*)icon andTitle:(NSString*)title;
+(instancetype)itemWithTitle:(NSString*)title;

@end
