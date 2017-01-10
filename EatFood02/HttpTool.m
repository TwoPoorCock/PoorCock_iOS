//
//  HttpTool.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/12/2.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"

@implementation HttpTool

+ (AFHTTPSessionManager *)HttpManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
    
}

+ (void)getHttpUrl:(NSString*)domainStr andDictionary:(NSMutableDictionary*)parametersDic
{
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:domainStr parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];

}
@end
