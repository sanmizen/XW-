//
//  UIImage+resizable.m
//  QQ聊天
//
//  Created by bbq on 15/5/16.
//  Copyright (c) 2015年 hehe. All rights reserved.
//

#import "UIImage+resizable.h"

@implementation UIImage (resizable)
+(UIImage*)resizableImage:(NSString*)imageName{
    UIImage* previousImage=[UIImage imageNamed:imageName];
    UIEdgeInsets chatImageInsets=  UIEdgeInsetsMake(previousImage.size.width*0.5, previousImage.size.width*0.5, previousImage.size.height*0.5, previousImage.size.height*0.5);
    UIImage* afterImage=[previousImage resizableImageWithCapInsets:chatImageInsets];
    return afterImage;
}
@end
