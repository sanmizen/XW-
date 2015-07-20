//
//  UIBarButtonItem+Extension.h
//  XW新浪微博
//
//  Created by bbq on 15/7/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem*)itemWithImageName:(NSString*)normalImageName highlightImageName:(NSString*)highlightImageName target:(id)target selector:(SEL)selector;
@end
