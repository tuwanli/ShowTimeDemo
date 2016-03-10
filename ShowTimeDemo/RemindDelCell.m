//
//  RemindDelCell.m
//  EEDS
//
//  Created by 涂婉丽 on 16/2/2.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "RemindDelCell.h"

@implementation RemindDelCell

- (void)awakeFromNib {
    /*
    self.remindL.textColor = [UIColor colorWithHexString:[ThemeSingleton sharedInstance].RemindVCTitleFontColor alpha:1];
    [self.remindL setFont:[UIFont systemFontOfSize:[ThemeSingleton sharedInstance].RemindVCTitleFontSize.floatValue]];
    self.typeL.textColor = [UIColor colorWithHexString:[ThemeSingleton sharedInstance].RemindVCDetialFontColor alpha:1];
    [self.typeL setFont:[UIFont systemFontOfSize:[ThemeSingleton sharedInstance].RemindVCDetialFontSize.floatValue]];
    [self.dateLabel setTextColor:[UIColor colorWithHexString:[ThemeSingleton sharedInstance].RemindVCTimeFontColor alpha:1]];
    [self.dateLabel setFont:[UIFont systemFontOfSize:[ThemeSingleton sharedInstance].RemindVCTimeFontSize.floatValue]];
    [self.timeLabel setTextColor:[UIColor colorWithHexString:[ThemeSingleton sharedInstance].RemindVCTimeFontColor alpha:1]];
    [self.timeLabel setFont:[UIFont systemFontOfSize:[ThemeSingleton sharedInstance].RemindVCTimeFontSize.floatValue]];
    */
    
}
+(instancetype)cellWithTab:(UITableView *)tableView
{
    
    static NSString *cellID = @"cell";
    RemindDelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        return [[NSBundle mainBundle]loadNibNamed:@"RemindDelCell" owner:self options:nil][0];
    }
    
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
