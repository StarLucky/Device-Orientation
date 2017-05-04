//
//  UIButton+buttonSet.m
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/6.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "UIButton+buttonSet.h"

@implementation UIButton (buttonSet)
-(void)setText:(NSString *)text
{
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)setIconfontSize:(CGFloat)size
{
    self.titleLabel.font = [UIFont fontWithName:@"iconfont" size:size];
}

-(void)setUIfontWithSize:(CGFloat)size
{
    self.titleLabel.font = [UIFont systemFontOfSize:size];
}
@end
