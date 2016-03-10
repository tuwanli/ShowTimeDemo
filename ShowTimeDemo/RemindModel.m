//
//  RemindModel.m
//  EEDS
//
//  Created by 涂婉丽 on 16/1/19.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "RemindModel.h"

@implementation RemindModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        [self setRemindID:value];
    }else if ([key isEqualToString:@"tenantId"]){
        [self setRemindtenantId:value];
    }
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    
    if ([value isKindOfClass:[NSString class]]) {
        [super setValue:value forKey:key];
    }else{
        value = [NSString stringWithFormat:@"%@",value];
        [super setValue:value forKey:key];
    }
    if ([key isEqualToString:@"message"]){
        [super setValue:value forKey:key];
        self.messageArr = [(NSString *)value componentsSeparatedByString:@";"];
    }else{
        [super setValue:value forKey:key];
    }
    
    
}
@end
