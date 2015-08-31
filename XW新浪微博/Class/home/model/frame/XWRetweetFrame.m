//
//  XWRetweetFrame.m
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWRetweetFrame.h"
#import "XWStatusPhotosView.h"


@implementation XWRetweetFrame

-(void)setRetweetedStatus:(XWStatus *)retweetedStatus{
    _retweetedStatus=retweetedStatus;
    
    
    //1.计算昵称frame
    CGFloat nameX=statusMargin;
    CGFloat nameY=statusMargin;
    NSString* nameStr=[NSString stringWithFormat:@"@%@",self.retweetedStatus.user.name];
    CGSize nameSize=[nameStr sizeWithMaxSize:(CGSize){MAXFLOAT,MAXFLOAT} font:OriginalStatusNameFont];
    self.nameLabelFrame=CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //2.计算正文frame
    CGFloat textX=statusMargin;
    CGFloat textY=CGRectGetMaxY(self.nameLabelFrame)+statusMargin;
    CGSize textSize=[self.retweetedStatus.text sizeWithMaxSize:(CGSize){[UIScreen mainScreen].bounds.size.width-2*statusMargin,MAXFLOAT} font:RetweetedStatusTextFont];
    self.textLabelFrame=(CGRect){{textX,textY},textSize};
    
    //3.计算配图view的frame
    CGFloat toolBarY=0;
    
    if (self.retweetedStatus.pic_urls.count) {
        CGFloat photosX=textX;
        CGFloat photosY=CGRectGetMaxY(self.textLabelFrame)+statusMargin;
        CGSize photoSize=[XWStatusPhotosView sizeWithPhotoCount:(int)self.retweetedStatus.pic_urls.count];
        
        self.photosFrame=(CGRect){{photosX,photosY},photoSize};
        //如果有配图，计算toolBarframe
      toolBarY=CGRectGetMaxY(self.photosFrame)+statusMargin;
        
    }else{//如果无配图，计算toolBarframe
      toolBarY=CGRectGetMaxY(self.textLabelFrame)+statusMargin;
    }
    
    //3.计算toolBarFrame
 
        CGFloat toolBarW=200;
        CGFloat toolBarX=[UIScreen mainScreen].bounds.size.width-toolBarW;
        CGFloat toolBarH=35;
        self.toolBarFrame=CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);


    
    //4.计算自己frame
    CGFloat x=0;
    CGFloat y=0;//y值暂定为0，在detailFrame中通过original的frame计算
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
   CGFloat height=CGRectGetMaxY(self.toolBarFrame)+statusMargin;
    self.frame=(CGRect){{x,y},{width,height}};
}

@end
