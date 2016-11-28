//
//  EatMenuCell.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/25.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "EatMenuCell.h"

@implementation EatMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addbackground:(UIImage*)ui andname:(NSString*)name {
    self.cell_background.image = ui;
    self.cell_name.text = name;
}

@end
