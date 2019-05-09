//
//  GDGalleryBuddhaCollectionView.m
//  buddhismYDniu
//
//  Created by gd on 2018/8/21.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDGalleryBuddhaCollectionView.h"
#import "GDGalleryBuddhaViewCell.h"
#import "GDGalleryBuddhaFlowLayout.h"

//重用标识符
static NSString *identifier = @"cell";
@interface GDGalleryBuddhaCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>



@end

@implementation GDGalleryBuddhaCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
      //  self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
    
}

-(void)creatView{
   
    //实例化一个自定义Flowlayout
    GDGalleryBuddhaFlowLayout *flowlayout = [[GDGalleryBuddhaFlowLayout alloc]init];
    
    //实例化创建一个CollectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0
                                                                                         , 0, kScreenWidth, GalleryCollectionHeight) collectionViewLayout:flowlayout];
 //   collectionView.decelerationRate = 0.1;
    
    //设置数据源代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    //注册Cell
    [collectionView registerClass:[GDGalleryBuddhaViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:collectionView];
    
}


//组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

//内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GDGalleryBuddhaViewCell *collectionCell =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    collectionCell.imageName = self.dataArr[indexPath.item];
    return collectionCell;
}
#pragma mark -UIScrollViewDelegate协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
   NSInteger indexRow = scrollView.contentOffset.x/(kScreenWidth*0.5);
    CNSLog(@"kScreenWidth*0.6 = %f",kScreenWidth*0.5);
    CNSLog(@"scrollView.contentOffset.x = %f",scrollView.contentOffset.x);
    CNSLog(@"indexRow = %ld",(long)indexRow);
    
    !self.didSelectBuddhaImage ? : self.didSelectBuddhaImage(indexRow);
    
//    T_Buddha *tb = _buddhaList[_indexRow];
//    _buddhaId = tb.id;
//    !self.blockRow ? : self.blockRow(_indexRow);
//    [self setBuddhaInfo:tb.name];
}
//定义每个Section的四边间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 10, 0, 2);//分别为上、左、下、右
//}

@end
