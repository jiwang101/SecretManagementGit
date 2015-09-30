//
//  SecretListViewController.m
//  SecretManagement
//
//  Created by ssf-xiong on 15/9/30.
//  Copyright (c) 2015年 ssf-xiong. All rights reserved.
//

#import "SecretListViewController.h"

#import "HeadView.h"
#import "NoDataView.h"

#import "ConstantDefined.h"

#import "SecretCell.h"

@interface SecretListViewController()<HeadViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet HeadView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NoDataView *noDataView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
@implementation SecretListViewController
#pragma mark - life cycle
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initView];
    [self initData];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];
}
#pragma mark - initView
- (void)initView{
    self.headView.delegate = self;
    self.headView.titleLabel.text = @"脑容量";
    
    [self.headView.leftBtn setTitle:@"设置" forState:UIControlStateNormal];
    [self.headView.leftBtn setImage:nil forState:UIControlStateNormal];
    
    [self.headView.rightBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.headView.rightBtn.hidden = NO;
    
    self.noDataView.noDataImgView.image = [UIImage imageNamed:@"icon_message_nodata"];
    self.noDataView.titleLabel.text = @"还没有记录哟~赶紧去添加.";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}
- (void)initData{
    self.dataSource = [NSMutableArray array];
}
- (void)loadData{
    
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    
}
- (void)responseRightButton{
    
}
#pragma mark UITableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"secretCell";
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
