//
//  XWAccount.h
//  XW新浪微博
//
//  Created by bbq on 15/7/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWAccount : NSObject<NSCoding>
/** string 	用于调用access_token，接口获取授权后的access token。*/
@property(nonatomic,copy) NSString* access_token;
/** string 	access_token的生命周期，单位是秒数。*/
@property(nonatomic,copy) NSString* expires_in;

@property(nonatomic,strong) NSDate* expires_time;
/** string 	当前授权用户的UID。*/
@property(nonatomic,copy) NSString* uid;

+(instancetype) accountWithDict:(NSDictionary*)dict;
@end
