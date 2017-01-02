//
//  User.m
//  EatFood02
//
//  Created by 郝宇泽 on 2017/1/1.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import "User.h"

@implementation User

static User* app_user = nil;

+ (User*) getAppUser {
    static dispatch_once_t once;
    //单例模式，只执行一次，dispatch_once由GCD提供
    dispatch_once(&once, ^{
        app_user = [[self alloc] init];
    });
    return app_user;
}

@end
