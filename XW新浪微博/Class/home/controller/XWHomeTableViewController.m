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
#import "AFNetworking.h"
#import "XWOAuthTool.h"
#import "XWAccount.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "XWStatus.h"
#import "XWUser.h"
#import "XWPhoto.h"
#import "XWFooterView.h"

@interface XWHomeTableViewController ()
@property(nonatomic,assign) BOOL up;
@property(nonatomic,strong) NSArray* dictArray;
@property(nonatomic,strong) NSMutableArray* statusArray;

@end

@implementation XWHomeTableViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupBtnItem];
    UIRefreshControl* refresh=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:refresh];
    [self RefreshStatus:refresh];
    [refresh addTarget:self action:@selector(RefreshStatus:) forControlEvents:UIControlEventValueChanged];
    [self downRefresh];
    }
/**
 statusArray懒加载
 */
-(NSMutableArray*)statusArray{
    if (_statusArray==nil) {
        _statusArray =[[NSMutableArray alloc]init];
    }
    return _statusArray;
}

/**
 *  设置下拉菜单
 */
-(void)downRefresh{
    self.tableView.tableFooterView=[XWFooterView Footer];
}


-(void)RefreshStatus:(UIRefreshControl*)refresh{
    AFHTTPRequestOperationManager * mrg=[AFHTTPRequestOperationManager manager];
    NSString* statusUrl=@"https://api.weibo.com/2/statuses/home_timeline.json";
    NSMutableDictionary* getDict=[NSMutableDictionary dictionary];
    XWAccount* account=[XWOAuthTool getAccount];
    getDict[@"access_token"]=account.access_token;
    getDict[@"count"]=@10;
    /**
     *  如果firstStstus不为空，则发送since_id作为参数
     */
    XWStatus* firstStstus= [self.statusArray firstObject];
    if (firstStstus) {
        getDict[@"since_id"]=firstStstus.idstr;
    }
    
    [mrg GET:statusUrl parameters:getDict success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //获得微博status的array
        self.dictArray=responseObject[@"statuses"];
        NSArray* newArray=[XWStatus objectArrayWithKeyValuesArray:self.dictArray];
        NSRange range=NSMakeRange(0, newArray.count);
        NSIndexSet* indexSet=[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusArray insertObjects:newArray atIndexes:indexSet];
        
        [self.tableView reloadData];
        //弹出新状态数
        [self showNewStatusCount:newArray.count];
        [refresh endRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [refresh endRefreshing];
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
    
    //标题按钮
    XWHomeTitleButton* btn=[[XWHomeTitleButton alloc]initWithText:@"GYW的微博" imageName:@"navigationbar_arrow_down"];
    btn.frame=CGRectMake(0, 0, 10, 50);
    //    btn.titleLabel.textAlignment=NSTextAlignmentRight;
    //    [btn setBackgroundColor:[UIColor blackColor]];
    [btn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView=btn;
    //    btn.backgroundColor=[UIColor yellowColor];

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
    self.tableView.tableFooterView.hidden=self.statusArray.count==0;
    return self.statusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* ID=@"statues";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    XWStatus* status=self.statusArray[indexPath.row];
    cell.detailTextLabel.text=status.user.name;
    cell.textLabel.text=status.text;
 

        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"cast"]];
    
   
    return cell;
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
