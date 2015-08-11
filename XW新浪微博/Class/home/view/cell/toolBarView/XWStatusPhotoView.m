//
//  XWStatusPhotoView.m
//  XW新浪微博
//
//  Created by bbq on 15/8/8.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWStatusPhotoView.h"
#import "UIImageView+WebCache.h"

@interface XWStatusPhotoView()
@property(nonatomic,weak) UIImageView* gifView;
@end

@implementation XWStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        //设置显示模式
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds=YES;
        //gitView用该方法创建已经有size属性，大小与图片size一样
        UIImageView* gitView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        self.gifView=gitView;
        [self addSubview:gitView];
    }
    return self;
}


-(void)setPhoto:(XWPhoto *)photo{
    _photo=photo;
    //更新了，使用这个方法...
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //如果路径小写字母以gif为后缀
    if ([photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"]) {
        self.gifView.hidden=NO;
    }else{
        self.gifView.hidden=YES;
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGSize size=self.gifView.frame.size;
    CGFloat gifX=self.frame.size.width-size.width;
    CGFloat gifY=self.frame.size.height-size.height;
    self.gifView.frame=(CGRect){{gifX,gifY},size};
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
