//
//  NewsWebVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/3.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import "NewsWebVC.h"
#import <WebKit/WebKit.h>
#import "MBProgressHUD.h"

@interface NewsWebVC () <WKNavigationDelegate>

@property(nonatomic,strong) WKWebView* webView;

@end

@implementation NewsWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:self.webView];
    
    [self testLoadRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testLoadRequest{
    // 使用MBProgressHUD最重要的准则是当要执行一个耗时任务时,不能放在主线程上影响UI的刷新
    // 正确地使用方式是在主线程上创建MBProgressHUD,然后在子线程上执行耗时操作,执行完再在主线程上刷新UI
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.label.text = @"Loading";
    [hud showAnimated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://tieba.baidu.com/p/4870153021?pn=1&statsInfo=frs_pager"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        self.webView.navigationDelegate = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
    });
    
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
