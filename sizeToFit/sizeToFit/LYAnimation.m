//
//  LYAnimation.m
//  Arte_Dimension
//
//  Created by 韩智星 on 2017/5/2.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "LYAnimation.h"

@implementation LYAnimation
+(void)rippleShakeAnimation:(UIView *)view Subtype:(NSString *)subtype
{//kCATransitionFromBottom

    CATransition *trans = [CATransition animation];
    trans.duration = 0.5;
    trans.type = @"rippleEffect";
    trans.subtype = subtype;
    [view.layer addAnimation:trans forKey:nil];
}
@end
