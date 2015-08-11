//
//  XWTabBarViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/8.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWTabBarViewController.h"
#import "XWTabBar.h"
#import "XWMsgTableViewController.h"
#import "XWNavigationController.h"
#import "XWHomeTableViewController.h"
#import "XWMeTableViewController.h"
#import "XWDiscoverTableViewController.h"
#import "XWComposeViewController.h"
#import "XWGetUnreadTool.h"
#import "XWAccount.h"
#import "XWAccountTool.h"
#import "XWUnreadCountPara.h"
#import "XWUnreadCountResult.h"

@interface XWTabBarViewController ()
@property(nonatomic,weak) XWHomeTableViewController* home;
@property(nonatomic,weak) XWMsgTableViewController* msg;
@end

@implementation XWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildView];
    XWTabBar* xwtabBar=[[XWTabBar alloc]initWithFrame:self.tabBar.frame];
    //设置代理对象
    xwtabBar.myDelegate=self;
    /**
     利用KVC把系统barBar代替为自定义的XWTabBar
     */
    [self setValue:xwtabBar forKeyPath:@"tabBar"];
    //利用定时器向服务器取得未读数
   NSTimer* timer= [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    //允许主线程在处理UI时也处理timer
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
   //允许icon上显示badge的
    [self badgeNotification];

}
/**
 *  允许icon上显示badge的通知
 */
-(void)badgeNotification{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:myTypes categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    }
}

/**
 *  从服务器获取未读数，并显示到tabbarItem上
 */
-(void)getUnreadCount{
    XWAccount* account=[XWAccountTool getAccount];
    XWUnreadCountPara* para=[[XWUnreadCountPara alloc]init];
    para.access_token=account.access_token;
    para.uid=account.uid;
    [XWGetUnreadTool getUnreadCount:para success:^(XWUnreadCountResult *result) {

        if (result.status==0) {
            self.home.tabBarItem.badgeValue=nil;
        }else{
            self.home.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",result.status];
            [UIApplication sharedApplication].applicationIconBadgeNumber=result.status;
        }
     
        if ([result getUnreadMsgCount]==0) {
            self.msg.tabBarItem.badgeValue=nil;
        }else{
            self.msg.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",[result getUnreadMsgCount]];
        }
//        NSLog(@"status---%d,MsgCount---%d",result.status,[result getUnreadMsgCount]);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void)addOneView:(UIViewController*)vC title:(NSString*)title imageName:(NSString*)imageName selectedImageName:(NSString*)selectedImageName{
    //既设置navigation的title又设置tabbarbutton的title
    vC.title=title;
    vC.tabBarItem.image=[UIImage imageNamed:imageName];
    UIImage* selectedImage=[UIImage imageNamed:selectedImageName];
    /**
     *  设置图标不进行自动渲染
     */
    
    /**
     *  设置tarBarItem中字体颜色
     */
    [vC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    vC.tabBarItem.selectedImage=[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //新建一个自定义navigationcontroller并设置其RootViewController
    XWNavigationController* navi=[[XWNavigationController alloc]initWithRootViewController:vC];
    //将RootViewController作为tabbarcontroller的子控制器
    [self addChildViewController:navi];

}

/**
 *  添加所有子view
 */
-(void)setUpAllChildView{
    XWHomeTableViewController* home=[[XWHomeTableViewController alloc]init];
    [self addOneView:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home=home;
    XWMsgTableViewController* message=[[XWMsgTableViewController alloc]init];
    [self addOneView:message title:@"消息" imageName:@"tabbar_message_center_os7" selectedImageName:@"tabbar_message_center_selected_os7"];
    self.msg=message;
    XWDiscoverTableViewController* find=[[XWDiscoverTableViewController alloc]init];
    [self addOneView:find title:@"发现" imageName:@"tabbar_discover_selected_os7" selectedImageName:@"tabbar_discover_selected_os7"];
    
    XWMeTableViewController* me=[[XWMeTableViewController alloc]init];
    [self addOneView:me title:@"我" imageName:@"tabbar_profile_os7" selectedImageName:@"tabbar_profile_selected_os7"];
}
/**
 *  利用代理弹出modal
 *
 */
-(void)TarbarCrossBtnClicked:(XWTabBar *)tabBar{
    XWComposeViewController* compose=[[XWComposeViewController alloc]init];
   XWNavigationController*navC= [[XWNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:navC animated:YES completion:nil];
}
@end
