//
//  ViewController.m
//  QiYuKF
//
//  Created by XH-LWR on 2017/9/20.
//  Copyright © 2017年 linwenrui. All rights reserved.
//

#import "ViewController.h"
#import "QYSDK.h"
#import "XHCustomTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, QYConversationManagerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray<QYSessionInfo *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableview.tableFooterView = [UIView new];
    
    // 获取会话列表
    [self getConversationList];
    
    // 设置代理
    [[[QYSDK sharedSDK] conversationManager] setDelegate:self];
    
    // 自定义聊天组件事件处理
    [self customActionConfig];
}

#pragma mark - 获取会话列表

- (void)getConversationList {

    [self.dataSource addObjectsFromArray:[[[QYSDK sharedSDK] conversationManager] getSessionList]];
    [self.tableview reloadData];
}

#pragma mark - customActionConfig

- (void)customActionConfig {

    [[QYSDK sharedSDK] customActionConfig].linkClickBlock = ^(NSString *linkAddress) {
    
        NSLog(@"点击的链接: %@", linkAddress);
    };
}

#pragma mark - 七鱼客服

- (IBAction)qiyukfClick {

    // 集成方式一
    QYSource *source = [[QYSource alloc] init];
    source.title = @"七鱼客服";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"七鱼客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

#pragma mark - 注销

- (IBAction)logout {

    [[QYSDK sharedSDK] logout:^{
        
        NSLog(@"注销成功");
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XHCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[XHCustomTableViewCell cellReuserIdentifier] forIndexPath:indexPath];
    cell.qySessionInfo = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // 携带商品信息
    QYCommodityInfo *commodityInfo = [[QYCommodityInfo alloc] init];
    commodityInfo.title = @"网易七鱼";
    commodityInfo.desc = @"网易七鱼是网易旗下一款专注于解决企业与客户沟通的客服系统产品。";
    commodityInfo.pictureUrlString = @"http://qiyukf.com/main/res/img/index/barcode.png";
    commodityInfo.urlString = @"http://qiyukf.com/";
    commodityInfo.note = @"￥10000";
    commodityInfo.show = YES; //访客端是否要在消息中显示商品信息，YES代表显示,NO代表不显示
    
    QYSource *source = [[QYSource alloc] init];
    source.title = @"七鱼客服";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"七鱼客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    sessionViewController.commodityInfo = commodityInfo;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}

#pragma mark - QYConversationManagerDelegate 

- (void)onSessionListChanged:(NSArray<QYSessionInfo *> *)sessionList {

    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:sessionList];
    [self.tableview reloadData];
}

- (void)onReceiveMessage:(QYMessageInfo *)message {

    
}

#pragma mark - getter

- (NSMutableArray<QYSessionInfo *> *)dataSource {

    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
