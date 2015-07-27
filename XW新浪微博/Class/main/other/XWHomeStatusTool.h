//
//  XWHomeStatusTool.h
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWHttpTool.h"
#import "XWHomeStatusPara.h"
#import "XWHomeStatusResult.h"

@interface XWHomeStatusTool : NSObject

/**
 *  加载微博数据
 *
 *  @param para    传给服务器的参数模型
 *  @param success 成功后回调的block
 *  @param failure 失败后的回调block
 */
+(void)loadWeiboStatus:(XWHomeStatusPara*)para success:(void(^)(XWHomeStatusResult* result)) success failure:(void(^)(NSError* error))failure;

@end
