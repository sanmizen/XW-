//
//  XWOriginalFrame.h
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWStatus.h"
#import "XWUser.h"

@interface XWOriginalFrame : NSObject
/**
 *  昵称frame
 */
@property(nonatomic,assign) CGRect nameLabelFrame;
/**
 *  正文frame
 */
@property(nonatomic,assign) CGRect textLabelFrame;
/**
 *  来源frame
 */
@property(nonatomic,assign) CGRect sourceLabelFrame;
/**
 *  时间frame
 */
@property(nonatomic,assign) CGRect timeLabelFrame;
/**
 *  头像frame
 */
@property(nonatomic,assign) CGRect iconViewFrame;
/**
 *  vip图片frame
 */
@property(nonatomic,assign) CGRect vipViewFrame;
/**
 *  大配图view的frame
 */
@property(nonatomic,assign) CGRect photosFrame;

/**
 *  自己的frame
 */
@property(nonatomic,assign) CGRect frame;
@property(nonatomic,strong) XWStatus* status;

@end
