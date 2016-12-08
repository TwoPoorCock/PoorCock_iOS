//
//  AppDelegate.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/24.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    _splashView = [[NSBundle mainBundle ]loadNibNamed:@"LaunchScreenView" owner:nil options:nil][0];
    _splashView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
    [self.window addSubview:_splashView];
    [self.window bringSubviewToFront:_splashView];
//    _splashView.backgroundColor = [UIColor colorWithRed:239 green:215 blue:0 alpha:1];
    
//    欢迎页
    [self performSelector:@selector(scale_5) withObject:nil afterDelay:0.0f];
    [self performSelector:@selector(showWord) withObject:nil afterDelay:1.0f];
    
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
    
    return YES;
}

-(void)removeLun
{
    [_splashView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)scale_4
{
    UIImage* ui = [UIImage imageNamed:@"小鳄吃饭"];
    UIImageView *heart_1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.window.screen.bounds.size.width-300)/2,50,300,123)];
    heart_1.image = ui;
    [_splashView addSubview:heart_1];
    [self setAnimation:heart_1];
}

-(void)scale_5
{
    UIImage* ui = [UIImage imageNamed:@"透明E"];
    UIImageView *heart_1 = [[UIImageView alloc]initWithFrame:CGRectMake((self.window.screen.bounds.size.width-150)/2,150,150,150)];
    heart_1.image = ui;
    [_splashView addSubview:heart_1];
    [self setAnimation:heart_1];
}

-(void)setAnimation:(UIImageView *)nowView
{
    
    [UIView animateWithDuration:0.6f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         // 执行的动画code
         [nowView setFrame:CGRectMake(nowView.frame.origin.x- nowView.frame.size.width*0.1, nowView.frame.origin.y-nowView.frame.size.height*0.1, nowView.frame.size.width*1.2, nowView.frame.size.height*1.2)];
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
//         [nowView removeFromSuperview];
     }
     ];
    
    
}

-(void)showWord
{
    
//    UIImageView *word_ = [[UIImageView alloc]initWithFrame:CGRectMake((self.window.screen.bounds.size.width-150)/2, self.window.screen.bounds.size.height-50, 100, 50)];
//    word_.image = [UIImage imageNamed:@"person"];
    UILabel *word_ =[[UILabel alloc]initWithFrame:CGRectMake((self.window.screen.bounds.size.width-300)/2, self.window.screen.bounds.size.height-50, 300, 25)];
    word_.text = @"www.twopoorcick.eatfood.com";
    word_.textAlignment = NSTextAlignmentCenter;
    [_splashView addSubview:word_];
    
    word_.alpha = 0.0;
    [UIView animateWithDuration:1.0f delay:0.0f options:UIViewAnimationOptionCurveLinear
                     animations:^
     {
         word_.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         // 完成后执行code
         [NSThread sleepForTimeInterval:1.0f];
//         [_splashView removeFromSuperview];
     }
     ];
}
@end
