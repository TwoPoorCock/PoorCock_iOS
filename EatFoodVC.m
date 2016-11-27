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

@end

@implementation EatFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄吃饭";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"person"] style:UIBarButtonItemStyleDone target:self action:@selector(personMessage)];

    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.animotionView.textColor = [UIColor whiteColor];
    self.animotionView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    
    self.animotionView.minLength = 3;
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
    [self.animotionView setValue:@"鱼香肉丝"];
    [self.animotionView startAnimation];
}

@end
