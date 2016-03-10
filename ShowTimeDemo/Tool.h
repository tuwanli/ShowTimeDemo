//
//  Tool.h
//  AreaApplication
//
//  Created by 涂婉丽 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tool : NSObject


/**
 *  遍历消息列表
 *
 *  @param messageId <#messageId description#>
 */
//+ (void)searchMessageId:(NSString *)messageId;

/**
 *  返回周几
 *
 *  @param format <#format description#>
 *
 *  @return <#return value description#>
 */
+ (NSString*)weekDayStr:(NSDate *)format;

/**
 *  消息列表返回时间
 *
 *  @param timeStr <#timeStr description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)remindlistTime:(NSString *)timeStr;




@end
