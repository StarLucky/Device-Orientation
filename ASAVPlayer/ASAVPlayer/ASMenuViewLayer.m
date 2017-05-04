//
//  ASMenuViewLayer.m
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "ASMenuViewLayer.h"
@interface ASMenuViewLayer()
{
    UIImageView *_shadowV;
    UIView *_menuView;
    UIView *_superView;
    
}
@end
@implementation ASMenuViewLayer
-(instancetype)initWithSuperView:(UIView *)superView
{
    if (self = [super init])
    {
        _superView = superView;
        [self initSubviews];
    }
    return self;
}
-(void)initSubviews
{
    UIView *menuViewLayer =[[UIView alloc] init];
    _menuViewLayer = menuViewLayer;
    [_superView addSubview:_menuViewLayer];
    
    UIImageView *shadowV =[[UIImageView alloc] init];
    _shadowV = shadowV;
    [_menuViewLayer addSubview:shadowV];
    
    UIView *menuView =[[UIView alloc] init];
    _menuView = menuView;
    [_menuViewLayer addSubview:_menuView];
    
    UIButton *playBtn =[[UIButton alloc] init];
    _playBtn = playBtn;
    [_menuView addSubview:playBtn];
    
    UILabel *currentTime =[[UILabel alloc] init];
    _currentTime = currentTime;
    [_menuView addSubview:currentTime];
    _currentTime.font = font(9);
    _currentTime.textColor = k_whiteColor;
    
    UILabel *timeLenth =[[UILabel alloc] init];
    _timeLenth = timeLenth ;
    [_menuView addSubview:timeLenth];
    _timeLenth.font = font(9);
    _timeLenth.textColor = k_whiteColor;
    
    UIButton *fullBtn =[[UIButton alloc] init];
    _fullBtn = fullBtn;
    [_menuView addSubview:fullBtn];
    
    UISlider *slider =[[UISlider alloc] init];
    _slider = slider;
    [_menuView addSubview:_slider];
    
    [self setHalfFrame];
}

-(void)setHalfFrame
{
    k_makeFloat;
    viewW = _superView.width,viewH = 80,viewY = _superView.height-viewH;
    _menuViewLayer.frame = set_standard_frame;
    _shadowV.frame = _menuViewLayer.bounds;
    _menuView.frame = _menuViewLayer.bounds;
    viewW = 50,viewH = 50,viewY = (_menuViewLayer.height-viewH)/2;
    _playBtn.frame = set_standard_frame;
    viewX = _superView.width-viewW,viewY = (_menuViewLayer.height-viewH)/2;
    _fullBtn.frame = set_standard_frame;

    viewX = maxX(_playBtn.frame)+5,viewW = 40,viewH = 20,viewY = (_menuViewLayer.height-viewH)/2+20/2;
    _currentTime.frame = set_standard_frame;
    
    viewX = minX(_fullBtn.frame)-viewW;
    _timeLenth.frame = set_standard_frame;
    
    viewX = maxX(_currentTime.frame),viewW = minX(_timeLenth.frame)-viewX;
    _slider.frame = set_standard_frame;
}

-(void)setFullFrame
{
    NSLog(@"%f %f",_superView.width,_superView.height);
    CGFloat superW = _superView.height,superH = _superView.width;
    k_makeFloat;
    viewW = superW,viewH = 80,viewY = superH-viewH;
    _menuViewLayer.frame = set_standard_frame;

    _shadowV.frame = _menuViewLayer.bounds;
    _menuView.frame = _menuViewLayer.bounds;
    viewW = 50,viewH = 50,viewY = (_menuViewLayer.height-viewH)/2;
    _playBtn.frame = set_standard_frame;
    viewX = superW-viewW,viewY = (_menuViewLayer.height-viewH)/2;
    _fullBtn.frame = set_standard_frame;
    
    viewX = maxX(_playBtn.frame)+5,viewW = 40,viewH = 20,viewY = (_menuViewLayer.height-viewH)/2+20/2;
    _currentTime.frame = set_standard_frame;
    
    viewX = minX(_fullBtn.frame)-viewW;
    _timeLenth.frame = set_standard_frame;
    
    viewX = maxX(_currentTime.frame),viewW = minX(_timeLenth.frame)-viewX;
    _slider.frame = set_standard_frame;
}
-(void)show
{
    _menuViewLayer.hidden = NO;
}
-(void)hidden
{
    _menuViewLayer.hidden = YES;
}
@end
