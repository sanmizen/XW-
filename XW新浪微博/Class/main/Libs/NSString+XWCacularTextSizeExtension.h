//
//  NSString+XWCacularTextSizeExtension.h
//  XW新浪微博
//
//  Created by bbq on 15/8/1.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWCacularTextSizeExtension)
-(CGSize)sizeWithMaxSize:(CGSize)maxSize font:(UIFont*)font;
@end
