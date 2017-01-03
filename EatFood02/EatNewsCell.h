//
//  EatNewsCell.h
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/3.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EatNewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsText;

@end
