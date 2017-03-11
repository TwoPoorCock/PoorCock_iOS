//
//  RegisterVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/29.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "RegisterVC.h"
#import "HttpTool.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+Toast.h"
#import "PrefixHeader.pch"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *register_name;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)register:(id)sender {
    NSString* url = [NSString stringWithFormat:@"%@%@", SERVER_PATH, @"poolman/app/register"];
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:self.register_name.text forKey:@"userName"];
    [parametersDic setObject:self.register_name.text forKey:@"passWord"];
    
    [[HttpTool HttpManager] GET:url parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
        if([resultDic[@"msg"] isEqualToString:@"用户已存在"]){
            [MBProgressHUD showToastToView:self.view withText:@"用户已存在"];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD showToastToView:self.view withText:@"注册成功"];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

@end
