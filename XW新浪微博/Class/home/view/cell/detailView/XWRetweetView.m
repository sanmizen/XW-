//
//  XWRetweetView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWRetweetView.h"
#import "XWStatus.h"
#import "XWUser.h"
#import "UIImage+resizable.h"
#import "XWStatusPhotosView.h"
#import "XWStatusPhotoView.h"
#import "XWRetweetedToolBar.h"

@interface XWRetweetView()
/**
 *  昵称
 */
@property(nonatomic,weak) UILabel* nameLabel;
/**
 *  正文
 */
@property(nonatomic,weak) UILabel* textLabel;

/**
 *  配图
 */
@property(nonatomic,weak) XWStatusPhotosView* photosView;
/**
 *  toolBar
 */
@property(nonatomic,weak) XWRetweetedToolBar* toolBar;

@end


@implementation XWRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        self.image=[UIImage resizableImage:@"timeline_retweet_background"];
        //设置昵称
        UILabel* nameLabel=[[UILabel alloc]init];
        nameLabel.textColor=[UIColor greenColor];
        nameLabel.font=RetweetedStatusNameFont;
        self.nameLabel=nameLabel;
        [self addSubview:nameLabel];
        
        //设置正文
        UILabel* textLabel=[[UILabel alloc]init];
        textLabel.font=RetweetedStatusTextFont;
        textLabel.numberOfLines=0;
        self.textLabel=textLabel;
        [self addSubview:textLabel];
        
        //设置配图
        XWStatusPhotosView* photosView=[[XWStatusPhotosView alloc]init];
        self.photosView=photosView;
        [self addSubview:photosView];
        
        //设置toolBar
        XWRetweetedToolBar* toolBar=[[XWRetweetedToolBar alloc]init];
        
        self.toolBar=toolBar;
        [self addSubview:toolBar];

    }
    return self;
}

-(void)setRetweetFrame:(XWRetweetFrame *)retweetFrame{
    
    _retweetFrame=retweetFrame;
    self.frame=retweetFrame.frame;
    
    //设置昵称frame
    self.nameLabel.frame=retweetFrame.nameLabelFrame;
    //设置昵称数据
    NSString* nameStr=[NSString stringWithFormat:@"@%@",retweetFrame.retweetedStatus.user.name];
    self.nameLabel.text=nameStr;
    
    //设置正文frame
    self.textLabel.frame=retweetFrame.textLabelFrame;
    //设置正文数据
    self.textLabel.text=retweetFrame.retweetedStatus.text;
    
    //设置toolBar数据
    self.toolBar.status=retweetFrame.retweetedStatus;

        //设置toolBar frame
        self.toolBar.frame=retweetFrame.toolBarFrame;

    //设置配图view的frame
    if (retweetFrame.retweetedStatus.pic_urls.count) {
        
        self.photosView.frame=retweetFrame.photosFrame;

        self.photosView.pic_urls=retweetFrame.retweetedStatus.pic_urls;
        
        self.photosView.hidden=NO;
    }else{
        self.photosView.hidden=YES;
    }
}

@end
