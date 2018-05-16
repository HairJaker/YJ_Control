//
//  UISearchBar+JCM_SearchBarPlaceholder.m
//  竞彩猫
//
//  Created by yujie on 2017/7/22.
//  Copyright © 2017年 yujie. All rights reserved.
//

#import "UISearchBar+JCM_SearchBarPlaceholder.h"

@implementation UISearchBar (JCM_SearchBarPlaceholder)

-(void)changePlaceholderToLeft:(NSString *)placeholder{
    
    self.placeholder = placeholder;
    
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",@"setCenter",@"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centerdPlaceholder = NO;
        NSMethodSignature * signature = [[UISearchBar class]instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centerdPlaceholder atIndex:2];
        [invocation invoke];
    }
    
}

-(void)changePlaceholderToLeft{
    
    SEL centerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",@"setCenter",@"Placeholder:"]);
    if ([self respondsToSelector:centerSelector]) {
        BOOL centerdPlaceholder = NO;
        NSMethodSignature * signature = [[UISearchBar class]instanceMethodSignatureForSelector:centerSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:centerSelector];
        [invocation setArgument:&centerdPlaceholder atIndex:2];
        [invocation invoke];
    }
    
}

@end
