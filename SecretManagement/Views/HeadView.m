//
//  HeadView.m
//  SFPay
//
//  Created by ssf-2 on 14-11-6.
//  Copyright (c) 2014年 SF. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self loadView];
    }
    return self;
    
}
- (void)awakeFromNib
{
    [self loadView];
}
-(void)loadView
{
    
    [[NSBundle mainBundle] loadNibNamed:@"HeadView" owner:self options:nil];
    [self.leftBtn setImage:[UIImage imageNamed:@"navigationBack"] forState:UIControlStateNormal];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    UIView *superview = self;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(superview.mas_width);
        make.height.equalTo(superview.mas_height);
    }];

}
#pragma mark - button action
- (IBAction)leftButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(responseLeftButton)]) {
        [self.delegate responseLeftButton];
    }
}

- (IBAction)rightButtonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(responseRightButton)]) {
        [self.delegate responseRightButton];
    }
}

- (IBAction)titleAction
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(responseTitleButton)]) {
        [self.delegate responseTitleButton];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
