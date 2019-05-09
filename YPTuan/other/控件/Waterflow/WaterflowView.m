//
//  WaterflowView.m
//  瀑布流
//
//  Created by tarena29 on 15/10/13.
//  Copyright (c) 2015年 tarena29. All rights reserved.
//

#import "WaterflowView.h"
#import "WaterflowViewCell.h"
//#import "UIView+Extension.h"

#define WaterflowViewDefaultCellH 70
#define WaterflowViewDefaultMargin 8
#define WaterflowViewDefaultNumberOfColumns 3

@interface WaterflowView()

/**
 *  所有cell的frame数据
 */
@property (nonatomic,strong) NSMutableArray* cellFrames;
/**
 *  正在展示的cell
 */
@property (nonatomic,strong) NSMutableDictionary* displayCells;
/**
 *  缓存池（用Set，存放离开屏幕的cell）
 */
@property (nonatomic,strong) NSMutableSet* reusableCells;

@end
@implementation WaterflowView
-(NSMutableDictionary*)displayCells
{
    if (!_displayCells) {
        _displayCells = [NSMutableDictionary dictionary];
    }
    return _displayCells;
}
-(NSMutableArray*)cellFrames
{
    if (!_cellFrames) {
        _cellFrames = [NSMutableArray array];
    }
    return _cellFrames;
}
-(NSMutableSet*)reusableCells
{
    if (!_reusableCells) {
        _reusableCells = [NSMutableSet set];
    }
    return _reusableCells;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

#pragma mark - 公共接口

-(CGFloat)cellWidth
{
    //总列数
    NSUInteger numberOfColumns = [self numberOfColums];
    CGFloat leftM = [self marginForType:WaterflowViewMarginTypeLeft];
    CGFloat rightM = [self marginForType:WaterflowViewMarginTypeRight];
     CGFloat columnM = [self marginForType:WaterflowViewMarginTypeColumn];
    return (self.width - leftM - rightM - (numberOfColumns-1)*columnM) / numberOfColumns;
}

//cell 的宽度

-(void)reloadData
{
    //清除掉之前的数据
    //从控制器上移除正在显示的Cell
    [self.displayCells.allValues makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //从字典上移除数据
    [self.displayCells removeAllObjects];
    //移除Cell的frame
    [self.cellFrames removeAllObjects];
    //移除缓冲池中的Cell
    [self.reusableCells removeAllObjects];
    
    
    //重新加载新的Cell
    //cell总数
    NSUInteger numberOfCells = [self.dataSource numberOfcellsInWaterflowView:self];
    //总列数
    NSUInteger numberOfColumns = [self numberOfColums];
    //cell 的间距
    CGFloat topM = [self marginForType:WaterflowViewMarginTypeTop];
     CGFloat bottomM = [self marginForType:WaterflowViewMarginTypeBottom];
     CGFloat leftM = [self marginForType:WaterflowViewMarginTypeLeft];
    CGFloat columnM = [self marginForType:WaterflowViewMarginTypeColumn];
    CGFloat rowM = [self marginForType:WaterflowViewMarginTypeRow];

    //存储每列中的最大Y值
    CGFloat maxYCellColumns[numberOfColumns];
    for (int i=0; i<numberOfColumns; i++) {
        maxYCellColumns[i] = 0.0;
    }
    
    //cell 的宽度都是一样的
    CGFloat cellW = [self cellWidth];
   //计算Cell的fram
    for (int i= 0; i<numberOfCells; i++) {
        
         //Cell的高度 询问代理i位置的Cell高度
        CGFloat cellH = [self heightAtIndex:i];
        
        //Cell在那一列
        NSUInteger cellAtColumn = 0;
        //Cell 所在类的做大Y值
        CGFloat maxYCellOfColumn = maxYCellColumns[cellAtColumn];
        //求出最短的一列
        for (int j=1; j<numberOfColumns; j++) {
            if (maxYCellColumns[j]<maxYCellOfColumn) {
                cellAtColumn = j;
                maxYCellOfColumn = maxYCellColumns[j];
            }
        }
        //Cell的位置
        CGFloat cellX = leftM + cellAtColumn * (columnM + cellW);
        CGFloat cellY = 0;
        if (maxYCellOfColumn == 0.0) {
             cellY = topM;
        }else
        {
            cellY = rowM + maxYCellOfColumn;
        }
        
        //添加到frame数组中
        CGRect cellFrame = CGRectMake(cellX, cellY, cellW, cellH);
        [self.cellFrames addObject:[NSValue valueWithCGRect:cellFrame]];
        
        //更新最短的哪一列的最大Y值
        maxYCellColumns[cellAtColumn] = CGRectGetMaxY(cellFrame);
        
//        //显示Cell
//        WaterflowViewCell* cell = [self.dataSource waterflowView:self cellAtIndex:i];
//        cell.frame = cellFrame;
//        [self addSubview:cell];
    }
    
    //设置滚动的范围
    CGFloat contentH = maxYCellColumns[0];
    //求出最长的一列
    for (int j=1; j<numberOfColumns; j++) {
        if (maxYCellColumns[j]>contentH) {
            
            contentH = maxYCellColumns[j];
        }
    }
    contentH +=bottomM;
    self.contentSize = CGSizeMake(0, contentH);
}

//当scrollView滚动时候和尺寸调用
-(void)layoutSubviews
{
    [super layoutSubviews];
 //cell 的总数
    NSUInteger numberOfCells = self.cellFrames.count;
       //向数据源索要对应位置的Cell
    for (int i=0; i<numberOfCells; i++) {
        //取得 i 位置的frame
        CGRect cellFrame = [self.cellFrames[i] CGRectValue];
        
        //优先从字典中取得Cell
        WaterflowViewCell* cell = self.displayCells[@(i)];
          //判断Cell是否在屏幕内（可见）
        if ([self isVisibleInScreen:cellFrame]) {
            
            if (cell == nil) {
                 cell = [self.dataSource waterflowView:self cellAtIndex:i ];
            cell.frame = cellFrame;
            [self addSubview:cell];
            //将创建了的Cell放到字典中
            self.displayCells[@(i)] = cell;

            }
                       
        }else
        {//不在屏幕中的cell
            if (cell) {
                // 从scrollView和字典中移除
                [cell removeFromSuperview];
                [self.displayCells removeObjectForKey:@(i)];
                
                //存放近缓存池
                [self.reusableCells addObject:cell];
            }
            
        }

    }
      
    
}
//将显示到父控件是调用
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self reloadData];
}
-(id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    __block WaterflowViewCell* reusableCell = nil;
    [self.reusableCells enumerateObjectsUsingBlock:^(WaterflowViewCell* cell, BOOL *stop) {
        if ([cell.identifier isEqualToString:identifier]) {
            reusableCell = cell;
            *stop = YES;
        }
    }];
    if (reusableCell) { //如果Cell存在 就将Cell从缓存池中移除
        [self.reusableCells removeObject:reusableCell];
    }
    return reusableCell;
}
#pragma mark - 私有方法

//判断Cell是否可见
-(BOOL)isVisibleInScreen:(CGRect)fram
{
    //最大的Y比scrollView的偏移量大  最小的Y比scrollView的偏移量和屏幕高度小
    return (CGRectGetMaxY(fram) > self.contentOffset.y && CGRectGetMinY(fram) < self.contentOffset.y+self.height);
}
//总列数
-(NSUInteger)numberOfColums
{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsInWaterflowView:)]) {
        return [self.dataSource numberOfColumnsInWaterflowView:self];
    }else
    {
        return WaterflowViewDefaultNumberOfColumns;
    }
}
//index对应的高度
-(CGFloat)heightAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:heightAtIndex:)]) {
        return [self.delegate waterflowView:self heightAtIndex:index];
    }else
    {
        return WaterflowViewDefaultCellH;
    }
}

//Cell的间距

-(CGFloat)marginForType:(WaterflowViewMarginType)type
{
    if ([self.delegate respondsToSelector:@selector(waterflowView:marginForType:)]) {
        return [self.delegate waterflowView:self marginForType:type];
    }else
    {
        return WaterflowViewDefaultMargin;
    }
}

#pragma mark - 事件处理
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (![self.delegate respondsToSelector:@selector(waterflowView:didSelectAtIndex:)]) {
        return;
    }
    
    //获得触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    __block NSNumber* selectIndex = nil;
    [self.displayCells enumerateKeysAndObjectsUsingBlock:^(id key, WaterflowViewCell* cell, BOOL *stop) {
        if (CGRectContainsPoint(cell.frame, point)) {
            selectIndex = key;
            *stop = YES;
        }
    }];
    if (selectIndex) {
        [self.delegate waterflowView:self didSelectAtIndex:selectIndex.unsignedIntegerValue];
    }
}


@end
