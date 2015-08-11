//
//  XWOriginalView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWOriginalView.h"
#import "XWStatus.h"
#import "XWUser.h"
#import "UIImageView+WebCache.h"
#import "XWStatusPhotosView.h"


@interface XWOriginalView()
/**
 *  昵称
 */
@property(nonatomic,weak) UILabel* nameLabel;
/**
 *  正文
 */
@property(nonatomic,weak) UILabel* textLabel;
/**
 *  来源
 */
@property(nonatomic,weak) UILabel* sourceLabel;
/**
 *  时间
 */
@property(nonatomic,weak) UILabel* timeLabel;
/**
 *  头像
 */
@property(nonatomic,weak) UIImageView* iconView;
/**
 *  vip图片
 */
@property(nonatomic,weak) UIImageView* vipView;
/**
 *  配图
 */
@property(nonatomic,weak) XWStatusPhotosView* photosView;
@end

@implementation XWOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        //设置昵称
        UILabel* nameLabel=[[UILabel alloc]init];
        nameLabel.font=OriginalStatusNameFont;
        self.nameLabel=nameLabel;
        [self addSubview:nameLabel];
        
        //设置正文
        UILabel* textLabel=[[UILabel alloc]init];
        textLabel.font=OriginalStatusTextFont;
        //换行
        textLabel.numberOfLines=0;
        self.textLabel=textLabel;
        [self addSubview:textLabel];
        
        //设置来源
        UILabel* sourceView=[[UILabel alloc]init];
        sourceView.font=OriginalStatusSourceFont;
        sourceView.textColor=[UIColor lightGrayColor];
        self.sourceLabel=sourceView;
        [self addSubview:sourceView];
        
        //设置时间
        UILabel* timeLabel=[[UILabel alloc]init];
        timeLabel.font=OriginalStatusTimeFont;
        timeLabel.textColor=[UIColor orangeColor];
        self.timeLabel=timeLabel;
        [self addSubview:timeLabel];
        
        //设置头像
        UIImageView* iconView=[[UIImageView alloc]init];
        self.iconView=iconView;
        [self addSubview:iconView];
        //设置vip图片
        UIImageView* vipView=[[UIImageView alloc]init];
        vipView.contentMode=UIViewContentModeCenter;
        self.vipView=vipView;
        [self addSubview:vipView];
        
        //设置配图
        XWStatusPhotosView* photosView=[[XWStatusPhotosView alloc]init];
//        photosView.backgroundColor=[UIColor redColor];
        self.photosView=photosView;
        [self addSubview:photosView];
    }
    return self;
}

-(void)setOriginalFrame:(XWOriginalFrame *)originalFrame{
    //自己的frame
    self.frame=originalFrame.frame;
    //设置vip图标frame
    self.vipView.frame=originalFrame.vipViewFrame;

    //设置昵称frame
    self.nameLabel.frame=originalFrame.nameLabelFrame;
    //设置昵称数据
    self.nameLabel.text=originalFrame.status.user.name;
    if (originalFrame.status.user.mbtype>2) {//是会员则名字变橙色,并显示vip图片
        self.nameLabel.textColor=[UIColor orangeColor];
        self.vipView.hidden=NO;
        NSString* vipImageName=[NSString stringWithFormat:@"common_icon_membership_level%d",originalFrame.status.user.mbrank];
        self.vipView.image=[UIImage imageNamed:vipImageName];
    }else {
        self.vipView.hidden=YES;
        self.nameLabel.textColor=[UIColor blackColor];
    }
    
    //设置正文frame
    self.textLabel.frame=originalFrame.textLabelFrame;
    //设置正文数据
    self.textLabel.text=originalFrame.status.text;
    
    //设置来源frame
    self.sourceLabel.frame=originalFrame.sourceLabelFrame;
    //设置来源数据
    self.sourceLabel.text=originalFrame.status.source;
    
    //设置时间frame
    self.timeLabel.frame=originalFrame.timeLabelFrame;
    //设置时间数据
    self.timeLabel.text=originalFrame.status.created_at;
    
    //设置头像
    self.iconView.frame=originalFrame.iconViewFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:originalFrame.status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"error"]];
    
    //设置大图片View的frame
    if (originalFrame.status.pic_urls.count) {
        self.photosView.frame=originalFrame.photosFrame;
               self.photosView.pic_urls=originalFrame.status.pic_urls;
        self.photosView.hidden=NO;
    }else{
        self.photosView.hidden=YES;
    }
    
    
}

@end
