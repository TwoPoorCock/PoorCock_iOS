//
//  RegisterVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/29.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "RegisterVC.h"
#import "HttpTool.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet UITextField *register_name;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)register:(id)sender {
    NSString* url = @"http://10.51.0.166:8080/eatfood/register?username=1233";
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:self.register_name.text forKey:@"username"];
    
    HttpTool* ht = [[HttpTool alloc] init];
    [ht postHttpurl:url anddictionary:parametersDic];
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
