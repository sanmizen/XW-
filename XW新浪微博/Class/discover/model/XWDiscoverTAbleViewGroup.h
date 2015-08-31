//
//  XWDiscoverTAbleViewGroup.h
//  XW新浪微博
//
//  Created by bbq on 15/8/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//描述一个tabelviewGroup

#import <Foundation/Foundation.h>

@interface XWDiscoverTableViewGroup : NSObject
/**
 *  组头
 */
@property(nonatomic,copy) NSString* header;
/**
 *  组尾
 */
@property(nonatomic,copy) NSString* footer;
/**
 *  内容item(item行模型)
 */
@property(nonatomic,strong) NSArray* items;

@end
