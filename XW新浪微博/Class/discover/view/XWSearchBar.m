//
//  XWSearchBar.m
//  XW新浪微博
//
//  Created by bbq on 15/7/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWSearchBar.h"
#import "UIImage+resizable.h"

@implementation XWSearchBar

/**
 *  init方法内部会调用initWithFrame，故创建SearchBar代码写在这里
 *
 *
 */
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        self.frame=CGRectMake(0, 0, 300, 30);
        //拉伸图片
        self.background=[UIImage resizableImage:@"searchbar_textfield_background"];
        UIButton* searchBtn=[[UIButton alloc]init];
        [searchBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_os7"] forState:UIControlStateNormal];
        [searchBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_selected_os7"] forState:UIControlStateSelected];
        [searchBtn sizeToFit];
        self.leftView=searchBtn;
        self.leftViewMode=UITextFieldViewModeAlways;
        self.clearButtonMode=UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar{
    return [[self alloc]init];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
