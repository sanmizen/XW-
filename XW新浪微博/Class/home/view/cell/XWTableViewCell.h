//
//  XWTableViewCell.h
//  XW新浪微博
//
//  Created by bbq on 15/7/29.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWStatusFrame.h"

@interface XWTableViewCell : UITableViewCell

@property(nonatomic,strong) XWStatusFrame* statusFrame;

+(XWTableViewCell*)CellWithTableView:(UITableView*)tabView;

@end
