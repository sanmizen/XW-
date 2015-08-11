//
//  XWRetweetFrame.h
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWStatus.h"
#import "XWUser.h"

@interface XWRetweetFrame : NSObject

/**
 *  昵称frame
 */
@property(nonatomic,assign) CGRect nameLabelFrame;
/**
 *  正文frame
 */
@property(nonatomic,assign) CGRect textLabelFrame;
/**
 *  自己的frame
 */
@property(nonatomic,assign) CGRect frame;

/**
 *  大配图view的frame
 */
@property(nonatomic,assign) CGRect photosFrame;

/**
 *  转发的微博数据
 */
@property(nonatomic,strong) XWStatus* retweetedStatus;
@end
