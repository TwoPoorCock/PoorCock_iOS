//
//  PersonMessageVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/25.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "PersonMessageVC.h"

@interface PersonMessageVC () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *per_name;

@property (weak, nonatomic) IBOutlet UISwitch *love_meat;

@property (weak, nonatomic) IBOutlet UISwitch *love_hot;

@property (weak, nonatomic) IBOutlet UILabel *love_mainfood;
@end

@implementation PersonMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄口味";
    
}

- (IBAction)saveAll:(id)sender {
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        [self AlearChangeName];
    }
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
