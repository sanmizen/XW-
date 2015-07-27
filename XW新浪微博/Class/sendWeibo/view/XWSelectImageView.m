//
//  XWSelectImageView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/23.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWSelectImageView.h"

@interface XWSelectImageView()
@property(nonatomic,strong) UIImage* selectedImage;
@end

@implementation XWSelectImageView

/**
 *  添加选中的图片到该imageView
 */
-(void)addImages:(UIImage *)selectImage{
    self.selectedImage=selectImage;
   UIImageView* imageView= [[UIImageView alloc]init];
    [imageView setImage:selectImage];
    //设置不拉伸
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    //剪去多余的图片部分
    imageView.clipsToBounds=YES;
    [self addSubview:imageView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    int imagesCount=self.subviews.count;
    int numOfColumn=3;
    int margin=10;
    CGFloat imageW=(self.frame.size.width-margin*(numOfColumn+1))/numOfColumn;
    CGFloat imageH=imageW;
    for (int i=0; i<imagesCount; i++) {
        UIImageView* imageView=self.subviews[i];
        int column=i%numOfColumn;
        int row=i/numOfColumn;
        CGFloat imageX=column*(imageW+margin)+margin;
        CGFloat imageY=row*(imageH+margin)+margin;
        imageView.frame=CGRectMake(imageX, imageY, imageW, imageH);
    }
}

-(NSArray *)imageArray{
    NSMutableArray* mutableArray=[NSMutableArray array];
    for (UIImageView* imageView in self.subviews) {
        UIImage* image=imageView.image;
       [mutableArray addObject:image];
    }
     NSArray* imageArray= mutableArray;
    return imageArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
