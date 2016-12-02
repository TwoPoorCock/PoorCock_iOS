//
//  HttpTool.h
//  EatFood02
//
//  Created by 郝宇泽 on 2016/12/2.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HttpTool : NSObject
-(void)postHttpurl:(NSString*)domainStr anddictionary:(NSMutableDictionary*)parametersDic;
@end
