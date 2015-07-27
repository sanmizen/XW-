//
//  XWUserInfoTool.h
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//获取当前用户信息

#import <Foundation/Foundation.h>
#import "XWUserInfoPara.h"
#import "XWUser.h"

@interface XWUserInfoTool : NSObject
/**
 *  加载微博数据
 *
 *  @param para    传给服务器的参数模型
 *  @param success 成功后回调的block
 *  @param failure 失败后的回调block
 */
+(void)getUserInfo:(XWUserInfoPara*)para success:(void(^)(XWUser* result)) success failure:(void(^)(NSError* error))failure;

@end
