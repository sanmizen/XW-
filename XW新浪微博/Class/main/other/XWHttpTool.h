//
//  XWHttpTool.h
//  XW新浪微博
//
//  Created by bbq on 15/7/26.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface XWHttpTool : NSObject


//这里定义代码块后的参数列表要写形参名
+(void)get:(NSString*)url para:(NSDictionary*)para success:(void (^)(id response)) success failure:(void (^) (NSError* error)) failure;


+(void)post:(NSString*)url para:(NSDictionary*)para success:(void (^)(id response)) success failure:(void (^) (NSError* error)) failure;

@end
