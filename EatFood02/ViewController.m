//
//  ViewController.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/24.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int i=0;
    UIImage* ui = [[UIImage imageNamed:@"E_small_close"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* ui_select = [[UIImage imageNamed:@"E_small_open"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    for(UIViewController* vc in self.viewControllers){
        if(i==0){
            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"小鳄菜单" image:ui selectedImage:ui_select];
        }
        if(i==1){
            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"小鳄吃饭" image:ui selectedImage:ui_select];
        }
        if(i==2){
            vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"小鳄食讯" image:ui selectedImage:ui_select];
        }
        i++;
    }
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
