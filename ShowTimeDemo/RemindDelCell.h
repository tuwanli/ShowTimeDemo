//
//  RemindDelCell.h
//  EEDS
//
//  Created by 涂婉丽 on 16/2/2.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemindDelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *lable;

@property (weak, nonatomic) IBOutlet UILabel *remindL;

@property (weak, nonatomic) IBOutlet UILabel *typeL;


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remindLCon;


@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
+(instancetype)cellWithTab:(UITableView *)tableView;
@end
