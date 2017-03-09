//
//  User.h
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/1.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property NSString* user_name;

@property NSString* userId;

@property NSString* Letmeseesee;

@property NSInteger user_meat;

@property NSInteger user_hot;

@property NSString* user_height;

@property NSString* user_weight;

@property NSString* user_mainfood;

@property NSInteger user_weitong;

@property NSInteger user_mouth;

@property NSInteger user_tooth;

@property NSInteger user_fat;

+ (User*) getAppUser;

@end
