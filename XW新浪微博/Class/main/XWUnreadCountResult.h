//
//  XWUnreadCountResult.h
//  XW新浪微博
//
//  Created by bbq on 15/7/28.
//  Copyright (c) 2015年 bbq. All rights reserved.
//  未读数返回结果

#import <Foundation/Foundation.h>

@interface XWUnreadCountResult : NSObject
/**
 *  int 	新微博未读数
 */
@property(nonatomic,assign) int status;

/**
 *  int 	新粉丝数
 */
@property(nonatomic,assign) int follower;

/**
 *  int 	新评论数
 */
@property(nonatomic,assign) int cmt;

/**
 *  int 	新私信数
 */
@property(nonatomic,assign) int dm;

/**
 *  int 	新提及我的微博数
 */
@property(nonatomic,assign) int mention_status;

/**
 *  int 	新提及我的评论数
 */
@property(nonatomic,assign) int mention_cmt ;

/**
 *  int 	微群消息未读数
 */
@property(nonatomic,assign) int group;


/**
 *  int 	新通知未读数
 */
@property(nonatomic,assign) int notice;

/**
 *  int 	新邀请未读数
 */
@property(nonatomic,assign) int invite;

-(int)getUnreadMsgCount;

@end
