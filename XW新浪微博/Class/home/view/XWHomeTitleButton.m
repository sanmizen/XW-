//
//  XWHomeTitleButton.m
//  XW新浪微博
//
//  Created by bbq on 15/7/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWHomeTitleButton.h"

@interface XWHomeTitleButton()
@property(nonatomic,strong) NSString* titleText;

@end


@implementation XWHomeTitleButton



-(instancetype)initWithText:(NSString*)text imageName:(NSString*)imageName{
    if (self=[super init]) {
        [self setTitle:text forState:UIControlStateNormal];
        self.titleText=text;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment=NSTextAlignmentRight;
        self.titleLabel.font=[UIFont systemFontOfSize:18];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted=NO;
//        self.imageView.contentMode=UIViewContentModeCenter;
//        self.frame=CGRectMake(0, 0, 50, 50);
        
    }
    return self;
}



-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX=0;
    CGFloat titleY=0;
    CGFloat titleH=contentRect.size.height;
    NSString* text= self.currentTitle;
    CGSize size=CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGFloat titleW= [self sizeWithText:text MaxSize:size font:[UIFont systemFontOfSize:18]].width;
    return  CGRectMake(titleX, titleY, titleW, titleH);
}
//设置imageView的rect
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY=0;
    CGFloat imageW=13;
    CGFloat imageH=contentRect.size.height;
    CGFloat imageX=contentRect.size.width-10;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGSize)sizeWithText:(NSString*)text MaxSize:(CGSize)maxSize font:(UIFont*)font{
    NSDictionary* fontDict=@{NSFontAttributeName:font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil].size;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
