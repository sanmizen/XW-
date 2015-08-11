//
//  XWStatusPhotosView.h
//  XW新浪微博
//
//  Created by bbq on 15/8/8.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWStatusPhotosView : UIView
/**
 *  每条微博的图片url数组
 */
@property(nonatomic,strong) NSArray* pic_urls;

+(CGSize)sizeWithPhotoCount:(int)photosCount;

@end
