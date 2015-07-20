//
//  XWTabBar.m
//  XW新浪微博
//
//  Created by bbq on 15/7/10.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWTabBar.h"

@interface XWTabBar()
@property(nonatomic,weak) UIButton* crossBtn;
@end

@implementation XWTabBar


-(void)layoutSubviews{
    [super layoutSubviews];
//    CGFloat btnX=0;
    CGFloat btnY=0;
    //item为tarbar中子控件数组
    CGFloat btnW=self.frame.size.width/(self.items.count+1);
    CGFloat btnH=self.frame.size.height;
    int i=0;
    //遍历tabbar中得subview，找出tabbarButton，并调整frame
    for (UIView* subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i==2) {
                self.crossBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                [self.crossBtn addTarget:self action:@selector(crossBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.crossBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
                [self.crossBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
                [self.crossBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
                [self.crossBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
                //根据图片自动设置合适的宽高
                [self.crossBtn sizeToFit];
                
                self.crossBtn.frame=CGRectMake(i*btnW, btnY, self.crossBtn.frame.size.width, self.crossBtn.frame.size.height);
                [self addSubview:self.crossBtn];
                i=3;
            }
            subView.frame=CGRectMake(i*btnW, btnY, btnW, btnH);
            i++;
        }
    }
}

/**
 *  十字按钮点击事件
 *
 */
-(void)crossBtnClicked:(UIButton*)btn{
    if ([self.myDelegate respondsToSelector:@selector(TarbarCrossBtnClicked:)]) {
        [self.myDelegate TarbarCrossBtnClicked:self];
    };
}
//
//-(void)addBtnInTabBar{
//    UIButton* crossBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    crossBtn.frame=CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//}

@end
