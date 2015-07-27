//
//  XWInputToolBar.h
//  XW新浪微博
//
//  Created by bbq on 15/7/21.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 利用枚举作为toolBar中得tag属性
 */
typedef enum {
    XWInputToolBarButtonTrend, //话题
    XWInputToolBarButtonCamera,//拍照
    XWInputToolBarButtonPhoto,//照片
    XWInputToolBarButtonEmotion,//表情
XWInputToolBarButtonMention //@
} XWInputToolBarButtonType;

@class XWInputToolBar;

@protocol XWInputToolBarDelegate <NSObject>

@optional
-(void)XWInputToolBarButton:(XWInputToolBar*)toolBar didClicked:(XWInputToolBarButtonType)ButtonType;
@end


@interface XWInputToolBar : UIView
@property(nonatomic,weak) id<XWInputToolBarDelegate> delegate;
@end

