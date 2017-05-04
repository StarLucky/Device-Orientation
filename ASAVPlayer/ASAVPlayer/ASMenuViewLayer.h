//
//  ASMenuViewLayer.h
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPublicFile.h"

#import <UIKit/UIKit.h>
@interface ASMenuViewLayer : NSObject
@property (nonatomic,weak) UIView *menuViewLayer;
@property (nonatomic,weak) UILabel *currentTime;
@property (nonatomic,weak) UILabel *timeLenth;
@property (nonatomic,weak) UISlider *slider;
@property (nonatomic,weak) UIButton *fullBtn;
@property (nonatomic,weak) UIButton *playBtn;

-(instancetype)initWithSuperView:(UIView *)superView;
-(void)hidden;
-(void)show;
-(void)setHalfFrame;
-(void)setFullFrame;
@end
