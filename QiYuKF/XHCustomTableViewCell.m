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
    
    // 精确化时间
    self.subLab.text = [self showTime:qySessionInfo.lastMessageTimeStamp];
}

- (NSString *)showTime:(NSTimeInterval)msglastTime {

    // 今天的时间
    NSDate *nowDate = [NSDate date];
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:msglastTime];
    NSString *result = nil;
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *nowDateComponents = [[NSCalendar currentCalendar] components:components fromDate:nowDate];
    NSDateComponents *msgDateComponents = [[NSCalendar currentCalendar] components:components fromDate:msgDate];
    NSDate *today = [[NSDate alloc] init];
    NSTimeInterval secondsDay = 24 * 60 * 60;
    NSDate *yesterday = [today dateByAddingTimeInterval:-secondsDay];
    NSDateComponents *yesterdayDateComponents = [[NSCalendar currentCalendar] components:components fromDate:yesterday];
    NSInteger hour = msgDateComponents.hour;
    result = @"";
    
    if (nowDateComponents.year == msgDateComponents.year
        && nowDateComponents.month == msgDateComponents.month
        && nowDateComponents.day == msgDateComponents.day) { // 今天, hh:mm
    
        result = [[NSString alloc] initWithFormat:@"%@ %zd:%02d", result, hour, (int)msgDateComponents.minute];
    } else if (yesterdayDateComponents.year == msgDateComponents.year
               && yesterdayDateComponents.month == msgDateComponents.month
               && yesterdayDateComponents.day == msgDateComponents.day) { // 昨天, 昨天 hh:mm
        
        result = [[NSString alloc] initWithFormat:@"昨天%@ %zd:%02d", result, hour, (int)msgDateComponents.minute];
    } else if (nowDateComponents.year == msgDateComponents.year) { // 今年, MM/dd hh:mm
    
        result = [NSString stringWithFormat:@"%02d/%02d %zd:%02d", (int)msgDateComponents.month, (int)msgDateComponents.day, msgDateComponents.hour, (int)msgDateComponents.minute];
    } else if (nowDateComponents.year != msgDateComponents.year) { // 跨年, YY/MM/dd hh:mm
    
        NSString *day = [NSString stringWithFormat:@"%02d/%02d/%02d", (int)(msgDateComponents.year % 100), (int)msgDateComponents.month, (int)msgDateComponents.day];
        result = [day stringByAppendingFormat:@" %@ %zd:%02d", result, hour, (int)msgDateComponents.minute];
    }

    return result;
}

+ (NSString *)cellReuserIdentifier {

    return @"XHCustomTableViewCell";
}

@end
