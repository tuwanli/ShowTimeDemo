//
//  Tool.m
//  AreaApplication
//
//  Created by 涂婉丽 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "Tool.h"

@implementation Tool



/*
+ (void)searchMessageId:(NSString *)messageId
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"verbId":@"getMessageList",@"userId":[UserConfig getInstance].userID,@"tenantId":tenantId,@"currentPage":@"1"};
    
    [manager POST:BASE_URL(@"messageAction.do?") parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         DLog(@"提醒------%@",responseObject);
         if ([[responseObject objectForKey:@"flag"] intValue] == 0){
            
             
             NSArray *array = [responseObject objectForKey:@"data"];
             for (NSDictionary *tempDic in array) {
                 RemindModel *model = [[RemindModel alloc]init];
                 [model setValuesForKeysWithDictionary:tempDic];
                 if ([model.remindID isEqualToString:messageId]) {
                     [(AppDelegate *)[[UIApplication sharedApplication] delegate] comePushToDetailPageWithModel:model];
                     break;
                 }
             }

         }
         
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          }
     ];
    
}
*/
+ (NSString*)weekDayStr:(NSDate *)format
{
    NSString *weekDayStr = nil;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour |NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:format];
    
    NSString *str = [self description];
    if (str.length >= 10) {
        NSString *nowString = [str substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if (array.count == 0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if (array.count >= 3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    week ++;
    switch (week) {
        case 1:
            weekDayStr = @"星期日";
            break;
        case 2:
            weekDayStr = @"星期一";
            break;
        case 3:
            weekDayStr = @"星期二";
            break;
        case 4:
            weekDayStr = @"星期三";
            break;
        case 5:
            weekDayStr = @"星期四";
            break;
        case 6:
            weekDayStr = @"星期五";
            break;
        case 7:
            weekDayStr = @"星期六";
            break;
        default:
            weekDayStr = @"";  
            break;  
    }  
    return weekDayStr;  
}
+ (NSString *)remindlistTime:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
     NSDate* date = [formatter dateFromString:timeStr];
    
    
    
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday,*weekday;
    
    weekday = [today dateByAddingTimeInterval: -(secondsPerDay*7)];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString])
    {
        return @"今天";
    } else if ([dateString isEqualToString:yesterdayString])
    {
        return @"昨天";
    }else if ([weekday timeIntervalSince1970]>[date timeIntervalSince1970]){
        
        NSArray *timeArr = [[[timeStr componentsSeparatedByString:@" "] objectAtIndex:0] componentsSeparatedByString:@"-"];
        NSString *dayTime;
        NSString *monthlyTime;
        if ([[timeArr[2] substringToIndex:1] isEqualToString:@"0"]) {
            dayTime = [timeArr[2] substringFromIndex:1];
        }else{
            dayTime = timeArr[2];
        }
        if ([[timeArr[1] substringToIndex:1] isEqualToString:@"0"]) {
            monthlyTime = [timeArr[1] substringFromIndex:1];
        }else{
            monthlyTime = timeArr[1];
        }
        return [NSString stringWithFormat:@"%@/%@/%@",[(NSString *)timeArr[0] substringFromIndex:2],monthlyTime,dayTime];
    }
    else
    {
        return [Tool weekDayStr:date];
    }
    
}


@end
