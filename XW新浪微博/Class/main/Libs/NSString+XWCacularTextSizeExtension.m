//
//  NSString+XWCacularTextSizeExtension.m
//  XW新浪微博
//
//  Created by bbq on 15/8/1.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "NSString+XWCacularTextSizeExtension.h"

@implementation NSString (XWCacularTextSizeExtension)

-(CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont*)font{
    NSDictionary* fontDict=@{NSFontAttributeName:font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;
}

@end
