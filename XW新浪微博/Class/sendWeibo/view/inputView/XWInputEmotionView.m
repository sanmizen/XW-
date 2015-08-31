//
//  XWInputEmotionView.m
//  XW新浪微博
//
//  Created by bbq on 15/8/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWInputEmotionView.h"
#import "XWEmotionListView.h"

@interface XWInputEmotionView()
@property(nonatomic,weak) XWEmotionListView* listView;
@property(nonatomic,weak) UIView* btnView;
@end


@implementation XWInputEmotionView

+(XWInputEmotionView *)GetEmotionKeyboard{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        XWEmotionListView* listView=[[XWEmotionListView alloc]init];
        [self addSubview:listView];
        self.listView=listView;
        self.listView.backgroundColor=[UIColor redColor];
        UIView* btnView=[[UIView alloc]init];
        [self addSubview:btnView];
        self.btnView.backgroundColor=[UIColor whiteColor];
        self.btnView=btnView;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    //btnView
    CGFloat btnViewX=0;
    CGFloat btnViewW=320;
    CGFloat btnViewH=45;
    CGFloat btnViewY=self.frame.size.height-btnViewH;
    self.btnView.frame=CGRectMake(btnViewX, btnViewY, btnViewW, btnViewH);
    
    //listView
    CGFloat listViewX=0;
    CGFloat listViewY=0;
    CGFloat listViewW=320;
    CGFloat listViewH=btnViewY;
    self.listView.frame=CGRectMake(listViewX, listViewY, listViewW, listViewH);
    
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
