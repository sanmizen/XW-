//
//  XWUserInfoTool.m
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWUserInfoTool.h"
#import "XWHttpTool.h"
#import "MJExtension.h"

@implementation XWUserInfoTool
+(void)getUserInfo:(XWUserInfoPara *)para success:(void (^)(XWUser *))success failure:(void (^)(NSError *))failure{
    [XWHttpTool get:@"https://api.weibo.com/2/users/show.json" para:para.keyValues success:^(id response) {
        //字典转模型
        
        XWUser* result= [XWUser objectWithKeyValues:response];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
