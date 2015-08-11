//
//  XWStatusPhotosView.m
//  XW新浪微博
//
//  Created by bbq on 15/8/8.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#define XWMaxphotoNum 9
#define photoW 70
#define photoMargin 10
#define photoPerRow 3
#define photoH photoW
#define HMStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)

#import "XWStatusPhotosView.h"
#import "XWStatusPhotoView.h"
#import "UIImageView+WebCache.h"

@interface XWStatusPhotosView()
@property(nonatomic,weak) UIImageView* imageView;
@property(nonatomic,weak) UIView* coverView;
@property(nonatomic,assign) CGRect lastFrame;
@end

@implementation XWStatusPhotosView



- (instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    //预先创建9个photoView
    if (self) {
        for (int i=0;i<XWMaxphotoNum ; i++) {
            XWStatusPhotoView* photoView=[[XWStatusPhotoView alloc]init];
            photoView.tag=i;
            //每个手势监听器只能监听一个控件
            UITapGestureRecognizer* tapReco=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
            [photoView addGestureRecognizer:tapReco];
            [self addSubview:photoView];
        }
    }
    return self;
}

-(void)tapImage:(UITapGestureRecognizer*)tapReco{
    //创建一个UIView蒙版
    UIView* coverView=[[UIView alloc]init];
    self.coverView=coverView;
    //给蒙版view添加手势事件
    UITapGestureRecognizer* coverTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverDidTap:)];
    [coverView addGestureRecognizer:coverTap];
    coverView.backgroundColor=[UIColor grayColor];
    coverView.frame=[UIScreen mainScreen].bounds;
    XWStatusPhotoView* photoView=(XWStatusPhotoView*)tapReco.view;
    
    //添加到窗口上
    [[UIApplication sharedApplication].keyWindow addSubview:coverView];
    UIImageView* imageView=[[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
    
//    //坐标转换
   imageView.frame= [self convertRect:tapReco.view.frame toView:coverView];
    //记下放大前的位置，方便退回时用
    self.lastFrame=imageView.frame;
    [coverView addSubview:imageView];

    self.imageView=imageView;
    //放大效果
    
    [UIView animateWithDuration:0.33 animations:^{
        CGFloat x=0;
        CGFloat w=coverView.frame.size.width;
        CGFloat h=coverView.frame.size.width*tapReco.view.frame.size.height/tapReco.view.frame.size.width;
        CGFloat y=0.5*coverView.frame.size.height-0.5*h;
        
        imageView.frame=CGRectMake(x, y, w, h);
        
    }];
}
/**
 *  蒙版view的点击事件
 *
 */
-(void)coverDidTap:(UITapGestureRecognizer*)tapReco{
    [UIView animateWithDuration:0.33 animations:^{
        //使XWStatusPhotoView回到原来frame
        self.imageView.frame=self.lastFrame;
        //去掉蒙版的颜色
        self.coverView.backgroundColor=[UIColor clearColor];
    } completion:^(BOOL finished) {
        //去除加上去的XWStatusPhotoView
        [tapReco.view removeFromSuperview];
    }];
}

-(void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls=pic_urls;
    
    for (int i=0; i<XWMaxphotoNum; i++) {
        XWStatusPhotoView* photoView=self.subviews[i];
        
        if (i<pic_urls.count) {
             photoView.photo=pic_urls[i];
            
            photoView.hidden=NO;
        }else{
            photoView.hidden=YES;
        }
    }
}

/**
 *  计算photosView的frame，并返回
 *
 */
+(CGSize)sizeWithPhotoCount:(int)photosCount{
    
    
    int photoCols=photosCount>=photoPerRow?photoPerRow:photosCount;
    int photoRows=(photosCount+photoPerRow-1)/photoPerRow;
    
    CGFloat photosW=photoW*photoCols+(photoCols-1)*photoMargin;
    CGFloat photosH=photoH*photoRows+(photoRows-1)*photoMargin;
    return (CGSize){photosW,photosH};
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    int count=self.pic_urls.count;
    int maxCols = 3;
  
    for (int i=0; i<count; i++) {
        XWStatusPhotoView* photoView=self.subviews[i];
        
        CGFloat photoX=(i%maxCols)*(photoW+photoMargin);
        CGFloat photoY=(i/maxCols)*(photoH+photoMargin);
        photoView.frame=CGRectMake(photoX, photoY, photoW, photoH);

    }
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    int count = self.pic_urls.count;
//    int maxCols = 3;
//    for (int i = 0; i<count; i++) {
//        XWStatusPhotoView *photoView = self.subviews[i];
//        
//        CGFloat photoX = (i % maxCols) * (photoW + photoMargin);
//        CGFloat photoY = (i / maxCols) * (photoH + photoMargin);
//        photoView.frame=CGRectMake(photoX, photoY, photoW, photoH);
//    }
//}

@end
