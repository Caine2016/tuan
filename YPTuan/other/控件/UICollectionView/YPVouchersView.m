//
//  YPVouchersView.m
//  YPTuan
//
//  Created by Caine on 2018/7/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YPVouchersView.h"
#import "YPVouchersViewCell.h"
#import "YLfacilitiexImgView.h"
#import "YLTechnicianCollectionViewCell.h"
#define VouchersViewCell @"VouchersViewCell"

@interface YPVouchersView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionViiew;
@property (nonatomic,assign) CGSize itemSizeLayout;
@property (nonatomic,assign) UIEdgeInsets flowInset;
@property (nonatomic,assign) VouchersViewType type;

@property (nonatomic,assign) CGFloat lineSpacing;  ///行 上下
@property (nonatomic,assign) CGFloat interitemSpacing; //列

@end

@implementation YPVouchersView


-(instancetype)initWithFrame:(CGRect)frame andItemSize:(CGSize)itemSizeLayout andFlowInset:(UIEdgeInsets)flowInset andType:(VouchersViewType)type andInteritemSpacing:(CGFloat)interitemSpacing
              andlineSpacing:(CGFloat)lineSpacing
{
    self=[super initWithFrame:frame];
    if(self){
        _itemSizeLayout = itemSizeLayout;
        _flowInset = flowInset;
        _type = type;
        _lineSpacing = lineSpacing;
        _interitemSpacing = interitemSpacing;
        //1.添加collectionview
        [self addView];
    }
    return self;
}


#pragma mark 添加collectionView
-(void)addView
{

    
    //1.创建collectinView
    UICollectionViewFlowLayout *flow=[[UICollectionViewFlowLayout alloc]init];
    // 设置最小行间距
    flow.minimumLineSpacing = _lineSpacing;
    // 最小列间距
    flow.minimumInteritemSpacing = _interitemSpacing;
    flow.itemSize = _itemSizeLayout;
    
    if (_type == VouchersViewTypeTechnician) {
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;

    }else{
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    }
    
    
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    
    switch (_type) {
        case VouchersViewTypefacilitiex:
              [collectionView registerClass:[YLfacilitiexImgView class] forCellWithReuseIdentifier:VouchersViewCell];
            break;
        case VouchersViewTypeTechnician:
            [collectionView registerClass:[YLTechnicianCollectionViewCell class] forCellWithReuseIdentifier:VouchersViewCell];
            break;
            
        default:
                [collectionView registerClass:[YPVouchersViewCell class] forCellWithReuseIdentifier:VouchersViewCell];
            break;
    }
    
    collectionView.backgroundColor = kClearColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator=NO;
    [self addSubview:collectionView];
    self.collectionViiew = collectionView;
}

#pragma mark 返回多少行


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    CNSLog(@"self.data.count==%lu",(unsigned long)self.data.count);
    return self.data.count;
}



#pragma mark  返回cell
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    switch (_type) {
        case VouchersViewTypefacilitiex:{
            YLfacilitiexImgView *cell= [collectionView dequeueReusableCellWithReuseIdentifier:VouchersViewCell forIndexPath:indexPath];
            
            cell.imgName = self.data[indexPath.item];
               return cell;
        }
            break;
        case VouchersViewTypeTechnician:{
            YLTechnicianCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:VouchersViewCell forIndexPath:indexPath];
            cell.artificerModel = self.data [indexPath.item];
            //cell.imgName = self.data[indexPath.item];
            return cell;
        }
            break;
            
        default:{
            YPVouchersViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:VouchersViewCell forIndexPath:indexPath];
            
            cell.model = self.data[indexPath.item];
               return cell;
        }
            break;
    }
    

    
 
}

-(void)setData:(NSArray *)data
{
    
    _data = data;
   
    [self.collectionViiew reloadData];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {

}
//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.flowInset;//分别为上、左、下、右
}


#pragma mark 点击的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}



@end
