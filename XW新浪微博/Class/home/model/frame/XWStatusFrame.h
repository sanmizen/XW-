//
//  XWStatusFrame.h
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWStatus.h"
#import "XWDetailFrame.h"

@interface XWStatusFrame : NSObject

@property(nonatomic,strong) XWStatus* status;
@property(nonatomic,strong) XWDetailFrame* detailFrame;
@property(nonatomic,assign) CGRect toolBarFrame;
/**
 *  自己的frame
 */
@property(nonatomic,assign) CGRect frame;

@property(nonatomic,assign) CGFloat cellHeight;
@end
