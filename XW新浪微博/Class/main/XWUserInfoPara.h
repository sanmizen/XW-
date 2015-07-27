//
//  XWUserInfoPara.h
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUserInfoPara : NSObject
/**
 *  string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property(nonatomic,strong) NSString* access_token;

/**
 *  int64 	需要查询的用户ID。
 */
@property(nonatomic,copy) NSString* uid;
/**
 *  false 	string 	需要查询的用户昵称。
 */
@property(nonatomic,copy) NSString* screen_name;

@end
