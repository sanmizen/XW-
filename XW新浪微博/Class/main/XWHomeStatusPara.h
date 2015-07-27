//
//  XWHomeStatusPara.h
//  XW新浪微博
//
//  Created by bbq on 15/7/27.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWHomeStatusPara : NSObject

/**
 *  string 	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
 */
@property(nonatomic,strong) NSString* access_token;

/**
 *  int64 	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property(nonatomic,strong) NSNumber* since_id;


/**
 *  int64 	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property(nonatomic,strong) NSNumber* max_id;


/**
 *  int 	单页返回的记录条数，最大不超过100，默认为20。
 */
@property(nonatomic,strong) NSNumber* count;
@end
