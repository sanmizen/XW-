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
@implementation XWDiscoverTableViewController
-(void)viewDidLoad{
//    UITextField* searchBar=[[UITextField alloc]init];
//    searchBar.frame=CGRectMake(0, 0, 300, 30);
//    //拉伸图片
//    searchBar.background=[UIImage resizableImage:@"searchbar_textfield_background"];
//    UIButton* searchBtn=[[UIButton alloc]init];
//    [searchBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_os7"] forState:UIControlStateNormal];
//    [searchBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_discover_selected_os7"] forState:UIControlStateSelected];
//    [searchBtn sizeToFit];
//    searchBar.leftView=searchBtn;
//    searchBar.leftViewMode=UITextFieldViewModeAlways;
//    searchBar.clearButtonMode=UITextFieldViewModeAlways;
    self.navigationItem.titleView=[XWSearchBar searchBar];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID=@"me";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
@end
