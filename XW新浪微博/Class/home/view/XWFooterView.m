//
//  XWFooterView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/20.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWFooterView.h"


@interface XWFooterView()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end



@implementation XWFooterView

+(instancetype)Footer{
   
    return [[[NSBundle mainBundle]loadNibNamed:@"XWFooterView" owner:nil options:nil] firstObject];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
