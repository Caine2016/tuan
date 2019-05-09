//
//  YPGlobalModel.h
//  YPTuan
//
//  Created by Caine on 2018/7/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPGlobalModel : NSObject

@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *title;

+(NSArray*) getVouchers;

@end
