//
//  YLOrderModel.m
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLOrderModel.h"

@implementation YLOrderModel


-(void)setState:(NSNumber *)state{
    _state = state;
    
    self.couponsType = [state integerValue];
}

@end
