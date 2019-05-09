//
//  YLTechnicianModel.h
//  YPTuan
//
//  Created by gd on 2018/11/21.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTechnicianModel : NSObject

@property (nonatomic,copy) NSString *imgName;

@property (nonatomic,strong) NSNumber *commentCount;
@property (nonatomic,strong) NSNumber *likeCount;

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;

@end
