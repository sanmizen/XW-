//
//  XWDetailFrame.h
//  XW新浪微博
//
//  Created by bbq on 15/7/31.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWOriginalFrame.h"
#import "XWRetweetFrame.h"
#import "XWStatus.h"

@interface XWDetailFrame : NSObject

@property(nonatomic,strong) XWOriginalFrame* originalFrame;
@property(nonatomic,strong) XWRetweetFrame* retweetFrame;
/**
 *  自己的frame
 */
@property(nonatomic,assign) CGRect frame;

@property(nonatomic,strong) XWStatus* status;
@end
