//
//  XWComposeViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWComposeViewController.h"

@interface XWComposeViewController ()

@end

@implementation XWComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//   self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(left)];
//
//
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(right)];
//    self.navigationItem.rightBarButtonItem.enabled=NO;
    
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(right)];
   
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)left{
  
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)right{
    NSLog(@"send weibo");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
