//
//  XWGetUnreadTool.m
//  XW新浪微博
//
//  Created by bbq on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWGetUnreadTool.h"
#import "XWHttpTool.h"
#import "MJExtension.h"

@implementation XWGetUnreadTool
+(void)getUnreadCount:(XWUnreadCountPara *)para success:(void (^)(XWUnreadCountResult *))success failure:(void (^)(NSError *))failure{
    //para.keyValues为模型转字典
    [XWHttpTool get:@"https://rm.api.weibo.com/2/remind/unread_count.json" para:para.keyValues success:^(id response) {
        //字典转模型
        XWUnreadCountResult* result= [XWUnreadCountResult objectWithKeyValues:response];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
