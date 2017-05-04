//
//  UIButton+buttonSet.h
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/6.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (buttonSet)
@property (nonatomic,copy) NSString *text;
-(void)setIconfontSize:(CGFloat)size;
-(void)setUIfontWithSize:(CGFloat)size;
@end
