//
//  XWStatus.h
//  XW新浪微博
//
//  Created by bbq on 15/7/19.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XWUser;


@interface XWStatus : NSObject
/** 	string 	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/** 	string 	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 	string 	微博来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	微博作者的用户信息字段 详细*/
@property(nonatomic,strong) XWUser* user;

/** 	object 	被转发的原微博信息字段，当该微博为转发微博时返回 详细*/

@property(nonatomic,strong) XWStatus* retweeted_status;

/** 	int 	转发数*/
@property (nonatomic, assign) int reposts_count;

/** 	 int 	评论数*/
@property (nonatomic, assign) int comments_count;

/** 	 int 	点赞数*/
@property (nonatomic, assign) int attitudes_count;

/** 	 object 	微博配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是HMPhoto模型*/
@property (nonatomic, strong) NSArray *pic_urls;

@end
