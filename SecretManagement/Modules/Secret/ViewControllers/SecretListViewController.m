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
#import "UIViewController+Message.h"
#import "NSString+Util.h"

#import "ConstantDefined.h"

#import "SecretCell.h"
#import "SecretModel.h"
#import "SettingViewController.h"
#import "SecretUpdateViewController.h"

@interface SecretListViewController()<HeadViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
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
    [SecretModel getSecretListSuccess:^(NSArray *secretList) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:secretList];
        if (self.dataSource.count > 0) {
            self.noDataView.hidden = YES;
        }else{
            self.noDataView.hidden = NO;
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self showError:error];
    }];
}
#pragma mark - HeadViewDelegate
- (void)responseLeftButton{
    [self performSegueWithIdentifier:@"settingSegue" sender:self];
}
- (void)responseRightButton{
    [SecretModel getSecretSafeKey:^(NSString *safeKey) {
        if ([NSString isBlankString:safeKey]) {
            [self showMessage:@"请先设置安全密码" cancelButton:@"确定" otherButton:nil delegate:self tag:1000];
        }else{
            [self performSegueWithIdentifier:@"updateSegue" sender:self];
        }
        
    } failure:nil];
    
}
#pragma mark - UITableViewDelegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"secretCell";
    SecretModel *model = [self.dataSource objectAtIndex:indexPath.row];
    SecretCell *cell = (SecretCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (![NSString isBlankString:model.imageName]) {
        cell.imageview.image = [UIImage imageNamed:model.imageName];
    }
    cell.titleLabel.text = model.titleString;
    cell.detailLabel.text = model.detailString;
    cell.updateButton.tag = indexPath.row;
    [cell.updateButton addTarget:self action:@selector(updateAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - actions
- (void)updateAction:(UIButton *)sender{
    SecretModel *model = [self.dataSource objectAtIndex:sender.tag];
    
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1000) {
        [self performSegueWithIdentifier:@"SafeKeySegue" sender:self];
    }
}
@end
