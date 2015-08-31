//
//  XWInputToolBar.m
//  XW新浪微博
//
//  Created by bbq on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWInputToolBar.h"

@interface XWInputToolBar()
@property(nonatomic,weak) UIButton* emotionBtn;
@end

@implementation XWInputToolBar
/**
 *  设置表情按钮的image
 *
 */
-(void)setShowSystemEmotionImage:(BOOL)showSystemEmotionImage{
    _showSystemEmotionImage=showSystemEmotionImage;
    if (showSystemEmotionImage) {//设置为系统键盘的图标
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_os7"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted_os7"] forState:UIControlStateHighlighted];
    }else{//设置为自定义键盘的图标
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];

    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        //传入枚举作tag
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" highIcon:@"compose_trendbutton_background_highlighted_os7" XWInputToolBarButtonType:XWInputToolBarButtonTrend];
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" highIcon:@"compose_camerabutton_background_highlighted_os7"XWInputToolBarButtonType:XWInputToolBarButtonCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" highIcon:@"compose_toolbar_picture_highlighted_os7"XWInputToolBarButtonType:XWInputToolBarButtonPhoto];
       self.emotionBtn=  [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" highIcon:@"compose_emoticonbutton_background_highlighted_os7"XWInputToolBarButtonType:XWInputToolBarButtonEmotion];
       [self addButtonWithIcon:@"compose_mentionbutton_background_os7" highIcon:@"compose_mentionbutton_background_highlighted_os7"XWInputToolBarButtonType:XWInputToolBarButtonMention];
    }
    

    return self;
}

/**
 *  添加按钮
 *
 */
-(UIButton*)addButtonWithIcon:(NSString*)normalImage highIcon:(NSString*)highIcon XWInputToolBarButtonType:(XWInputToolBarButtonType)XWInputToolBarButtonType{
    UIButton* button=[[UIButton alloc]init];
    //设置button的tag为枚举值
    button.tag=XWInputToolBarButtonType;
    [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

/**
 *  按钮点击事件
 */
-(void)btnClicked:(UIButton*)btn{
    if ([self.delegate respondsToSelector:@selector(XWInputToolBarButton:didClicked:)]) {
        [self.delegate XWInputToolBarButton:self didClicked:btn.tag];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat btnY=0;
    CGFloat btnW=self.frame.size.width/self.subviews.count;
    CGFloat btnH=self.frame.size.height;
    int count =0;
    for (UIButton* btn in self.subviews) {
   
        CGFloat btnX=count*btnW;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        count++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
