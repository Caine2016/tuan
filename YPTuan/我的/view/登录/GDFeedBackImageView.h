//
//  GDFeedBackImageView.h
//  buddhismYDniu
//
//  Created by gd on 2018/4/19.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDFeedBackImageView : UIView

@property (nonatomic, strong) NSArray *imgList;

@property (nonatomic,copy) void (^feedbackImgBLock)();

@property (nonatomic,copy) void (^deleteImgBLock)(NSInteger index);

-(void) addImageList;

@end
