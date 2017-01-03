//
//  NewsWebVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/3.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import "NewsWebVC.h"
#import <WebKit/WebKit.h>

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
    NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.navigationDelegate = self;
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
