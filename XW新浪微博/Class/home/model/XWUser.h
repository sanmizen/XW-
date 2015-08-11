//
//  XWUser.h
//  XW新浪微博
//
//  Created by bbq on 15/7/19.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUser : NSObject
/** string 	友好显示名称 */
@property (nonatomic, copy) NSString *name;

/** string 	用户头像地址（中图），50×50像素 */
@property (nonatomic, copy) NSString *profile_image_url;
/**
 *  会员等级
 */
@property(nonatomic,assign) int mbrank;
/**
 *  会员类型
 */
@property(nonatomic,assign) int mbtype;
@end
