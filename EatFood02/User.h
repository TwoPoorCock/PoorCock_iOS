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
@property NSString* Letmeseesee;

+ (User*) getAppUser;

@end
