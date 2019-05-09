//
//  NSDictionary+YLDicChangeUrl.m
//  YPTuan
//
//  Created by gd on 2018/12/4.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "NSDictionary+YLDicChangeUrl.h"

@implementation NSDictionary (YLDicChangeUrl)

- (NSString *)URLRequestStringWithURL:(NSString *)urlstr{
    
    NSMutableString *URL = [NSMutableString stringWithFormat:@"%@",urlstr];
    //获取字典的所有keys
    NSArray * keys = [self allKeys];
    
    //拼接字符串
    for (int j = 0; j < keys.count; j ++){
        NSString *string;
        if (j == 0){
            //拼接时加？
            string = [NSString stringWithFormat:@"?%@=%@", keys[j], self[keys[j]]];
            
        }else{
            //拼接时加&
            string = [NSString stringWithFormat:@"&%@=%@", keys[j], self[keys[j]]];
        }
        //拼接字符串
        [URL appendString:string];
        
    }
    return URL;
}

@end
