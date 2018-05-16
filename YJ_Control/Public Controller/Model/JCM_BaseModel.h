//
//  JCM_BaseModel.h
//  竞彩猫
//
//  Created by yujie on 17/1/11.
//  Copyright © 2017年 yujie. All rights reserved.
//

@interface JCM_BaseModel : JSONModel

@property (nonatomic,copy) NSString<Optional> * status;
@property (nonatomic,copy) NSString<Optional> * message;
@property (nonatomic,copy) NSString<Optional> * last_login_time;
@property (nonatomic,copy) NSString<Optional> * device_name;

@end
