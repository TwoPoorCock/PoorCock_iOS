//
//  LoginVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/29.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "LoginVC.h"
#import "ViewController.h"
#import "HttpTool.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Login:(id)sender {
//    NSString str = ""
//    HttpTool* ht = [[HttpTool alloc] init];
//    [ht postHttpurl:@"" anddictionary:<#(NSMutableDictionary *)#>
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:@"haoyuze" forKey:@"user_name"];
    
    UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* viewcontroller = [MainStoryBoard instantiateViewControllerWithIdentifier:@"viewcontroller"];  //personmessagevc为viewcontroller的StoryboardId
    
//    [self.navigationController pushViewController:viewcontroller animated:YES];
    [self.navigationController presentViewController:viewcontroller animated:YES completion:nil];

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