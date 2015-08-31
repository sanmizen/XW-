//
//  XWNavigationController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWNavigationController.h"

@interface XWNavigationController ()

@end

@implementation XWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/**
 *  程序第一次使用这个类时执行一次下面的方法，且只有一次！！！
 */
+(void)initialize{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];

//   UIBarButtonItem*appear= [UIBarButtonItem appearance];
//    
//    NSMutableDictionary* normolDict=[NSMutableDictionary dictionary];
//    
//    //设置正常时为橙色
//    normolDict[NSForegroundColorAttributeName]=[UIColor orangeColor];
//    //下面方法在ios7以后不推荐，用上面的key
////    appDict[UITextAttributeTextColor]=[UIColor orangeColor];
////    [appear setTitleTextAttributes:normolDict forState:UIControlStateNormal];
//    //设置不可用时为灰色
////    NSMutableDictionary* disabledDict=[NSMutableDictionary dictionary];
////    disabledDict[NSForegroundColorAttributeName]=[UIColor blueColor];
////    [appear setTitleTextAttributes:disabledDict forState:UIControlStateHighlighted];
//    
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:normolDict];
//    disableTextAttrs[UITextAttributeTextColor] = [UIColor yellowColor];
//    [appear setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //如栈中子控制器数量不等于0，才隐藏BottomBar
    if (self.viewControllers.count!=0) {
        viewController.hidesBottomBarWhenPushed=YES;
    }
    [super pushViewController:viewController animated:animated];
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
