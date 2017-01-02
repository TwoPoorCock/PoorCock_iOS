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

@interface EatFoodVC () <UIAlertViewDelegate,pickViewDelegate>
@property (weak, nonatomic) IBOutlet JTNumberScrollAnimatedView *animotionView;
@property (weak, nonatomic) IBOutlet UILabel *menuName;

//plist文件解档归档
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSArray *arr;
//被选中的菜品
@property (strong, nonatomic) NSDictionary *beSelectDic;
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
    if([_arr count]==0){
    }
    else{
        int value = (arc4random() % [_arr count]);
        self.beSelectDic = self.arr[value];
        [self.animotionView setValue:[self.arr[value] objectForKey:@"cainame"]];
        [self.animotionView startAnimation];
    }
    User* app_user = [User getAppUser];
    if([app_user.Letmeseesee isEqualToString:@"yes"]){
        //开始动画后1.5秒弹出确认框
        [self performSelector:@selector(confirmCai) withObject:nil afterDelay:1.5f];
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
                                 [self.beSelectDic objectForKey:@"cainame"], @"cainame",
                                 [self.beSelectDic objectForKey:@"caihot"], @"caihot",
                                 [self.beSelectDic objectForKey:@"caimeat"], @"caimeat",
                                 [NSString stringWithFormat: @"time"], @"eattime",
                                 nil];
            [myhistoryMutableArray addObject:dic];
            NSLog(@"%@", myhistoryMutableArray);
            NSArray *myhistoryArray = [myhistoryMutableArray copy];
            
            //plist文件归档
            [myhistoryArray writeToFile:historyfilePath atomically:YES];

        }
    }
}
@end
