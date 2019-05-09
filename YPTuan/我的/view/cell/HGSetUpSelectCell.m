//
//  HGSetUpSelectCell.m
//  buddhismYDniu
//
//  Created by longchenghua on 2017/9/25.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "HGSetUpSelectCell.h"
@interface HGSetUpSelectCell ()
@property (nonatomic,strong) YYLabel     *titleLabel;
@property (nonatomic,strong) YYLabel     *rightTextLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) CAShapeLayer *redLayer;
@end
@implementation HGSetUpSelectCell

- (void)drawRect:(CGRect)rect{
    if (_model.showBottomLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(5, CGRectGetHeight(rect))];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(rect)-10, CGRectGetHeight(rect))];
        path.lineWidth = .8;
        [kColorTitleTabbarNormal setStroke];
        [path stroke];
    }
}



- (void)setModel:(YLCenterModel *)model{
    _model = model;
 
     self.iconImageView.image = IMAGENAME(_model.imgStr);
     self.titleLabel.text = _model.title;
     self.rightTextLabel.text = _model.righTitle;
    
    
}

- (void)createSubViews{
    [super createSubViews];
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightTextLabel];
    
    self.iconImageView.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 10)
    .widthIs(25)
    .heightIs(25);
    
    
    self.rightTextLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 5)
    .widthIs(60);
    
    self.titleLabel.sd_layout
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .leftSpaceToView(self.iconImageView, 8)
    .rightSpaceToView(self.rightTextLabel, 8);
    

    
}

-(CAShapeLayer *)redLayer{
    if (!_redLayer) {
        
        _redLayer = [GDTool solidFillLine:[UIColor redColor] andFrame:CGRectMake(self.titleLabel.right+120, (self.height-10)/2+2, 10, 10)];
        _redLayer.hidden = YES;
        
    }
    
    return _redLayer;
}


#pragma mark -- 加载

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [YYLabel new];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = BaseFont18;
    }
    return _titleLabel;
}
- (YYLabel *)rightTextLabel{
    if (!_rightTextLabel) {
        _rightTextLabel = [YYLabel new];
        _rightTextLabel.textColor = COLOR_999;
        _rightTextLabel.font = font(14);
    }
    return _rightTextLabel;
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}
@end
