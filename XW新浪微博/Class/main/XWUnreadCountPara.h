//
//  XWUnreadCountPara.h
//  XW新浪微博
//
//  Created by bbq on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//未读数参数

#import <Foundation/Foundation.h>

@interface XWUnreadCountPara : NSObject
/**
 *  string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property(nonatomic,copy) NSString* access_token;

/**
 *  int64 	需要获取消息未读数的用户UID，必须是当前登录用户。
 */
@property(nonatomic,copy) NSString* uid;


@end
