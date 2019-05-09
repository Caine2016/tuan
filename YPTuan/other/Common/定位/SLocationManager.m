//
//  SLocationManager.m
//  buddhismYDniu
//
//  Created by gd on 2018/6/12.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "SLocationManager.h"


#define kSUserCurrentLatitude @"kSUserCurrentLatitude"
#define kSUserCurrentLongitude @"kSUserCurrentLongitude"


@interface SLocationManager ()<AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (strong, nonatomic) AMapSearchAPI *search;

@end


static SLocationManager *_singleton = nil;
@implementation SLocationManager
{
    SLocationManagerDidUpdateLocationHandle _updateLocationHandle;
    SLocationManagerDidGetPOISearchResponse _POISearchResponse;
    SLocationManagerDidGetTipsResponse _tipsResponse;
    BOOL isSearch;
}
- (AMapLocationManager *)locationManager {
    if (!_locationManager) {
        AMapLocationManager *locationManager = [[AMapLocationManager alloc] init];
        _locationManager = locationManager;
        locationManager.delegate = self;
        //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
        locationManager.pausesLocationUpdatesAutomatically = NO;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.allowsBackgroundLocationUpdates = NO;
    }
    return _locationManager;
}
- (AMapSearchAPI *)search
{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[SLocationManager alloc] init];
    });
    return _singleton;
}
- (void)setUpLocationManagerUpdateLocationHandle:(SLocationManagerDidUpdateLocationHandle)updateLocationHandle {
    _updateLocationHandle = updateLocationHandle;
}

- (void)locationManagerDidGetPOISearchResponse:(SLocationManagerDidGetPOISearchResponse)POISearchResponse {
    
    _POISearchResponse = POISearchResponse;
}
// 开始定位
- (void)startSerialLocation {
    
    if (self.canLocationFlag == NO) {
        return ;
    }
    
    
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [self.locationManager startUpdatingLocation];
}

// 停止定位
- (void)stopSerialLocation {
    [self.locationManager stopUpdatingLocation];
}

// 开始单次定位
- (void)startSingleLocation {
    
    if (self.canLocationFlag == NO) {
        return ;
    }
    // 带逆地理（返回坐标和地址信息）。将下面代码中的 YES 改成 NO ，则不会返回地址信息。
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        [self saveLocation:location];
        
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
        }
    }];
}
#pragma mark - AMapLocationManager
// 定位错误
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error = %@",  error);
}

// 定位结果
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)newLocation reGeocode:(AMapLocationReGeocode *)reGeocode{
    
    [self saveLocation:newLocation];
    
    [self stopSerialLocation];
}
- (void)saveLocation:(CLLocation *)newLocation {
    // 纬度
    NSString *currentLatitude = [[NSString alloc]
                                 initWithFormat:@"%f",
                                 newLocation.coordinate.latitude];
    
    // 经度
    NSString *currentLongitude = [[NSString alloc]
                                  initWithFormat:@"%f",
                                  newLocation.coordinate.longitude];
    
    [[NSUserDefaults standardUserDefaults] setObject:currentLatitude forKey:kSUserCurrentLatitude];
    [[NSUserDefaults standardUserDefaults] setObject:currentLongitude forKey:kSUserCurrentLongitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (_updateLocationHandle) {
        _updateLocationHandle(newLocation, currentLatitude, currentLongitude);
    }
    
    if (isSearch) {
        [self beginAroundSearch];
    }
}
/** 经纬度 */
- (NSString *)curLatitudeAndLongitude {
    
    NSString *latitude = [[NSUserDefaults standardUserDefaults] valueForKey:kSUserCurrentLatitude];
    NSString *longitude = [[NSUserDefaults standardUserDefaults] valueForKey:kSUserCurrentLongitude];
    return [NSString stringWithFormat:@"%@,%@",latitude,longitude];
}
- (BOOL)isCanLocationFlag {
    
    if ([CLLocationManager locationServicesEnabled] || ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)hasLocation {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLongitude] length] && [[[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLatitude] length];
}
#pragma mark - 周边搜索
- (void)beginAroundSearch {
    
    if (![self hasLocation]) {
        isSearch = YES;
        [self startSingleLocation];
        return;
    }
    NSString *currentLatitude = [[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLatitude];
    NSString *currentLongitude = [[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLongitude];
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:[currentLatitude floatValue] longitude:[currentLongitude floatValue]];
    request.keywords            = @"";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}
#pragma mark - AMapSearchDelegate

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    //    if (response.pois.count == 0){
    //
    //        return;
    //    }
    for(AMapPOI *poi in response.pois){
        NSLog(@"%@.%@-%@-%@",poi.name,poi.district,poi.businessArea,poi.address);
    }
    
    if (_POISearchResponse) {
        _POISearchResponse(response);
    }
}
- (void)aroundSearchMore:(NSInteger)page {
    
    NSString *currentLatitude = [[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLatitude];
    NSString *currentLongitude = [[NSUserDefaults standardUserDefaults] objectForKey:kSUserCurrentLongitude];
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:[currentLatitude floatValue] longitude:[currentLongitude floatValue]];
    request.keywords            = @"";
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.page = page;
    [self.search AMapPOIAroundSearch:request];
}
#pragma mark - 关键字搜索
- (void)keywordsSearchWithKeywords:(NSString *)keywords city:(NSString *)city page:(NSInteger)page{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = keywords;
    request.city                = city;
    //    request.types               = @"高等院校";
    request.requireExtension    = YES;
    
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    //    request.cityLimit           = YES;
    //    request.requireSubPOIs      = YES;
    request.page = page;
    [self.search AMapPOIKeywordsSearch:request];
    
    
}

#pragma mark - 提示搜索
- (void)tipsSearchWithKeywords:(NSString *)key city:(NSString *)city {
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = city;
    [self.search AMapInputTipsSearch:tips];
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    //    if (response.tips.count == 0) {
    //        return;
    //    }
    
    if (_tipsResponse) {
        _tipsResponse(response);
    }
}

- (void)locationManagerDidGetTipsResponse:(SLocationManagerDidGetTipsResponse)tipsResponse {
    _tipsResponse = tipsResponse;
}
@end

