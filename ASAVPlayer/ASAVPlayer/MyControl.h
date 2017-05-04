//
//  MyControl.h
//艺考在线APP	[项目名称]
//
//Created by 刘野 on 2016/5/25
//Copyright 2016  北京育艺之星科技有限公司. All rights reserved.
//
//系统名称:封装
/*
 这个类就可以为我们专门来创建一些基本的控件，那么如果要创建Label button textField 就可以通过这个类来创建
 这个类好像一个工厂一样专门生产一些基本控件
 类似于工厂设计模式
 */
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASPublicFile.h"
#import <AVFoundation/AVFoundation.h>


//TimeStyle timeStyle =TimeStyleYMD;

@interface MyControl : NSObject
- (NSDictionary *)timeStringWitherPlayer:(AVPlayer *)player;
- (NSDictionary *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;

@end
