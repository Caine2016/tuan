
//
//  YLUserModel.m
//  YPTuan
//
//  Created by Caine on 2018/11/14.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLUserModel.h"

@implementation YLUserModel

SISingletonM(YLUserModel)



-(void)clearData{
    self.userId = @"";
    self.phoneNum = @"";
    self.userName = @"";
}



@end
