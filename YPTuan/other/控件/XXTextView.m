//
//  XXTextView.m
//  Remember
//
//  Created by Jason on 2017/5/21.
//  Copyright © 2017年 ifelseboyxx. All rights reserved.
//

#import "XXTextView.h"

@interface XXTextView ()

@property (weak, nonatomic) UILabel *placeholderLabel;

@end

@implementation XXTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;
    [self setUp];
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self setDoneBtn];
    /*
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    
    [button setTitle:@"完成" forState:UIControlStateNormal];
    
    [button setTitleColor:MainBackColor forState:UIControlStateNormal];
    
    button.layer.borderColor = MainBackColor.CGColor;
    
    button.layer.borderWidth =1;
    
    button.layer.cornerRadius =3;
    
    [bar addSubview:button];
    
    self.inputAccessoryView = bar;

    [button addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
   */
}


-(void) setDoneBtn{
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH,44)];
    bar.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *aTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(print)];
    // 设置轻拍次数
    aTapGR.numberOfTapsRequired = 1;
    // 添加手势
    [bar addGestureRecognizer:aTapGR];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, 7,50, 30)];
    
    [button setTitle:@"完成" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.layer.borderColor = [UIColor blackColor].CGColor;
    
    button.layer.borderWidth =1;
    
    button.layer.cornerRadius =3;
 //   [self addSubview:bar];
    [bar addSubview:button];
    
    self.inputAccessoryView = bar;
    
    
    
    [button addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
}
- (void) print {
    
   
    [self resignFirstResponder];
    
}
- (void)setUp {
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_placeholderLabel = placeholderLabel];
    
    self.xx_placeholderColor = [UIColor lightGrayColor];
    self.xx_placeholderFont = [UIFont systemFontOfSize:16.0f];
    self.font = [UIFont systemFontOfSize:16.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark - UITextViewTextDidChangeNotification

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}


- (void)setText:(NSString *)text {
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}


- (void)setXx_placeholderFont:(UIFont *)xx_placeholderFont {
    _xx_placeholderFont = xx_placeholderFont;
    self.placeholderLabel.font = xx_placeholderFont;
    [self setNeedsLayout];
}

- (void)setXx_placeholder:(NSString *)xx_placeholder {
    _xx_placeholder = [xx_placeholder copy];
    
    self.placeholderLabel.text = xx_placeholder;
    
    [self setNeedsLayout];
    
}


- (void)setXx_placeholderColor:(UIColor *)xx_placeholderColor {
    _xx_placeholderColor = xx_placeholderColor;
    self.placeholderLabel.textColor = xx_placeholderColor;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.placeholderLabel.frame;
    frame.origin.y = self.textContainerInset.top;
    frame.origin.x = self.textContainerInset.left+6.0f;
    frame.size.width = self.frame.size.width - self.textContainerInset.left*2.0;
    
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    frame.size.height = [self.xx_placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    self.placeholderLabel.frame = frame;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}

@end
