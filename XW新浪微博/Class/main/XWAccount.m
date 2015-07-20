//
//  XWAccount.m
//  XW新浪微博
//
//  Created by bbq on 15/7/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWAccount.h"

@implementation XWAccount
+(instancetype) accountWithDict:(NSDictionary*)dict{
    XWAccount* account=[[self alloc]init];
    account.access_token=dict[@"access_token"];
    account.expires_in=dict[@"expires_in"];
    account.uid=dict[@"uid"];
    NSDate* now=[NSDate date];
    //过期日期为现在时间+有效时长
    account.expires_time=[now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}


/**
 存储时调用
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
}

/**
 读档时调用
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _access_token=[aDecoder decodeObjectForKey:@"access_token"];
        _expires_in=[aDecoder decodeObjectForKey:@"expires_in"];
        _uid=[aDecoder decodeObjectForKey:@"uid"];
        _expires_time=[aDecoder decodeObjectForKey:@"expires_time"];
       
    }
     return self;
   
}
@end

