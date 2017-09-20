//
//  XHCustomTableViewCell.m
//  QiYuKF
//
//  Created by XH-LWR on 2017/9/20.
//  Copyright © 2017年 linwenrui. All rights reserved.
//

#import "XHCustomTableViewCell.h"

@interface XHCustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *unReadLab;

@end

@implementation XHCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setQySessionInfo:(QYSessionInfo *)qySessionInfo {

    self.headImg.image = [UIImage imageNamed:@"icon_customer_avatar"];
    self.titleLab.text = qySessionInfo.lastMessageText;
    self.unReadLab.text = [NSString stringWithFormat:@"%ld", qySessionInfo.unreadCount];
    // 时间戳 -> 时间
    // 格式化时间
    NSDateFormatter *formatte = [[NSDateFormatter alloc] init];
    formatte.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatte setDateStyle:NSDateFormatterMediumStyle];
    [formatte setTimeStyle:NSDateFormatterShortStyle];
    [formatte setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒转为妙
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:qySessionInfo.lastMessageTimeStamp];
    self.subLab.text = [formatte stringFromDate:date];
}

+ (NSString *)cellReuserIdentifier {

    return @"XHCustomTableViewCell";
}

@end
