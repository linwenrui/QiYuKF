//
//  XHCustomTableViewCell.h
//  QiYuKF
//
//  Created by XH-LWR on 2017/9/20.
//  Copyright © 2017年 linwenrui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYSDK.h"

@interface XHCustomTableViewCell : UITableViewCell

@property (nonatomic, strong) QYSessionInfo *qySessionInfo;

+ (NSString *)cellReuserIdentifier;

@end
