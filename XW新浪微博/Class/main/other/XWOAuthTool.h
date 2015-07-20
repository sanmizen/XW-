//
//  XWOAuthTool.h
//  XW新浪微博
//
//  Created by bbq on 15/7/16.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XWAccount;

@interface XWOAuthTool : NSObject

+(XWAccount*)getAccount;

+(void)saveAccount:(XWAccount*)account;

@end
