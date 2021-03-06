//
//  XWToolBarView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWToolBarView.h"

@interface XWToolBarView()

@property(nonatomic,strong) NSMutableArray* btns;
@property(nonatomic,strong) NSMutableArray* division;
@property(nonatomic,weak) UIButton* retweetBtn;
@property(nonatomic,weak) UIButton* likeBtn;
@property(nonatomic,weak) UIButton* commentBtn;
@end

@implementation XWToolBarView


-(NSMutableArray *)btns{
    if (_btns==nil) {
        self.btns=[NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)division
{
    if (_division == nil) {
        self.division = [NSMutableArray array];
    }
    return _division;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        self.retweetBtn=  [self setButtonOnToolBar:@"timeline_icon_retweet" andTitle:@"转发"];
        self.likeBtn=  [self setButtonOnToolBar:@"mmyike" andTitle:@"赞"];
        self.commentBtn= [self setButtonOnToolBar:@"timeline_icon_comment" andTitle:@"评论"];
        
    }

    return self;
}

-(UIButton*)setButtonOnToolBar:(NSString*)icon andTitle:(NSString*)title{
    UIButton* btn=[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int num=0;
    CGFloat btnY=0;
    CGFloat btnW=self.frame.size.width/(self.btns.count);
    CGFloat btnH=self.frame.size.height;
    for (UIButton* btn in self.btns) {
        CGFloat btnX=num*btnW;
        
        num++;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);

    }
    }

-(void)setStatus:(XWStatus *)status{
    _status=status;
    
    NSString* retweetStr=self.status.reposts_count?[NSString stringWithFormat:@"%d",self.status.reposts_count]:@"转发";
    [self.retweetBtn setTitle:retweetStr forState:UIControlStateNormal];
    
  NSString* likeStr= self.status.attitudes_count?[NSString stringWithFormat:@"%d",self.status.attitudes_count]:@"赞";
    [self.likeBtn setTitle:likeStr forState:UIControlStateNormal];
    
    NSString* commStr=self.status.comments_count?[NSString stringWithFormat:@"%d",self.status.comments_count]:@"评论";
    [self.commentBtn setTitle:commStr forState:UIControlStateNormal];
    
}

@end
