//
//  HGTabView.h
//  HiGo
//
//  Created by caine on 2017/9/19.
//  Copyright © 2017年 Think_lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HGTabView;


@protocol HGTabViewDelegate <NSObject>

@optional
-(void)tabView:(HGTabView*)tabView didSelectedFrom:(int)from toIndex:(int)to;

@end

@interface HGTabView : UIView

-(void)addTabItem:(UITabBarItem*)item;
@property (nonatomic,weak) id<HGTabViewDelegate>delegate;

@end
