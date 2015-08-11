//
//  XWPhoto.m
//  XW新浪微博
//
//  Created by bbq on 15/7/19.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWPhoto.h"

@implementation XWPhoto

-(void)setThumbnail_pic:(NSString *)thumbnail_pic{
    _thumbnail_pic=thumbnail_pic;
    _bmiddle_pic=[thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
