//
//  XWComposeViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/13.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWComposeViewController.h"
#import "XWsendWeiboTextView.h"
#import "XWInputToolBar.h"
#import "XWSelectImageView.h"
#import "AFNetworking.h"
#import "XWAccount.h"
#import "XWAccountTool.h"
#import "MBProgressHUD+MJ.h"

@interface XWComposeViewController ()<XWInputToolBarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,weak) UITextView* textView;
@property(nonatomic,weak) XWInputToolBar* inputToolBar;
@property(nonatomic,weak) XWSelectImageView* selectImageView;
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
    //设置顶上的那啥啥啥
    [self setupHeader];
    //设置中间的输入的那啥东西
     [self setupLabel];
    //设置输入框上边的工具条
    [self setToolBar];
    self.textView.delegate=self;
    //textview垂直方向上总是有弹簧(总是可以滚动)
    self.textView.alwaysBounceVertical=YES;
    //设置选中图片后的界面
    [self setupSelectImageView];
}

/**
 *  设置选中图片后的界面
 */
-(void)setupSelectImageView{
    XWSelectImageView* selectImageView=[[XWSelectImageView alloc]init];
    selectImageView.frame=CGRectMake(0, 100, self.view.frame.size.width, 400);

    self.selectImageView=selectImageView;
    [self.view addSubview:selectImageView];
}

/**
 *  view显示后让textView成为第一响应者
 */
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置输入框上边的工具条

-(void)setToolBar{
  XWInputToolBar* inputBar  = [[XWInputToolBar alloc]init];
    inputBar.delegate=self;
    self.inputToolBar=inputBar;
    inputBar.frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
    self.textView.inputAccessoryView=inputBar;
//    self.textView.inputAccessoryView=[UIButton buttonWithType:UIButtonTypeContactAdd];
}

-(void)setupLabel{
    XWsendWeiboTextView* textView=[[XWsendWeiboTextView alloc]init];
    textView.delegate=self;
    self.textView=textView;
    textView.frame=CGRectMake(0, 0, self.view.frame.size.width, 100);;
//    textView.backgroundColor=[UIColor blueColor];
    textView.placeholderText=@"分享汝大爷...";
    [self.view addSubview:textView];
}

-(void)setupHeader{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(left)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(right)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

/**
 *  左边取消按钮
 */
-(void)left{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  右边发送按钮
 */
-(void)right{
    if (self.selectImageView.imageArray.count==0) {//无图片
        [self sendStatusWithoutImages];
        NSLog(@"无图片");
    }else{
        [self sendStatusWithImages];
      NSLog(@"有图片");//有图片
    }
}

#pragma mark---XWInputToolBar的代理方法

-(void)XWInputToolBarButton:(XWInputToolBar *)toolBar didClicked:(XWInputToolBarButtonType)ButtonType{
    switch (ButtonType) {
        case XWInputToolBarButtonCamera:
            NSLog(@"Camera");
            break;
        case XWInputToolBarButtonEmotion:
            NSLog(@"Emotion");
            break;
        case XWInputToolBarButtonPhoto:
            [self openAlbum];
            NSLog(@"openAlbum");
            break;
        default:
            break;

    }
}

//利用modal打开照片选择界面
-(void)openAlbum{
    UIImagePickerController* ipc=[[UIImagePickerController alloc]init];
    ipc.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate=self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark --scrollView的代理方法
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.textView endEditing:YES];
}

#pragma mark--imagePickerController的代理方法，在选中后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //取出选中图片
    UIImage* pickedImage=info[UIImagePickerControllerOriginalImage];
    /**
     *  加入选中图片
     */
    [self.selectImageView addImages:pickedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",info);
}

#pragma mark--textView的代理方法，textview有文字时发送按钮可用！！
-(void)textViewDidChange:(UITextView *)textView{
    self.navigationItem.rightBarButtonItem.enabled=self.textView.text.length;
}

/**
 *  post发送一条无图片微博
 */
-(void)sendStatusWithoutImages{
    NSMutableDictionary* postDict=[NSMutableDictionary dictionary];
    XWAccount* account=[XWAccountTool getAccount];
    postDict[@"access_token"]=account.access_token;
    postDict[@"status"]=self.textView.text;
   AFHTTPRequestOperationManager* mrg= [AFHTTPRequestOperationManager manager];
    [mrg POST:@"https://api.weibo.com/2/statuses/update.json" parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"成功！！"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  post发送一条有图片的微博
 */
-(void)sendStatusWithImages{
    NSMutableDictionary* postDict=[NSMutableDictionary dictionary];
    XWAccount* account=[XWAccountTool getAccount];
    postDict[@"access_token"]=account.access_token;
    postDict[@"status"]=self.textView.text;
    AFHTTPRequestOperationManager* mrg= [AFHTTPRequestOperationManager manager];
[mrg POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:postDict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    UIImage* image=[self.selectImageView.imageArray firstObject];
    //图片转nsdata
    NSData* data=UIImageJPEGRepresentation(image, 0.8);
    //拼接data 其中name为服务器接受的参数
    [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [MBProgressHUD showSuccess:@"成功！！"];
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];
    //把发微博界面退出
    [self dismissViewControllerAnimated:YES completion:nil];

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
