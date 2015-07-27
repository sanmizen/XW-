//
//  XWSelectImageView.h
//  XW新浪微博
//
//  Created by bbq on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSelectImageView : UIView
@property(nonatomic,strong) NSArray* imageArray;

-(void)addImages:(UIImage*)selectImage;
@end
