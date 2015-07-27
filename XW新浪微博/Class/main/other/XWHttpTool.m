//
//  XWHttpTool.m
//  XW新浪微博
//
//  Created by bbq on 15/7/26.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWHttpTool.h"

@implementation XWHttpTool

+(void)post:(NSString *)url para:(NSDictionary *)para success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager * mrg=[AFHTTPRequestOperationManager manager];
    NSString* postUrl=url;
    
    [mrg GET:postUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //判断如果afn的block中的success有值
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
    
}


+(void)get:(NSString *)url para:(NSDictionary *)para success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager * mrg=[AFHTTPRequestOperationManager manager];
    NSString* getUrl=url;

    [mrg GET:getUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}

@end
