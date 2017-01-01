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
#import "User.h"

@interface LoginVC ()
@property (weak, nonatomic) IBOutlet UIButton *loginBut;
@property (weak, nonatomic) IBOutlet UITextField *login_username;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"小鳄吃饭";
    
    self.login_username.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)let_me_seesee:(id)sender {
    
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"no" forKey:@"Letmeseesee"];
    User* app_user = [User getAppUser];
    app_user.user_name = @"小鳄鱼";
    app_user.Letmeseesee = @"no";
    
    UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* viewcontroller = [MainStoryBoard instantiateViewControllerWithIdentifier:@"viewcontroller"];
    [self.navigationController presentViewController:viewcontroller animated:YES completion:nil];
}
- (IBAction)Login:(id)sender {
    if([self.login_username.text isEqualToString:@""]){
        return ;
    }
//    //储存用户登录信息
//    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"haoyuze" forKey:@"user_name"];
//    //不是游客模式
//    [defaults setObject:@"yes" forKey:@"Letmeseesee"];
    User* app_user = [User getAppUser];
    app_user.user_name = self.login_username.text;
    app_user.Letmeseesee = @"yes";
    
    //获取主界面
    UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* viewcontroller = [MainStoryBoard instantiateViewControllerWithIdentifier:@"viewcontroller"];
    //模态界面推出
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

//实现textField代理方法，textField键盘弹出高度自适应
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    
    CGFloat heights = self.view.frame.size.height;
    
    // 当前点击textfield的坐标的Y值 + 当前点击textFiled的高度 - （屏幕高度- 键盘高度 - 键盘上tabbar高度）
    
    // 在这一部 就是了一个 当前textfile的的最大Y值 和 键盘的最全高度的差值，用来计算整个view的偏移量
    
    int offset = frame.origin.y + 42- ( heights - 216.0-35.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.view.frame.size.width;
    
    float height = self.view.frame.size.height;
    
    if(offset > 0)
        
    {
        
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        
        self.view.frame = rect;
        
    }
    
    [UIView commitAnimations];
    
}
//点击空白处键盘消失
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self KeyBoardHidden];
}
//点击回车键键盘消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self KeyBoardHidden];
    
    return YES;
}
//键盘消失代码
-(void) KeyBoardHidden
{
    [self.view endEditing:YES];
    
    NSTimeInterval animationDuration = 0.30f;
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    
    [UIView setAnimationDuration:animationDuration];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

@end
