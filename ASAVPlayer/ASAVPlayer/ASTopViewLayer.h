//
//  ASTopViewLayer.h
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPublicFile.h"
#import <UIKit/UIKit.h>
@interface ASTopViewLayer : NSObject
@property (nonatomic,weak) UIView *topViewLayer;;
@property (nonatomic,weak) UILabel *nameL;

-(instancetype)initWithSuperView:(UIView *)superView;
-(void)setTitleName:(NSString *)name;
-(void)hidden;
-(void)show;
-(void)setHalfFrame;
-(void)setFullFrame;
@end
