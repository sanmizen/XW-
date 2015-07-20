//
//  XWTabBar.h
//  XW新浪微博
//
//  Created by bbq on 15/7/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWTabBar;

@protocol XWTarbarDelegate <NSObject>
@optional
-(void)TarbarCrossBtnClicked:(XWTabBar*)tabBar;
@end

@interface XWTabBar : UITabBar

@property(nonatomic,weak) id<XWTarbarDelegate> myDelegate;

@property(nonatomic,assign) int test1;
@end


