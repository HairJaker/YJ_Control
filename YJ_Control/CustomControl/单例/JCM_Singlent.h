//
//  JCM_Singlent.h
//  竞彩猫
//
//  Created by yujie on 17/1/12.
//  Copyright © 2017年 yujie. All rights reserved.
//

#ifndef JCM_Singlent_h
#define JCM_Singlent_h

#define singlent_for_interface(className) + (className*)shared##className;

#define singlent_for_implementation(className) static className*_instance;\
+(id)allocWithZone:(NSZone*)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+(className*)shared##className{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,^{\
_instance = [[className alloc]init];\
});\
return _instance;\
}

#endif /* JCM_Singlent_h */
