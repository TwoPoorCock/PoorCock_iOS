//
//  MBProgressHUD+Toast.h
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/11.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Toast)

-(void)showToastWithText:(NSString *)text;
-(void)showToastWithText:(NSString *)text whileExecutingBlock:(dispatch_block_t)block;
+(MBProgressHUD *)showToastToView:(UIView *)view withText:(NSString *)text;

@end
