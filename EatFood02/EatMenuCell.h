//
//  EatMenuCell.h
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/25.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EatMenuCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cell_background;
@property (weak, nonatomic) IBOutlet UILabel *cell_name;

- (void)addbackground:(UIImage*)ui andname:(NSString*)name;

@end
