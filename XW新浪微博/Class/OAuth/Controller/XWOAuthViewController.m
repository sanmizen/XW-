//
//  XWOAuthViewController.m
//  XW新浪微博
//
//  Created by bbq on 15/7/14.
//  Copyright (c) 2015年 bbq. All rights reserved.
//

#import "XWOAuthViewController.h"
#import "AFNetworking.h"
#import "XWAccount.h"
#import "XWOAuthTool.h"

@interface XWOAuthViewController ()

@end

@implementation XWOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建UIwebview
    UIWebView* OAuthWebView=[[UIWebView alloc]init];
    OAuthWebView.frame=self.view.bounds;
    [self.view addSubview:OAuthWebView];
    //加载OAuth网页

    NSString* OAuthStr=[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",Kclient_id,Kredirect_uri];
    NSURL* OAurl=[NSURL URLWithString:OAuthStr];
    NSURLRequest* request=[NSURLRequest requestWithURL:OAurl];
    [OAuthWebView loadRequest:request];
    OAuthWebView.delegate=self;
}

/**
 在webview发生请求之前调用该方法，返回yes则发送，no则不发送。在这个方法中拦截URL中得code
 */
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    //获取url的string
   NSString* url= request.URL.absoluteString;
//获得包含这个字符串的range结构体
    NSRange range= [url rangeOfString:@"http://www.sina.com.cn/?code="];
    if (range.location!=NSNotFound) {
        //根据range.location和range.length截取code
        NSString* code=[url substringFromIndex:range.location+range.length];
        
        [self accessToToken:code];
        //拦截到code则不加载回调页
        return  NO;
    }
    return YES;
}
/**
 获得token
 */
-(void)accessToToken:(NSString*)code{
    NSMutableDictionary* postDict=[NSMutableDictionary dictionary];
    postDict[@"client_id"]=Kclient_id;
    postDict[@"client_secret"]=Kclient_secret;
    postDict[@"grant_type"]=@"authorization_code";
    postDict[@"code"]=code;
    postDict[@"redirect_uri"]=Kredirect_uri;
    
   AFHTTPRequestOperationManager* mrg= [AFHTTPRequestOperationManager manager];
    [mrg POST:@"https://api.weibo.com/oauth2/access_token" parameters:postDict success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
        //AFN自动将json转为dict
        NSLog(@"success---%@",responseObject);
        XWAccount* account= [XWAccount accountWithDict:responseObject];
        //利用nscoder保存account对象
        [XWOAuthTool saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error-----%@",error);
        
    
    }];
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
