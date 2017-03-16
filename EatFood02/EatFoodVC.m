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
#import "User.h"
#import "pickViewController.h"
#import "HttpTool.h"
#import "PrefixHeader.pch"
#import "EatHealthy.h"

@interface EatFoodVC () <UIAlertViewDelegate,pickViewDelegate>
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *animotionView;
@property (weak, nonatomic) IBOutlet UILabel *menuName;

//plist文件解档归档
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSArray *arr;
//被选中的菜品
@property (strong, nonatomic) NSDictionary *beSelectDic;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@end

@implementation EatFoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄吃饭";
    
    self.animotionView.textColor = [UIColor whiteColor];
    self.animotionView.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:42];
    //动画最少几个字
    self.animotionView.minLength = 1;
    
    User* app_user = [User getAppUser];
    
    if([app_user.Letmeseesee isEqual:@"no"]){
        
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

    //隐藏、显示工具栏
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pm animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
- (IBAction)select_cai:(id)sender {
    //选菜按钮不可连续点击
    self.selectButton.enabled = NO;
    if([_arr count]==0){
        [self.animotionView setValue:@"菜单为空"];
        //选菜按钮可以再次点击
        self.selectButton.enabled = YES;
    }
    else{
        
        NSArray *eatHealthyFoodArray = [EatHealthy getHealthyFoodArray:_arr];
        if([eatHealthyFoodArray count]==0||eatHealthyFoodArray==nil){
            int value = (arc4random() % [_arr count]);
            self.beSelectDic = self.arr[value];
            [self.animotionView setValue:[self.arr[value] objectForKey:@"dishname"]];
//            NSLog(@"菜单没有健康菜");
        }else{
            int value = (arc4random() % [eatHealthyFoodArray count]);
            self.beSelectDic = eatHealthyFoodArray[value];
            [self.animotionView setValue:[eatHealthyFoodArray[value] objectForKey:@"dishname"]];
//            NSLog(@"菜单有健康菜");
        }
        
        [self.animotionView startAnimation];
        
        User* app_user = [User getAppUser];
        if([app_user.Letmeseesee isEqualToString:@"yes"]){
            //开始动画后1.5秒弹出确认框
            [self performSelector:@selector(confirmCai) withObject:nil afterDelay:1.5f];
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self selectMenu];
    }
}

- (void) selectMenu{
    pickViewController *pick = [[pickViewController alloc] initWithNibName:@"pickViewController" bundle:nil];
    pick.delegate = self;
    pick.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:pick animated:YES completion:nil];
}
- (void)getTextStr:(NSString *)text{
    //字符串拼接较好办法
    self.menuName.text=[@"当前菜单：" stringByAppendingString:text];
    
    if([self.menuName.text isEqualToString:@"当前菜单：内蒙古财经大学食堂菜单"]){
        //http网络请求
        [self askForSchhol];
    }else if([self.menuName.text isEqualToString:@"当前菜单：小鳄喜欢的菜单"]){
        //plist文件解档
        self.path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        self.filePath = [self.path stringByAppendingPathComponent:@"PersonLove.plist"];
        self.arr = [NSArray arrayWithContentsOfFile:self.filePath];
    }else if ([self.menuName.text isEqualToString:@"当前菜单：历史菜单"]){
        //plist文件解档
        self.path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        self.filePath = [self.path stringByAppendingPathComponent:@"HistoryMenu.plist"];
        self.arr = [NSArray arrayWithContentsOfFile:self.filePath];
    }
}
//校园菜单网络请求
- (void) askForSchhol{
    NSString* url = [NSString stringWithFormat:@"%@%@", SERVER_PATH, @"poolman/app/menu/getSystemMenuList"];
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:@"1" forKey:@"pageNo"];
    [parametersDic setObject:@"15" forKey:@"pageSize"];
    
    [[HttpTool HttpManager] GET:url parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
        self.arr = resultDic[@"data"][@"Find"];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"1234567890-=");
    }];
}
- (void) confirmCai{
    
    UIAlertView* selectCaiAlertView = [[UIAlertView alloc] initWithTitle:@"你确定就吃它啊～～～" message:@"确定后将加入历史菜单" delegate:self cancelButtonTitle:@"换一个" otherButtonTitles:@"就吃它", nil];
    
    [selectCaiAlertView setAlertViewStyle:UIAlertViewStyleDefault];
    [selectCaiAlertView show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if([alertView.title isEqualToString:@"你确定就吃它啊～～～"]){
        
        if (buttonIndex == 1){
            //plist文件解档
            //历史菜单菜品plist文件
            NSString *historypath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
            NSString *historyfilePath = [historypath stringByAppendingPathComponent:@"HistoryMenu.plist"];
            NSArray *historyarr = [NSArray arrayWithContentsOfFile:historyfilePath];
            if(historyarr==nil){
                historyarr = [[NSArray alloc] init];
            }
            NSMutableArray *myhistoryMutableArray = [historyarr mutableCopy];
            //把被选中的菜的详细信息导入历史菜单中
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [self.beSelectDic objectForKey:@"dishname"], @"dishname",
                                 [self.beSelectDic objectForKey:@"flagH"], @"flagH",
                                 [self.beSelectDic objectForKey:@"flagR"], @"flagR",
                                 [NSString stringWithFormat: @"time"], @"eattime",
                                 nil];
            [myhistoryMutableArray addObject:dic];
            NSLog(@"%@", myhistoryMutableArray);
            NSArray *myhistoryArray = [myhistoryMutableArray copy];
            
            //plist文件归档
            [myhistoryArray writeToFile:historyfilePath atomically:YES];

        }
    }
    //选菜按钮可以再次点击
    self.selectButton.enabled = YES;
}
@end
