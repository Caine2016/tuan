//
//  SLocationManager.h
//  buddhismYDniu
//
//  Created by gd on 2018/6/12.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

typedef void(^SLocationManagerDidUpdateLocationHandle)(CLLocation *newLocation, NSString *newLatitude, NSString *newLongitude);
typedef void (^SLocationManagerDidGetPOISearchResponse)(AMapPOISearchResponse *response);
typedef void (^SLocationManagerDidGetTipsResponse)(AMapInputTipsSearchResponse *response);
typedef void (^SLocationManagerErrorResponse)(NSString *response);


@interface SLocationManager : NSObject

/** 开始定位*/
- (void)startSerialLocation;
/**开始单次定位*/
- (void)startSingleLocation;
// 快速创建一个locationManager
+ (instancetype)sharedManager;
/** 开始周边搜索🔍 */
- (void)beginAroundSearch;

/**
 搜索更多周边信息
 
 @param page 搜索的页数
 */
- (void)aroundSearchMore:(NSInteger)page;

/** 更新定位回调*/
- (void)setUpLocationManagerUpdateLocationHandle:(SLocationManagerDidUpdateLocationHandle)updateLocationHandle;
/** 定位到兴趣点 */
- (void)locationManagerDidGetPOISearchResponse:(SLocationManagerDidGetPOISearchResponse)POISearchResponse;
/** 获取到提示搜索词 */
- (void)locationManagerDidGetTipsResponse:(SLocationManagerDidGetTipsResponse)tipsResponse;

/**
 关键字搜索
 
 @param keywords 搜索关键字 必传参数
 @param city 搜索城市
 @param page 搜索页数
 */
- (void)keywordsSearchWithKeywords:(NSString *)keywords city:(NSString *)city page:(NSInteger)page;
/** 提示搜索 */
- (void)tipsSearchWithKeywords:(NSString *)key city:(NSString *)city ;
/** 是否可以定位*/
@property (nonatomic, assign) BOOL canLocationFlag;

/** 是否有经纬度*/
@property (nonatomic, assign) BOOL hasLocation;

/** 经纬度 */
- (NSString *)curLatitudeAndLongitude;
@end


