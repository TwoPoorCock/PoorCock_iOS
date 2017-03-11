//
//  pickViewController.m
//  pickviewDelegate
//
//  Created by 刘凯 on 15/7/24.
//  Copyright (c) 2015年 刘凯. All rights reserved.
//

#import "pickViewController.h"

@interface pickViewController ()

@end

@implementation pickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arry = [[NSMutableArray alloc] initWithObjects:@"内蒙古财经大学食堂菜单",@"小鳄喜欢的菜单",@"历史菜单", nil];
    self.chooseText = @"内蒙古财经大学食堂菜单";
//    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_arry count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_arry objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _chooseText = [NSString stringWithFormat:@"%@",[_arry objectAtIndex:row]];
    
}

//取消按钮
- (IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//确定按钮
- (IBAction)submit:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(getTextStr:)]) {
        [_delegate getTextStr:_chooseText];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
