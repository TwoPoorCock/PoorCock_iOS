//
//  PersonMessageVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/25.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "PersonMessageVC.h"
#import "User.h"
#import "HttpTool.h"
#import "PrefixHeader.pch"

@interface PersonMessageVC () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *per_name;

@property (weak, nonatomic) IBOutlet UISwitch *love_meat;

@property (weak, nonatomic) IBOutlet UISwitch *love_hot;

@property (weak, nonatomic) IBOutlet UITextField *per_height;

@property (weak, nonatomic) IBOutlet UITextField *per_weight;

@property (weak, nonatomic) IBOutlet UILabel *love_mainfood;

@property (weak, nonatomic) IBOutlet UISwitch *per_weitong;

@property (weak, nonatomic) IBOutlet UISwitch *per_mouth;

@property (weak, nonatomic) IBOutlet UISwitch *per_tooth;

@property (weak, nonatomic) IBOutlet UISwitch *per_fat;
@end

@implementation PersonMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄口味";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAll:)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self setUserMessages];
}

- (void) setUserMessages
{
    User* app_user = [User getAppUser];
    
    self.per_name.text=app_user.user_name;
    [self.per_height setText:[NSString stringWithFormat:@"%@",app_user.user_height]];
    [self.per_weight setText:[NSString stringWithFormat:@"%@",app_user.user_weight]];
    [self.love_hot setOn:app_user.user_hot];
    [self.love_meat setOn:app_user.user_meat];

    self.love_mainfood.text =app_user.user_mainfood;
    [self.per_weitong setOn:app_user.user_weitong];
    [self.per_mouth setOn:app_user.user_mouth];
    [self.per_tooth setOn:app_user.user_tooth];
    [self.per_fat setOn:app_user.user_fat];
}

- (IBAction)saveAll:(id)sender {
    NSString* url = [NSString stringWithFormat:@"%@%@", SERVER_PATH, @"poolman/app/information/editPersonalInfo"];
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    User* app_user = [User getAppUser];
    [parametersDic setObject:app_user.userId forKey:@"userId"];
    [parametersDic setObject:self.per_name.text forKey:@"userName"];
    [parametersDic setObject:self.per_height.text forKey:@"height"];
    [parametersDic setObject:self.per_weight.text forKey:@"weight"];
    [parametersDic setObject:self.love_mainfood.text forKey:@"mainfood"];
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.love_meat.on] forKey:@"meat"];
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.love_hot.on] forKey:@"hot"];
    [parametersDic setObject:@"男" forKey:@"gender"];
    [parametersDic setObject:@"15647110282" forKey:@"phone"];
    
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.per_weitong.on] forKey:@"weiteng"];
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.per_mouth.on] forKey:@"kouqiangky"];
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.per_tooth.on] forKey:@"yayincx"];
    [parametersDic setObject:[NSString stringWithFormat:@"%d",self.per_fat.on] forKey:@"jianfei"];
    [self getUserMessages:parametersDic];
    [[HttpTool HttpManager] GET:url parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
        if([resultDic[@"msg"] isEqualToString:@"操作成功"]){
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"保存成功");
            
            app_user.user_name = self.per_name.text;
            //        [MBProgressHUD showToastToView:self.view withText:@"不是这个名字哦"];
        }else{
            NSLog(@"保存失败");
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"请求失败");
    }];
}
- (void)getUserMessages:(NSDictionary*) resultDic
{
    User* app_user = [User getAppUser];
    app_user.user_name = resultDic[@"userName"];
    app_user.userId = resultDic[@"userId"];
    app_user.user_meat = [resultDic[@"meat"] intValue];
    app_user.user_hot = [resultDic[@"hot"] intValue];
    app_user.user_height = resultDic[@"height"];
    app_user.user_weight = resultDic[@"weight"];
    app_user.user_mainfood = @"全都爱";
    app_user.user_weitong = [resultDic[@"weiteng"] intValue];
    app_user.user_mouth = [resultDic[@"kouqiangky"] intValue];
    app_user.user_tooth = [resultDic[@"yayincx"] intValue];
    app_user.user_fat = [resultDic[@"jianfei"] intValue];
    app_user.Letmeseesee = @"yes";
    
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self AlearChangeName];
    }
}
- (IBAction)exitLogin:(id)sender {
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController* pm = [secondStoryBoard instantiateViewControllerWithIdentifier:@"loginroot"];
    
    
    [self.navigationController presentViewController:pm animated:YES completion:nil];
}

- (void)AlearChangeName
{
    UIAlertView* nameAlertView = [[UIAlertView alloc] initWithTitle:@"改名字啊？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [nameAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField *nameField = [nameAlertView textFieldAtIndex:0];
    nameField.placeholder = @"不能为空且不大于六个字";
    [nameAlertView show];
    
    [nameField addTarget:self action:@selector(textFieldDidChangeName:) forControlEvents:UIControlEventEditingChanged];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString:@"改名字啊？"])
    {
        if (buttonIndex == 1)
        {
            UITextField *nameField = [alertView textFieldAtIndex:0];
            
            if (nameField.text.length <= 0) {
//                [self showHint:@"姓名不能为空"];
                [self AlearChangeName];
            }else{
                NSString *name = (nameField.text.length > 6 ? [nameField.text substringWithRange:NSMakeRange(0,6)] : nameField.text);
                
                _per_name.text=name;
            }
        }
    }
}
- (void)textFieldDidChangeName:(UITextField *)textField
{
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
}

@end
