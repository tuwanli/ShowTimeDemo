//
//  RemindModel.h
//  EEDS
//
//  Created by 涂婉丽 on 16/1/19.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemindModel : NSObject

@property (nonatomic,copy) NSString *authorityId;
@property (nonatomic,copy) NSString *createDate;
@property (nonatomic,copy) NSString *createUserId;
@property (nonatomic,copy) NSString *createUserName;
@property (nonatomic,copy) NSString *fee;
@property (nonatomic,copy) NSString *floorUrl;
@property (nonatomic,copy) NSString *hspConfigBaseinfoId;
@property (nonatomic,copy) NSString *remindID;
@property (nonatomic,copy) NSString *isPush;
@property (nonatomic,copy) NSString *isread;
@property (nonatomic,copy) NSString *megTypeId;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *messageResult;
@property (nonatomic,copy) NSString *patientId;
@property (nonatomic,copy) NSString *phoneUserId;
@property (nonatomic,copy) NSString *photoUrl;
@property (nonatomic,copy) NSString *remindtenantId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,retain) NSArray *messageArr;//解析message中的数据

@property BOOL isDelete;//记录是否删除
@property (nonatomic,retain) NSIndexPath *indexPath;//记录删除位置
@end
