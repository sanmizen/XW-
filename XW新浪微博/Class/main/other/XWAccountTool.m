//
//  XWOAuthTool.m
//  XW新浪微博
//
//  Created by bbq on 15/7/16.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWAccountTool.h"
#import "XWAccount.h"
@implementation XWAccountTool

+(XWAccount*)getAccount{

    XWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:KaccountFilePath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];

    
    if ([now compare:account.expires_time]!=NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

+(void)saveAccount:(XWAccount*)account{
    [NSKeyedArchiver archiveRootObject:account toFile:KaccountFilePath];
}


@end
