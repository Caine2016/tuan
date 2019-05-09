//
//  WaterflowView.h
//  瀑布流
//
//  Created by tarena29 on 15/10/13.
//  Copyright (c) 2015年 tarena29. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    WaterflowViewMarginTypeTop,
    WaterflowViewMarginTypeLeft,
    WaterflowViewMarginTypeBottom,
    WaterflowViewMarginTypeRight,
    WaterflowViewMarginTypeColumn,//每一列
    WaterflowViewMarginTypeRow,//每一行的间距
} WaterflowViewMarginType;

@class WaterflowView,WaterflowViewCell;

//数据源方法
@protocol WaterflowViewDataSource <NSObject>
@required
//一共有多少个数据
-(NSUInteger)numberOfcellsInWaterflowView:(WaterflowView*)waterflowView;

//返回index位置对应的Cell
-(WaterflowViewCell*)waterflowView:(WaterflowView*)waterflowView cellAtIndex:(NSUInteger)index;
@optional
//一共有都是列
-(NSUInteger)numberOfColumnsInWaterflowView:(WaterflowView*)waterflowView;
@end


//代理方法
@protocol WaterflowViewDelegate <UIScrollViewDelegate>
@optional
//第indexCell对于的高度
-(CGFloat)waterflowView:(WaterflowView*)waterflowView heightAtIndex:(NSUInteger)index;
//选中第index位置的Cell
-(void)waterflowView:(WaterflowView*)waterflowView didSelectAtIndex:(NSUInteger)index;
//返回间距
-(NSUInteger)waterflowView:(WaterflowView*)waterflowView marginForType:(WaterflowViewMarginType)type;

@end

@interface WaterflowView : UIScrollView
@property(nonatomic,weak)id<WaterflowViewDataSource> dataSource;
@property(nonatomic,weak)id<WaterflowViewDelegate> delegate;

//接口

/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
-(void)reloadData;

/**
 *  根据标识去缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;


/**
 * cell 的宽度
 */

-(CGFloat)cellWidth;
@end
