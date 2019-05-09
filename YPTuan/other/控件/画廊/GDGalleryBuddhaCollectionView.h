//
//  GDGalleryBuddhaCollectionView.h
//  buddhismYDniu
//
//  Created by gd on 2018/8/21.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GalleryCollectionHeight  kAdapterHeight(300)

@interface GDGalleryBuddhaCollectionView : UIView

@property (nonatomic,strong) NSArray *dataArr;

@property (nonatomic,copy) void (^didSelectBuddhaImage)(NSInteger index);

@end
