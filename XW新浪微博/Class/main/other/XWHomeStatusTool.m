//
//  XWHomeStatusTool.m
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWHomeStatusTool.h"
#import "MJExtension.h"

@implementation XWHomeStatusTool

+(void)loadWeiboStatus:(XWHomeStatusPara *)para success:(void (^)(XWHomeStatusResult *))success failure:(void (^)(NSError *))failure{
    //para.keyValues为模型转字典
    [XWHttpTool get:@"https://api.weibo.com/2/statuses/home_timeline.json" para:para.keyValues success:^(id response) {
        //字典转模型
      XWHomeStatusResult* result= [XWHomeStatusResult objectWithKeyValues:response];
        success(result);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
