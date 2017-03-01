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
#import "MBProgressHUD.h"
#import "MBProgressHUD+Toast.h"

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
}

- (IBAction)let_me_seesee:(id)sender {
    User* app_user = [User getAppUser];
    app_user.user_name = @"小鳄鱼";
    app_user.Letmeseesee = @"no";
    
    UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* viewcontroller = [MainStoryBoard instantiateViewControllerWithIdentifier:@"viewcontroller"];
    [self.navigationController presentViewController:viewcontroller animated:YES completion:nil];
    [MBProgressHUD showToastToView:self.view withText:@"试用成功"];
}
- (IBAction)Login:(id)sender {
    if([self.login_username.text isEqualToString:@""]){
        [MBProgressHUD showToastToView:self.view withText:@"你到底叫啥？"];
        return ;
    }
    
    NSString* url = @"http://123.57.64.99/poolman/app/login";
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:self.login_username.text forKey:@"userName"];
    [parametersDic setObject:self.login_username.text forKey:@"passWord"];
    
    [[HttpTool HttpManager] GET:url parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
        if([resultDic[@"msg"] isEqualToString:@"操作成功"]){
            User* app_user = [User getAppUser];
            app_user.user_name = resultDic[@"data"][@"UserNotice"][@"userName"];
            app_user.userId = resultDic[@"data"][@"UserNotice"][@"id"];
            app_user.Letmeseesee = @"yes";
            [MBProgressHUD showToastToView:self.view withText:@"登录成功"];
            //获取主界面
            UIStoryboard *MainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ViewController* viewcontroller = [MainStoryBoard instantiateViewControllerWithIdentifier:@"viewcontroller"];
            //模态界面推出
            [self.navigationController presentViewController:viewcontroller animated:YES completion:nil];
        }else{
            [MBProgressHUD showToastToView:self.view withText:@"不是这个名字哦"];
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
    
}

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
