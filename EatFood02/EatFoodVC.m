//
//  EatFoodVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/25.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "EatFoodVC.h"
#import "PersonMessageVC.h"
#import "JTNumberScrollAnimatedView.h"

@interface EatFoodVC ()
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *animotionView;
@property (strong, nonatomic) NSString* islogin;

//plist文件解档归档
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSArray *arr;
@end

@implementation EatFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄吃饭";
    
    self.animotionView.textColor = [UIColor whiteColor];
    self.animotionView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    //动画最少几个字
    self.animotionView.minLength = 1;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.islogin = [defaults objectForKey:@"Letmeseesee"];//根据键值取出name
    
    if([self.islogin isEqual:@"no"]){
        
    }else{
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"person"] style:UIBarButtonItemStyleDone target:self action:@selector(personMessage)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
    //plist文件解档
    self.path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    self.filePath = [self.path stringByAppendingPathComponent:@"PersonLove.plist"];
    self.arr = [NSArray arrayWithContentsOfFile:self.filePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)personMessage{
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonMessageVC* pm = [secondStoryBoard instantiateViewControllerWithIdentifier:@"personmessagevc"];  //personmessagevc为viewcontroller的StoryboardId

    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pm animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)select_cai:(id)sender {
    int value = (arc4random() % [_arr count]);
    [self.animotionView setValue:[self.arr[value] objectForKey:@"cainame"]];
    [self.animotionView startAnimation];
}

@end
