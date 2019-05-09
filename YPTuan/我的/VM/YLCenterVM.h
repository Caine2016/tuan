//
//  YLCenterVM.h
//  YPTuan
//
//  Created by Caine on 2018/11/18.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLCenterVM : NSObject

SISingletonH(YLCenterVM)

/// 获取缓存文件的大小
- (NSString *)readCacheSize;

/// 清除缓存
- (void)clearFile;

-(void) getCenterDataBlock:(void(^)(NSArray*))block;

-(void) getSettingDataBlock:(void(^)(NSArray* blockData))blockData;


@end

NS_ASSUME_NONNULL_END
