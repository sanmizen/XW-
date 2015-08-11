//
//  XWStatus.m
//  XW新浪微博
//
//  Created by bbq on 15/7/19.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWStatus.h"
#import "XWPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"

@interface XWStatus()



@end


@implementation XWStatus



/**
 表示XWStatus中pic_urls数组内的元素类型为XWPhoto
 */
//+(NSDictionary *)objectClassInArray{
//    return @{@"pic_urls":[XWPhoto class]};
//}


- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [XWPhoto class]};
}

/**
 *  转换创建时间
 Mon Aug 03 22:15:03 +0800 2015
 */
-(NSString*)created_at{
    NSDateFormatter* dfmt=[[NSDateFormatter alloc]init];
    dfmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate* creatDate=[dfmt dateFromString:_created_at];
    if ([creatDate isThisYear]) {//如果是今年
        if ([creatDate isToday]) {//如果是今天
            NSDateComponents* dcms=[creatDate deltaWithNow];//获取与当前时间的差距
            if (dcms.hour<1) {//一小时以内
                if (dcms.minute<1) {//一分钟以内
                    return @"刚刚";
                }else{//1~60分钟
                    return [NSString stringWithFormat:@"%d分钟前",dcms.minute];
                }
            }else{//大于一小时
                return [NSString stringWithFormat:@"%d小时前",dcms.hour];
            }
        }else{//不是今天
            dfmt.dateFormat=@"M月d日HH点";
            return [dfmt stringFromDate:creatDate];
        }
        
    }else{//不是今年
    return @"很久很久以前的微博啦";
    }

    
}
/**
 *  处理来源数据
 <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
 */

/**
 *  在set方法中设置来源，可优化性能
 *
 */
-(void)setSource:(NSString *)source{
    _source=source;
    NSRange rang={22,22};
    rang.location=[_source rangeOfString:@">"].location+1;
    rang.length=[_source rangeOfString:@"</"].location-rang.location;
    
    if (rang.length<1000) {
        _source= [NSString stringWithFormat:@"来自%@",[_source substringWithRange:rang]];
        
    }else{
        _source= @"errrrrror";
    }
}
@end
