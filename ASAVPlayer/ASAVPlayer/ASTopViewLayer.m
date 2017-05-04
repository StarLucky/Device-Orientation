//
//  ASTopViewLayer.m
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "ASTopViewLayer.h"
@interface ASTopViewLayer ()
{
    UIView *_topView;
    UIView *_superView;
    UIImageView *_shadowV;
    UIButton *_backBtn;
}
@end

@implementation ASTopViewLayer
-(instancetype)initWithSuperView:(UIView *)superView
{
    if (self = [super init])
    {
        _superView = superView;
        [self setSubviews];
        [self setHalfFrame];
    }
    return self;
}
-(void)setSubviews
{
    UIView *topViewLayer =[[UIView alloc] init];
    [_superView addSubview:topViewLayer];
    _topViewLayer = topViewLayer;
    
    UIImageView *shadowV =[[UIImageView alloc] init];
    _shadowV = shadowV;
    [_topViewLayer addSubview:_shadowV];
    
    UIView *topView =[[UIView alloc] init];
    _topView = topView;
    [_topViewLayer addSubview:topView];
    
    UIButton *backBtn =[[UIButton alloc] init];
    _backBtn = backBtn;
    [_topView addSubview:backBtn];
    [backBtn setIconfontSize:25];
    backBtn.text = @"\U0000e607";
}
-(void)setHalfFrame
{
    k_makeFloat;
    viewW = _superView.width,viewH = 80;
    _topViewLayer.frame = set_standard_frame;
    _shadowV.frame = _topViewLayer.bounds;
    _topView.frame = _topViewLayer.bounds;
    
    viewX = 0,viewW = 50,viewH = viewW,viewY = (_topViewLayer.height-viewH)/2+10;
    _backBtn.frame = set_standard_frame;
    
    viewX = maxX(_backBtn.frame)+22;
    self.nameL.frame = set_standard_frame;
}

-(void)setFullFrame
{
    CGFloat superW = _superView.height;
    k_makeFloat;
    viewW = superW,viewH = 80;
    _topViewLayer.frame = set_standard_frame;
    _shadowV.frame = _topViewLayer.bounds;
    _topView.frame = _topViewLayer.bounds;
    
    viewX = 0,viewW = 50,viewH = viewW,viewY = (_topViewLayer.height-viewH)/2+10;
    _backBtn.frame = set_standard_frame;
    
    viewX = maxX(_backBtn.frame)+22;
    self.nameL.frame = set_standard_frame;
}
-(void)setTitleName:(NSString *)name
{
    [_topView addSubview:self.nameL];
    _nameL.text = name;
//    [_nameL sizeToFit];
}
-(UILabel *)nameL
{
    if (!_nameL)
    {
        UILabel *nameL =[[UILabel alloc] init];
        _nameL = nameL;
        _nameL.font = font(25);
        _nameL.textColor = [UIColor whiteColor];
        [_topView addSubview:nameL];
    }
    return _nameL;
}

-(void)hidden
{
    _topViewLayer.hidden = YES;
}
-(void)show
{
    _topViewLayer.hidden = NO;
}

-(void)fullClick
{
    
}
@end
