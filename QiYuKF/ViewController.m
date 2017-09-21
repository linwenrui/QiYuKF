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

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, QYConversationManagerDelegate> {

    BOOL _isDefault; // 是否为默认的主题
}

@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray<QYSessionInfo *> *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isDefault = YES;
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

#pragma mark - 切换主题

- (IBAction)onChangeSkin {

    if (_isDefault) {
        
        _isDefault = NO;
        [[QYSDK sharedSDK] customUIConfig].customMessageTextColor = [UIColor blackColor];
        [[QYSDK sharedSDK] customUIConfig].customMessageHyperLinkColor = [UIColor blackColor];
        [[QYSDK sharedSDK] customUIConfig].serviceMessageTextColor = [UIColor blackColor];
        [[QYSDK sharedSDK] customUIConfig].serviceMessageHyperLinkColor = [UIColor blueColor];
        
        UIImage *backgroundImage = [[UIImage imageNamed:@"session_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:backgroundImage];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [[QYSDK sharedSDK] customUIConfig].sessionBackground = imageView;
        
//        [[QYSDK sharedSDK] customUIConfig].customerHeadImage = [UIImage imageNamed:@"customer_head"];
        [[QYSDK sharedSDK] customUIConfig].customerHeadImageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505976221073&di=9c6a59ae86e94aa7301c629457586d2d&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F17%2F50%2F22%2F17i58PICydQ_1024.jpg";
        [[QYSDK sharedSDK] customUIConfig].serviceHeadImage = [UIImage imageNamed:@"service_head"];
        [[QYSDK sharedSDK] customUIConfig].serviceHeadImageUrl = @"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg";
        
//        [[QYSDK sharedSDK] customUIConfig].customerMessageBubbleNormalImage = [[UIImage imageNamed:@"icon_sender_node"]
//                                                                               resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,30,30)
//                                                                               resizingMode:UIImageResizingModeStretch];
//        [[QYSDK sharedSDK] customUIConfig].customerMessageBubblePressedImage = [[UIImage imageNamed:@"icon_sender_node"]
//                                                                                resizableImageWithCapInsets:UIEdgeInsetsMake(15,15,30,30)
//                                                                                resizingMode:UIImageResizingModeStretch];
        [[QYSDK sharedSDK] customUIConfig].serviceMessageBubbleNormalImage = [[UIImage imageNamed:@"icon_receiver_node"]
                                                                              resizableImageWithCapInsets:UIEdgeInsetsMake(15,30,30,15)
                                                                              resizingMode:UIImageResizingModeStretch];
        [[QYSDK sharedSDK] customUIConfig].serviceMessageBubblePressedImage = [[UIImage imageNamed:@"icon_receiver_node"]
                                                                               resizableImageWithCapInsets:UIEdgeInsetsMake(15,30,30,15)
                                                                               resizingMode:UIImageResizingModeStretch];
        [[QYSDK sharedSDK] customUIConfig].rightBarButtonItemColorBlackOrWhite = NO;
    } else {
    
        _isDefault = true;
        [[[QYSDK sharedSDK] customUIConfig] restoreToDefault];
    }
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

    /**
    // 携带商品信息
    QYCommodityInfo *commodityInfo = [[QYCommodityInfo alloc] init];
    commodityInfo.title = @"网易七鱼";
    commodityInfo.desc = @"网易七鱼是网易旗下一款专注于解决企业与客户沟通的客服系统产品。";
    commodityInfo.pictureUrlString = @"http://qiyukf.com/main/res/img/index/barcode.png";
    commodityInfo.urlString = @"http://qiyukf.com/";
    commodityInfo.note = @"￥10000";
    commodityInfo.show = YES; //访客端是否要在消息中显示商品信息，YES代表显示,NO代表不显示
     */
    
    QYSource *source = [[QYSource alloc] init];
    source.title = @"七鱼客服";
    source.urlString = @"https://8.163.com/";
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"七鱼客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
//    sessionViewController.commodityInfo = commodityInfo;
    
    // 添加用户信息
    QYUserInfo *userInfo = [[QYUserInfo alloc] init];
    userInfo.userId = @"123456";
    userInfo.data = @"[{\"key\":\"real_name\", \"value\":\"锐哥\"},"
    "{\"key\":\"mobile_phone\", \"value\":\"18501992184\"},"
    "{\"key\":\"email\", \"value\":\"13800000000@163.com\"},"
    "{\"index\":0, \"key\":\"account\", \"label\":\"账号\", \"value\":\"zhangsan\", \"href\":\"http://www.baidu.com\"},"
    "{\"index\":1, \"key\":\"sex\", \"label\":\"性别\", \"value\":\"先生\"},"
    "{\"index\":5, \"key\":\"reg_date\", \"label\":\"注册日期\", \"value\":\"2015-11-16\"},"
    "{\"index\":6, \"key\":\"last_login\", \"label\":\"上次登录时间\", \"value\":\"2015-12-22 15:38:54\"}]";
    
    [[QYSDK sharedSDK] setUserInfo:userInfo];
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
