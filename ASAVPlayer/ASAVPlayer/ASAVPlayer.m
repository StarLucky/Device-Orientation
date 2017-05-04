//
//  ASAVPlayer.m
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/4/1.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "ASAVPlayer.h"
#import "ASPublicFile.h"
#import "ASMenuViewLayer.h"
#import "ASTopViewLayer.h"
#import <MediaPlayer/MediaPlayer.h>
#define K_LeastMoveDistance 10
@interface ASAVPlayer()
{
    UIInterfaceOrientation _currentOrientation;
    UIViewController *_controller;
    UIView *_superView;             //全屏
    UIView *_fullView;              //半屏
    NSString *_URL;
    ASMenuViewLayer *_menuViewLayer;
    ASTopViewLayer *_topViewLayer;
    CGRect _superFrame;
    NSTimer *_progressTimer;
    UISlider *_volumeSlider;        //声音控件

    CGPoint _moveTouchPoint;
    CGPoint _beginMovePoint;
}
@property (nonatomic, strong) MPVolumeView   *volumeView;             //音量控制控件
@property (nonatomic,assign,setter=setFull:,getter=isFull) BOOL fullScreen;
@end

@implementation ASAVPlayer
#pragma mark - 获取声音类
- (MPVolumeView *)volumeView {
    if (!_volumeView)
    {
        _volumeView = [[MPVolumeView alloc] init];
        _volumeView.showsRouteButton = NO;
        _volumeView.showsVolumeSlider = NO;
        _volumeView.hidden = YES;
        for (UIView * view in _volumeView.subviews)
        {
            if ([NSStringFromClass(view.class) isEqualToString:@"MPVolumeSlider"])
            {
                _volumeSlider = (UISlider *)view;
                break;
            }
        }
    }
    return _volumeView;
}
#pragma mark - 初始化
-(instancetype)initWithURL:(NSString *)URL SuperView:(UIView*)superView Controller:(UIViewController *)controller;
{
    if (self = [super init])
    {
        _moveTouchType = ASMoveTouchNoneType;
        _controller = controller;
        _superView = superView;
        _fullView = controller.view;
        _superFrame = _superView.frame;
        _URL = URL;
        UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        panGesture.minimumNumberOfTouches = 1;
        panGesture.maximumNumberOfTouches = 1;
        [_superView addGestureRecognizer:panGesture];
        
        UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
        [_superView addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)setMenuViewLayer
{
    if (!_menuViewLayer)
    {
        ASMenuViewLayer *menuViewLayer =[[ASMenuViewLayer alloc] initWithSuperView:_superView];
        _menuViewLayer = menuViewLayer;
        [_menuViewLayer.fullBtn addTarget:self action:@selector(fullScreen) forControlEvents:UIControlEventTouchUpInside];
        
        ASTopViewLayer *topViewLayer =[[ASTopViewLayer alloc] initWithSuperView:_superView];
        _topViewLayer = topViewLayer;
        [_topViewLayer setTitleName:@"111"];
        
        [_menuViewLayer.slider addTarget:self action:@selector(slideVideoProgress:) forControlEvents:UIControlEventValueChanged];
        [_menuViewLayer.slider addTarget:self action:@selector(sliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_superView addSubview:self.volumeView];
    }
}
#pragma mark - 平移手势  快进 亮度  声音
-(void)tapGesture
{
    if (_topViewLayer.topViewLayer.hidden)
    {
        [_topViewLayer show];
        [_menuViewLayer show];
    }else
    {
        [_topViewLayer hidden];
        [_menuViewLayer hidden];
    }
    [[UIApplication sharedApplication] setStatusBarHidden:_topViewLayer.topViewLayer.hidden];
}

-(void)panGesture:(UIPanGestureRecognizer *)pan
{
    _moveTouchPoint = [pan locationInView:_superView];
    if ([pan state] == UIGestureRecognizerStateBegan)
    {
        _beginMovePoint = [pan locationInView:_superView];
    }
    
    if ([pan state] == UIGestureRecognizerStateChanged)
    {
        if (fabs(_moveTouchPoint.x - _beginMovePoint.x) < K_LeastMoveDistance && fabs(_moveTouchPoint.y - _beginMovePoint.y) < K_LeastMoveDistance) {
            return;
        }
        [self setMoveTouchType];
        [self moveTouchTypeStartUp];
    }
    
    if ([pan state] == UIGestureRecognizerStateEnded)
    {
        //清除枚举
        _moveTouchType = ASMoveTouchNoneType;
        NSLog(@"结束");
    }
}
-(void)setMoveTouchType
{
    if (_moveTouchType == ASMoveTouchNoneType)
    {
        if (fabs((_moveTouchPoint.y-_beginMovePoint.y)/(_moveTouchPoint.x-_beginMovePoint.x))>1)
        {
            if (_moveTouchPoint.x>ScreenW/2)
            {
                _moveTouchType = ASMoveTouchVolumeType;
            }else
            {
                _moveTouchType = ASMoveTouchLightType;
            }
        }else
        {
            _moveTouchType = ASMoveTouchProgressType;
        }
    }
}
-(void)moveTouchTypeStartUp
{
    if (_moveTouchType == ASMoveTouchLightType)
    {
        NSLog(@"左-亮度");
        CGFloat currentLight = [UIScreen mainScreen].brightness;
        currentLight+=((_beginMovePoint.y - _moveTouchPoint.y) / 200);
        [[UIScreen mainScreen] setBrightness:currentLight];
        _beginMovePoint = _moveTouchPoint;
    }else if (_moveTouchType == ASMoveTouchVolumeType)
    {
        NSLog(@"右-声音 %f",_superView.height);
        _volumeSlider.value = _volumeSlider.value+=(_beginMovePoint.y - _moveTouchPoint.y) / 200;
        _beginMovePoint = _moveTouchPoint;
        
    }else if (_moveTouchType == ASMoveTouchProgressType)
    {
        NSLog(@"快进");
    }
}
#pragma mark - 屏幕切换

-(void)automaticChangeOrientation
{
    if ([self isFull])
    {
        UIDevice *device = [UIDevice currentDevice];
        if (device.orientation == UIDeviceOrientationLandscapeLeft||device.orientation == UIDeviceOrientationLandscapeRight)
        {
            [UIView animateWithDuration:0.5 animations:^{
                _superView.transform = [self getOrientation:(UIInterfaceOrientation)device.orientation];
            }];
        }
    }
}

-(void)fullScreen
{
    if ([self isFull])
    {//半屏
         [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
        _superView.transform = CGAffineTransformMakeRotation(0);
        _superView.frame = _superFrame;
        _playerLayer.frame = _superView.bounds;
        [_menuViewLayer setHalfFrame];
        [_topViewLayer setHalfFrame];
        [self setFull:NO];
    }else//全屏
    {
        UIDevice *device = [UIDevice currentDevice];
        if (device.orientation == UIDeviceOrientationLandscapeLeft||device.orientation == UIDeviceOrientationLandscapeRight)
        {
            _superView.transform = [self getOrientation:(UIInterfaceOrientation)device.orientation];
            
        }else
        {
            _superView.transform = [self getOrientation:UIInterfaceOrientationLandscapeRight];
        }
        _superView.frame = _fullView.bounds;
        _playerLayer.frame = _superView.bounds;
        [_menuViewLayer setFullFrame];
        [_topViewLayer setFullFrame];
        [self setFull:YES];
    }
}
         
-(CGAffineTransform)getOrientation:(UIInterfaceOrientation)orientation{
             
             if (orientation == UIInterfaceOrientationPortrait) {
                 _currentOrientation = UIInterfaceOrientationPortrait;
                 [self toPortraitUpdate];
                 return CGAffineTransformIdentity;
             } else if (orientation == UIInterfaceOrientationLandscapeLeft){
                 _currentOrientation = UIInterfaceOrientationLandscapeLeft;
                 [self toPortraitUpdate];
                 return CGAffineTransformMakeRotation(-M_PI_2);
             } else if (orientation == UIInterfaceOrientationLandscapeRight){
                 _currentOrientation = UIInterfaceOrientationLandscapeRight;
                 [self toPortraitUpdate];
                 return CGAffineTransformMakeRotation(M_PI_2);
             } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
                 _currentOrientation = UIInterfaceOrientationPortraitUpsideDown;
                 [self toPortraitUpdate];
                 return CGAffineTransformMakeRotation(M_PI);
             }
             return CGAffineTransformIdentity;
}
-(void)toPortraitUpdate
{
    [[UIApplication sharedApplication] setStatusBarOrientation:_currentOrientation animated:YES];
}
#pragma mark - 懒加载
-(AVPlayer *)player
{
    if (!_player)
    {
        NSURL *URL =[NSURL URLWithString:[_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        AVPlayerItem *playItme = [[AVPlayerItem alloc] initWithURL:URL];
        _playItme = playItme;
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:_playItme];
        _player = player;
        AVPlayerLayer *playerLayer =[AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer = playerLayer;
        playerLayer.frame = _superView.layer.bounds;
        [_superView.layer addSublayer:playerLayer];
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self addObserverAndNSNotification];
//        _playItme addp 
    }
    return _player;
}
#pragma mark - 通知
-(void)addObserverAndNSNotification
{
    [_playItme addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [_playItme addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [_playItme addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [_playItme addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeBackground) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeForground) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playEndTime:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
}

-(void)playEndTime:(NSNotification *)info
{
    
}

-(void)appDidBecomeBackground
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self stop];
    });
}
-(void)appDidBecomeForground
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self start];
    });
}

#pragma mark - 视频监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        if ([self.playItme status] == AVPlayerItemStatusReadyToPlay) {
//            _loadingView.hidden = YES;
//            _slider.enabled = YES;
//            _isSlide = YES;
            
        }else if ([self.playItme status] == AVPlayerStatusFailed || [self.playItme status] == AVPlayerStatusUnknown)
        {
            NSLog(@"没网了");
        }
        
    }else if([keyPath isEqualToString:@"loadedTimeRanges"])
    {
        NSArray *loadedTimeRanges = [[self.player currentItem] loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
        NSLog(@"buffer = %f",result);
        
        NSLog(@"startSeconds == %f",startSeconds);
//        if ([_slide isEqualToString:@"YES"])
//        {
//            NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
//            [self coutBufferRateWithTimeInterval:timeInterval];
//            
//            _loadingView.hidden = NO;
//            if ([_loadingView.textL.text integerValue]>=100){ // 缓存 大于 播放 当前时长+3
//                _isSlide = NO;
//                _slide = @"NO";
//                self.loadingView.hidden = YES;
//                [self playerStart];
//            }
//        }else
//        {
//            [self bufferCompletePlayerStart];
//        }
        
    }else if([keyPath isEqualToString:@"playbackBufferEmpty"])//缓冲为0
    {
//        if (self.player.rate ==0)
//        {
//            self.loadingView.hidden = NO;
//        }
//        [self removeProgressTimer];
    }else if([keyPath isEqualToString:@"playbackLikelyToKeepUp"])//有缓冲
    {
//        if (![_slide isEqualToString:@"YES"])
//        {
//            [self bufferCompletePlayerStart];
//        }
//        NSLog(@"开始播放");
    }
}


#pragma mark - 播放器操作
-(void)start
{
    [self.player play];
    [self setMenuViewLayer];
    [self addProgressTimer];
}
-(void)stop
{
    [self.player pause];
}
#pragma mark - 进度条更新 定时器
- (void)addProgressTimer
{
    if (!_progressTimer) {
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_progressTimer forMode:NSRunLoopCommonModes];
    }
}
- (void)removeProgressTimer
{
    if (_progressTimer)
    {
        [_progressTimer invalidate];
        _progressTimer = nil;
    }
}
- (void)updateProgressInfo
{
    [self setTimeLableText];
    _menuViewLayer.slider.value = CMTimeGetSeconds(self.player.currentTime) / CMTimeGetSeconds(self.player.currentItem.duration);
}

-(void)setTimeLableText
{
    MyControl *control =[[MyControl alloc] init];
    _menuViewLayer.currentTime.text = [control timeStringWitherPlayer:_player][@"currentString"];
    _menuViewLayer.timeLenth.text = [control timeStringWitherPlayer:_player][@"durationString"];
}
#pragma mark - slider 快进快退
-(void)sliderTouchUpInside:(UISlider *)slider
{
    [self stop];
    NSTimeInterval currentTime = CMTimeGetSeconds(self.player.currentItem.duration) * slider.value;
    CGFloat duration = CMTimeGetSeconds(self.player.currentItem.duration)-1;
    if (currentTime >= duration)
    {
        [self.player seekToTime:CMTimeMakeWithSeconds(duration, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }else
    {
        [self.player seekToTime:CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
    }
    [self start];
}

-(void)slideVideoProgress:(UISlider *)slider
{
    [self removeProgressTimer];
    
    MyControl *control =[[MyControl alloc] init];
    NSTimeInterval duration = CMTimeGetSeconds(self.player.currentItem.duration);
    NSTimeInterval currentTime = duration*slider.value;
//    [self setTimeLableText];
    
    NSDictionary *time = [control stringWithCurrentTime:currentTime duration:duration];
    _menuViewLayer.currentTime.text = time[@"currentString"];
    _menuViewLayer.timeLenth.text = time[@"durationString"];
}

@end
