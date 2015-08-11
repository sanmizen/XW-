//
//  XWOriginalFrame.m
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWOriginalFrame.h"
#import "NSString+XWCacularTextSizeExtension.h"
#import "XWStatusPhotosView.h"

@implementation XWOriginalFrame

//在此计算原创微博的frame
-(void)setStatus:(XWStatus *)status{
    _status=status;
    //1.计算头像frame
    CGFloat iconX=statusMargin;
    CGFloat iconY=statusMargin;
    CGFloat iconW=35;
    CGFloat iconH=iconW;
    self.iconViewFrame=CGRectMake(iconX, iconY, iconW, iconH);
    
    //2.计算昵称frame
    CGFloat nameX=CGRectGetMaxX(self.iconViewFrame);
    CGFloat nameY=statusMargin;
    CGSize nameSize=[self.status.user.name sizeWithMaxSize:(CGSize){MAXFLOAT,MAXFLOAT} font:OriginalStatusNameFont];
    self.nameLabelFrame=CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    //3.计算时间frame
    CGFloat timeX=self.nameLabelFrame.origin.x;
    CGFloat timeY=CGRectGetMaxY(self.nameLabelFrame)+statusMargin*0.39;
    CGSize timeSize=[self.status.created_at sizeWithMaxSize:(CGSize){MAXFLOAT,MAXFLOAT} font:OriginalStatusTimeFont];
    self.timeLabelFrame=(CGRect){{timeX,timeY},timeSize};
    
    //4.来源frame
    CGFloat sourceX=CGRectGetMaxX(self.timeLabelFrame)+statusMargin;
    CGFloat sourceY=timeY;
    CGSize sourceSize=[self.status.source sizeWithMaxSize:(CGSize){MAXFLOAT,MAXFLOAT} font:OriginalStatusSourceFont];
    self.sourceLabelFrame=(CGRect){{sourceX,sourceY},sourceSize};
    
    //5.计算正文frame
    CGFloat textX=statusMargin;
    CGFloat textY=CGRectGetMaxY(self.sourceLabelFrame)+statusMargin;
    CGSize textSize=[self.status.text sizeWithMaxSize:(CGSize){[UIScreen mainScreen].bounds.size.width-2*statusMargin,MAXFLOAT} font:OriginalStatusTextFont];
    self.textLabelFrame=(CGRect){{textX,textY},textSize};
    
    //6.计算vipImage的Frame
    if (status.user.mbtype>2) {
        CGFloat vipX=CGRectGetMaxX(self.nameLabelFrame)+statusMargin;
        CGFloat vipY=nameY+1;
        CGFloat vipW=14;
        CGFloat vipH=14;
        self.vipViewFrame=CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    //7.计算大配图View的Frame
    CGFloat height=0;
    if (self.status.pic_urls.count) {
        CGFloat photosX=iconX;
        CGFloat photosY=CGRectGetMaxY(self.textLabelFrame)+statusMargin;
        CGSize photoSize=[XWStatusPhotosView sizeWithPhotoCount:(int)self.status.pic_urls.count];
        
        self.photosFrame=(CGRect){{photosX,photosY},photoSize};
        //依据配图frame计算整个original的高度
        height=CGRectGetMaxY(self.photosFrame)+statusMargin;
    }else{
    height=CGRectGetMaxY(self.textLabelFrame)+statusMargin;
    }
    
    
    //8.计算自己frame
    //originalView在父控件中x,y为0，0
CGFloat x=0;
    CGFloat y=0;
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    
    self.frame=(CGRect){{x,y},{width,height}};
    
}
@end
