//
//  XWStatusDetailView.m
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWStatusDetailView.h"
#import "XWRetweetView.h"
#import "XWOriginalView.h"
#import "UIImage+resizable.h"

@interface XWStatusDetailView()

@property(nonatomic,weak) XWOriginalView* originalView;
@property(nonatomic,weak) XWRetweetView* retweetView;

@end

@implementation XWStatusDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        //设置原创微博内容
        [self setupOriginalView];
        //设置转发微博内容
        [self setupRetweetView];
        self.image=[UIImage resizableImage:@"timeline_card_background"];
        
    }
    return self;
}

-(void)setDetailFrame:(XWDetailFrame *)detailFrame{
    _detailFrame=detailFrame;
    
    self.frame=detailFrame.frame;
    
    //设置originalView中的Frame
    self.originalView.originalFrame=detailFrame.originalFrame;
    //设置retwteetedView中的Frame
    self.retweetView.retweetFrame=detailFrame.retweetFrame;
}

/**
 *  设置原创微博内容
 */
-(void)setupOriginalView{
 XWOriginalView* originlalView= [[XWOriginalView alloc]init];
    self.originalView=originlalView;
    [self addSubview:originlalView];
}

/**
 *  设置转发微博内容
 */
-(void)setupRetweetView{
    XWRetweetView* retweetlView= [[XWRetweetView alloc]init];
    self.retweetView=retweetlView;
    [self addSubview:retweetlView];
}



@end
