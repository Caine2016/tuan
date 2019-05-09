//
//  BaseTableViewCell.m
//  buddhismYDniu
//
//  Created by longchenghua on 2017/9/22.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    self.backgroundColor = kClearColor;
}
@end
