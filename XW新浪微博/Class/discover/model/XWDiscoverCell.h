//
//  XWDiscoverCell.h
//  XW新浪微博
//
//  Created by bbq on 15/8/15.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWDiscoverTableViewItem;
@interface XWDiscoverCell : UITableViewCell

+(XWDiscoverCell*)cellWithTableView:(UITableView*)tableView;

-(void)setupIndexPath:(NSIndexPath*)indexPath andTotolRowsOfSection:(int)totolRows;

@property(nonatomic,strong) XWDiscoverTableViewItem* item;

@end
