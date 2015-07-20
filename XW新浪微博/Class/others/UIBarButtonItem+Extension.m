//
//  UIBarButtonItem+Extension.m
//  XW新浪微博
//
//  Created by bbq on 15/7/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
/**
 *  将创建UIBarButtonItem的代码封装进分类中
 */
@implementation UIBarButtonItem (Extension)
+(UIBarButtonItem *)itemWithImageName:(NSString *)normalImageName highlightImageName:(NSString *)highlightImageName target:(id)target selector:(SEL)selector{
     //使用自定义button作为leftBarButton
UIButton* Button=[[UIButton alloc]init];
[Button setBackgroundImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
[Button setBackgroundImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
CGSize btnSize=Button.currentBackgroundImage.size;
//前缀有得left或者right控件已经固定origin,所以设置什么都没用！！！
Button.frame=CGRectMake(0, 0, btnSize.width, btnSize.height);
    [Button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:Button];
}




@end
