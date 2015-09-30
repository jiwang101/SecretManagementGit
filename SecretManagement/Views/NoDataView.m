//
//  NoDataView.m
//  Pods
//
//  Created by ssf-2 on 15/9/17.
//
//

#import "NoDataView.h"

@interface NoDataView()

@property (strong, nonatomic) IBOutlet UIView *contentView;

@end

@implementation NoDataView

-(void)awakeFromNib{
    [super awakeFromNib];
    [[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:self options:nil];
    [self addSubview:self.contentView];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
