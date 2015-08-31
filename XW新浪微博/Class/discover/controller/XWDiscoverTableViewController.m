//
//  XWDiscoverTableViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/12.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWDiscoverTableViewController.h"
#import "UIImage+resizable.h"
#import "XWSearchBar.h"
#import "XWDiscoverTAbleViewGroup.h"
#import "XWDiscoverTableViewItem.h"
#import "XWDiscoverCell.h"
#import "XWArrowsItem.h"

@interface XWDiscoverTableViewController()

@property(nonatomic,strong) NSMutableArray* groups;

@end

@implementation XWDiscoverTableViewController
/**
 *  懒加载groups数组
 */
-(NSMutableArray *)groups{
    if (_groups==nil) {
        _groups=[NSMutableArray array];
    }
    return _groups;
}

/**
 *  重写init方法，使style变成grouped
 *
 */
-(instancetype)init{
   return [self initWithStyle:UITableViewStyleGrouped];
}

-(void)viewDidLoad{
    self.navigationItem.titleView=[XWSearchBar searchBar];
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    //去除每个cell之间的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
/**
 *  设置第0组内容
 */
-(void)setupGroup0{
    XWDiscoverTableViewGroup* group0=[[XWDiscoverTableViewGroup alloc]init];
  
    //设置内容
    group0.header=@"hhheee";
    group0.footer=@"footer..";
    XWDiscoverTableViewItem* hotStatus=[XWDiscoverTableViewItem itemWithIcon:@"hot_status" andTitle:@"热门微博"];
    //添加点击跳转的目标控制器
    UIViewController* testController=[[UIViewController alloc]init];
    [testController.view setBackgroundColor:[UIColor yellowColor]];
    hotStatus.destinationController=testController;
    hotStatus.subTitle=@"啦啦啦德玛西亚";
    group0.items=@[hotStatus];
    [self.groups addObject:group0];
}


/**
 *  设置第1组内容
 */
-(void)setupGroup1{
    XWDiscoverTableViewItem *gameCenter = [XWDiscoverTableViewItem itemWithIcon:@"game_center" andTitle:@"游戏中心"];
   XWDiscoverTableViewItem *near = [XWDiscoverTableViewItem itemWithIcon:@"near" andTitle:@"周边"];
       XWArrowsItem *app = [XWArrowsItem itemWithIcon:@"app" andTitle:@"应用"];
    app.operation=^(){
        NSLog(@"app。。执行");
    };
    XWDiscoverTableViewGroup* group1=[[XWDiscoverTableViewGroup alloc]init];
    group1.items=@[near,app,gameCenter];
    [self.groups addObject:group1];
    
}
/**
 *  设置第2组内容
 */
-(void)setupGroup2{
    
}

#pragma mark---tableview代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    XWDiscoverTableViewGroup* group=self.groups[section];
    return group.items.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWDiscoverCell* cell=[XWDiscoverCell cellWithTableView:tableView];
    XWDiscoverTableViewGroup* group=self.groups[indexPath.section];
    cell.item=group.items[indexPath.row];
    /**
     *  给cell传indexPath和每组总共有几行，cell根据以上信息设置背景图片
     */
    [cell setupIndexPath:indexPath andTotolRowsOfSection:group.items.count];

    return cell;
}
/**
 *  点击某行...
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   XWDiscoverTableViewGroup* group= self.groups[indexPath.section];
    XWDiscoverTableViewItem* item=group.items[indexPath.row];
    if (item.destinationController) {//如果有跳转控制器
        item.destinationController.title=item.title;
        [self.navigationController pushViewController:item.destinationController animated:YES];
    }
    if (item.operation) {//如果operation block有值则执行该block
        item.operation();
    }
}

@end
