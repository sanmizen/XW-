//
//  XWDetailFrame.m
//  XW新浪微博
//
//  Created by bbq on 15/7/31.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWDetailFrame.h"

@implementation XWDetailFrame

-(void)setStatus:(XWStatus *)status{
    _status=status;
    //将status复制给originalFrame中的status
    XWOriginalFrame* originalFrame=[[XWOriginalFrame alloc]init];
    originalFrame.status=status;
    self.originalFrame=originalFrame;
    
    
    //将retweetedStatus复制给retweetFrame中的retweetedStatus
    CGFloat height=0;
    if (status.retweeted_status) {//如果有转发微博
        XWRetweetFrame* retweetFrame=[[XWRetweetFrame alloc]init];
        retweetFrame.retweetedStatus=status.retweeted_status;
      CGRect f=  retweetFrame.frame;
        f.origin.y=CGRectGetMaxY(originalFrame.frame);
        retweetFrame.frame=f;
        self.retweetFrame=retweetFrame;
         height=CGRectGetMaxY(self.retweetFrame.frame);
    }else{
    height=CGRectGetMaxY(self.originalFrame.frame);
    }
    //计算自己frame
    CGFloat x=0;
    CGFloat y=0;
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    self.frame=(CGRect){{x,y},{width,height}};
   
}

@end
