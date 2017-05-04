//
//  ASAVPlayer.h
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSInteger, ASMoveTouchType) {
    ASMoveTouchLightType = 1,    //亮度
    ASMoveTouchVolumeType,          //声音
    ASMoveTouchProgressType,          //快进快退
    ASMoveTouchNoneType,                //清除枚举
};
@interface ASAVPlayer : NSObject
{
    ASMoveTouchType _moveTouchType;
}
/**
 播放器
 */
@property (nonatomic,weak) AVPlayer *player;
@property (nonatomic,weak) AVPlayerItem *playItme;

/**
 player 载体layer
 */
@property (nonatomic,weak) AVPlayerLayer *playerLayer;


/**
 初始化

 @param URL 视频地址
 @param superView 父view
 @param controller 控制器
 @return self
 */
-(instancetype)initWithURL:(NSString *)URL SuperView:(UIView*)superView Controller:(UIViewController *)controller;;

/**
 开始
 */
-(void)start;

/**
 暂停
 */
-(void)stop;

/**
 重力感应 旋转屏幕方向
 */
-(void)automaticChangeOrientation;
@end
