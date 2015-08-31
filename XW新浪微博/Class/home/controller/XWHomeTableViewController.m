//
//  XWHomeTableViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/11.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWHomeTableViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "XWHomeTitleButton.h"
#import "XWAccountTool.h"
#import "XWAccount.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "XWStatus.h"
#import "XWUser.h"
#import "XWPhoto.h"
#import "XWFooterView.h"
#import "MJRefresh.h"
#import "XWHomeStatusTool.h"
#import "XWHomeStatusPara.h"
#import "XWHomeStatusResult.h"
#import "XWUserInfoPara.h"
#import "XWUserInfoTool.h"
#import "NSString+XWCacularTextSizeExtension.h"
#import "XWStatusFrame.h"
#import "XWTableViewCell.h"
#import "XWStatusDetailTableViewController.h"


@interface XWHomeTableViewController ()
@property(nonatomic,assign) BOOL up;
@property(nonatomic,strong) NSArray* dictArray;
@property(nonatomic,strong) NSMutableArray* statusFrameArray;
@property(nonatomic,weak) XWHomeTitleButton* titleBtn;
@end

@implementation XWHomeTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupBtnItem];
    UIRefreshControl* refresh=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:refresh];
    //首次加载
    [self RefreshStatus:refresh];
    [refresh addTarget:self action:@selector(RefreshStatus:) forControlEvents:UIControlEventValueChanged];
    //使用MJ框架实现下拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(refreshOldStatus)];
    //设置标题文字为用户昵称
    [self setupTitleText];

    
    //去掉cell之间的分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor lightGrayColor];
    }
/**
 statusArray懒加载
 */
-(NSMutableArray*)statusFrameArray{
    if (_statusFrameArray==nil) {
        _statusFrameArray =[[NSMutableArray alloc]init];
    }
    return _statusFrameArray;
}

/**
 *  设置标题文字为用户昵称
 */
-(void)setupTitleText{
//    AFHTTPRequestOperationManager * mrg=[AFHTTPRequestOperationManager manager];
//    NSString* url=@"https://api.weibo.com/2/users/show.json";
//    NSMutableDictionary* getDict=[NSMutableDictionary dictionary];
//    XWAccount* account=[XWAccountTool getAccount];
//    getDict[@"access_token"]=account.access_token;
//    getDict[@"uid"]=account.uid;
//    [mrg GET:url parameters:getDict success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
//        XWUser* user=[XWUser objectWithKeyValues:responseObject];
//            [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
//        account.userName=user.name;
//        //归档userName
//        [XWAccountTool saveAccount:account];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
    XWAccount* account=[XWAccountTool getAccount];
    XWUserInfoPara* para=[[XWUserInfoPara alloc]init];
    para.access_token=account.access_token;
    para.uid=account.uid ;
    
    [XWUserInfoTool getUserInfo:para success:^(XWUser *result) {
    [self.titleBtn setTitle:result.name forState:UIControlStateNormal];
    account.userName=result.name;
    //归档userName
    [XWAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


/**
 *  设置上拉刷新旧数据
 */
-(void)refreshOldStatus{

    XWAccount* account=[XWAccountTool getAccount];
    XWHomeStatusPara* para=[[XWHomeStatusPara alloc]init];
    para.access_token=account.access_token;
    //para是NSnumber
    para.count=@5;
    
    XWStatusFrame* lastObjectStatusFrame=[self.statusFrameArray lastObject];
    XWStatus* lastObjectStatus=lastObjectStatusFrame.status;
    para.max_id= @([lastObjectStatus.idstr longLongValue]-1);

    [XWHomeStatusTool loadWeiboStatus:para success:^(XWHomeStatusResult *result) {
        [self.tableView footerEndRefreshing];
        //status数组转statusArray数组
        [self.statusFrameArray addObjectsFromArray:[self statusFrameWithStatus:result.statuses]];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

/**
 *  status数组转statusFrame数组
 *
 */
-(NSArray*)statusFrameWithStatus:(NSArray*)statuses{
//    XWStatus* sta=statuses[1];
//    NSLog(@"%@",sta.user.name);
    NSMutableArray* tempArray=[NSMutableArray array];
    for (XWStatus* sta in statuses) {
       
        XWStatusFrame* frame=[[XWStatusFrame alloc]init];
        //传递status数据,进行计算
        frame.status=sta;
        [tempArray addObject:frame];
    }
    return tempArray;
}

//下拉刷新新数据
-(void)RefreshStatus:(UIRefreshControl*)refresh{
    
    XWAccount* account=[XWAccountTool getAccount];
    XWHomeStatusPara* para=[[XWHomeStatusPara alloc]init];
    para.access_token=account.access_token;
    //para是NSnumber
    para.count=@10;
    
    XWStatusFrame* firstStatusFrame=[self.statusFrameArray firstObject];
    XWStatus* firstStatus=firstStatusFrame.status;
        if (firstStatus) {
            para.since_id=@([firstStatus.idstr longLongValue]);
        }
    
    [XWHomeStatusTool loadWeiboStatus:para success:^(XWHomeStatusResult *result) {
        NSArray* newFrames=[self statusFrameWithStatus:result.statuses];
        NSRange range=NSMakeRange(0, newFrames.count);
        NSIndexSet* indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
         // 把最新的微博数插入到最前面
        [self.statusFrameArray insertObjects:newFrames atIndexes:indexSet];

        [self.tableView reloadData];
        //弹出新状态数
        [self showNewStatusCount:newFrames.count];
        [refresh endRefreshing];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

/**
 弹出新状态提示
 */
-(void)showNewStatusCount:(int)count{
    UILabel* countLable=[[UILabel alloc]init];
    //设置背景色
    countLable.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    //设置文字
    if (count) {
        countLable.text=[NSString stringWithFormat:@"有%d条新微博",count];
    }else{
        countLable.text=@"没有新数据";
    }
    //设置frame
    CGFloat lableX=0;
    CGFloat lableH=35;
    CGFloat lableY=64-lableH;
    CGFloat lableW=self.view.frame.size.width;
    countLable.frame=CGRectMake(lableX, lableY, lableW, lableH);
    //设置文字对齐
    countLable.textAlignment=NSTextAlignmentCenter;
    //设置文字颜色为白色
    [countLable setTextColor:[UIColor whiteColor]];
    //添加到导航控制器的view，并放在navigationBar下面
    [self.navigationController.view insertSubview:countLable belowSubview:self.navigationController.navigationBar];
    //弹出动画
    [UIView animateWithDuration:1.0 animations:^{
        countLable.transform=CGAffineTransformMakeTranslation(0, countLable.frame.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            countLable.transform=CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [countLable removeFromSuperview];
        }];
    }];
}


-(void)setupBtnItem{
    //将创建UIBarButtonItem的代码封装进分类中
    self.navigationItem.leftBarButtonItem= [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" highlightImageName:@"navigationbar_friendsearch_highlighted" target:self selector:@selector(left)];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navigationbar_pop" highlightImageName:@"navigationbar_pop_highlighted" target:self selector:@selector(right)];
    //从归档中读取userName，如果userName没有值则用HOME
    XWAccount* account=[XWAccountTool getAccount];
    NSString* userName=account.userName?account.userName:@"HOME";
    //标题按钮
    XWHomeTitleButton* btn=[[XWHomeTitleButton alloc]initWithText:userName imageName:@"navigationbar_arrow_down"];
    self.titleBtn=btn;
    btn.frame=CGRectMake(0, 0, 10, 50);
    //    btn.titleLabel.textAlignment=NSTextAlignmentRight;
    //    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=btn;


}

-(void)titleBtnClicked:(UIButton*)btn{
    //标题被点击后图片旋转180°
[UIView animateWithDuration:0.4 animations:^{
    if (self.up) {
        btn.imageView.transform=CGAffineTransformIdentity;
        self.up=NO;
    }else{
        btn.imageView.transform=CGAffineTransformMakeRotation(M_PI);
        self.up=YES;
    }
}];
    
}

-(void)left{
//    NSLog(@"left!");
}
-(void)right{
//    NSLog(@"right!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    self.tableView.tableFooterView.hidden=self.statusFrameArray.count==0;
    return self.statusFrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XWTableViewCell* cell=[XWTableViewCell CellWithTableView:tableView];
    cell.statusFrame=self.statusFrameArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XWStatusFrame* StatusFrame=self.statusFrameArray[indexPath.row];
    return StatusFrame.cellHeight+10;
}

/**
 *  点击某行进入微博详情界面
 *
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XWStatusDetailTableViewController* detailController=[[XWStatusDetailTableViewController alloc]init];
    XWStatusFrame* statusFrame= self.statusFrameArray[indexPath.row];
    detailController.status=statusFrame.status;
    [self.navigationController pushViewController:detailController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
