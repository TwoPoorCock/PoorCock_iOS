//
//  EatHealthy.m
//  EatFood02
//
//  Created by 郝宇泽 on 2017/3/15.
//  Copyright © 2017年 twopoorcick. All rights reserved.
//

#import "EatHealthy.h"
#import "User.h"

@implementation EatHealthy

+ (NSArray*)getHealthyFoodArray:(NSArray*) foodArray{

    User* app_user = [User getAppUser];
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    if(app_user.user_mouth==1||app_user.user_fat==1||app_user.user_tooth==1||app_user.user_weitong==1)
    {
        for(NSMutableDictionary* temp in foodArray){
            if(![[temp objectForKey:@"flagH"] isEqualToString:@"0"]){
//                NSLog(@"循环辣菜名是%@，flagH==%@",[temp objectForKey:@"dishname"],[temp objectForKey:@"flagH"]);
                continue;
            }else{
//                NSLog(@"循环不辣菜名是%@，flagH==%@",[temp objectForKey:@"dishname"],[temp objectForKey:@"flagH"]);
                [resultArray addObject:temp];
            }
        }
        return resultArray;
    }
    return nil;
}

@end
