//
//  XWStatusFrame.m
//  XW新浪微博
//
//  Created by bbq on 15/7/30.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWStatusFrame.h"

@implementation XWStatusFrame


//计算各项frame...
-(void)setStatus:(XWStatus *)status{
    _status=status;
    //1.计算detailFrame
    [self setupDetailFrame];
    //2.计算toolBar的Frame
    [self setupToolBarFrame];
    //3.计算cell的高度
    self.cellHeight=CGRectGetMaxY(self.toolBarFrame);
}

/**
 *  给DetailFrame传status数据，让其在自己的setStatus方法中计算frame
 */
-(void)setupDetailFrame{
    XWDetailFrame* detailFrame= [[XWDetailFrame alloc]init];
#warning 颠倒试试...
    detailFrame.status=self.status;
    self.detailFrame=detailFrame;
    
}

/**
 *  计算toolBar的Frame
 */
-(void)setupToolBarFrame{
    CGFloat toolBarX=0;
    CGFloat toolBarY=CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolBarW=[UIScreen mainScreen].bounds.size.width;
    CGFloat toolBarH=35;
    self.toolBarFrame=CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
}


@end
