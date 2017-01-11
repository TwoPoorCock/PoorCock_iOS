//
//  MBProgressHUD+Toast.m
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/11.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import "MBProgressHUD+Toast.h"

@implementation MBProgressHUD (Toast)

-(void)showToastWithText:(NSString *)text
{
    [self showAnimated:NO];
    [self setMode:MBProgressHUDModeText];
    self.userInteractionEnabled = NO;
    self.detailsLabel.text = text;
    self.detailsLabel.font = [UIFont boldSystemFontOfSize:16.];
    //    设置视图停留的时间
    [self hideAnimated:YES afterDelay:2.];
}
-(void)showToastWithText:(NSString *)text isAutoHide:(BOOL)isAutoHide
{
    [self setMode:MBProgressHUDModeText];
    self.userInteractionEnabled = NO;
    self.detailsLabel.text = text;
    self.detailsLabel.font = [UIFont boldSystemFontOfSize:14.];
    if (isAutoHide) {
        //    设置视图停留的时间
        [self hideAnimated:YES afterDelay:2.];
    }
}

-(void)showToastWithText:(NSString *)text whileExecutingBlock:(dispatch_block_t)block
{
    [self setMode:MBProgressHUDModeText];
    self.userInteractionEnabled = NO;
    self.label.text = text;
    //    设置视图停留的时间
    dispatch_time_t time3s = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
    dispatch_after(time3s, dispatch_get_global_queue(0, 0), ^{
        [self hideAnimated:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}


+(MBProgressHUD *)showToastToView:(UIView *)view withText:(NSString *)text
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [hud showToastWithText:text];
    return hud;
}
@end
