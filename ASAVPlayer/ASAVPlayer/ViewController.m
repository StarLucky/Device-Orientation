//
//  ViewController.m
//  ASAVPlayer
//
//  Created by 韩智星 on 2017/3/30.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "ViewController.h"
#import "ASAVPlayer.h"
#import "ASPublicFile.h"
#import "AppDelegate.h"
@interface ViewController ()
@property (nonatomic,strong) ASAVPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width/1.78)];
    [self.view addSubview: view];
    NSString *playString = @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4";
    ASAVPlayer *player =[[ASAVPlayer alloc] initWithURL:playString SuperView:view Controller:self];
    [player start];
    _player = player;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    
//    UILabel *btn =[[UILabel alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
//    [self.view addSubview:btn];
//   
////    [btn setText:@"\U0000e609"];
////    [btn setIconfontSize:20];
//    btn.font = [UIFont fontWithName:@"iconfont" size:20];
//    [btn setBackgroundColor:[UIColor blueColor]];
//    btn.text = @"\U0000e609";
    
    
    CGFloat viewW =44 , viewH = viewW, viewX = ScreenW-viewW,viewY = 20;
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 200, 200)];
    shareBtn.titleLabel.font = [UIFont fontWithName:@"iconfont" size:17];
    [self.view addSubview:shareBtn];
    //    shareBtn.titleLabel.text = @"U0000e627";
    [shareBtn setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [shareBtn setBackgroundColor:[UIColor blueColor]];
    
}
-(void)OrientationChange
{
    [_player automaticChangeOrientation];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    CGFloat currentLight = [UIScreen mainScreen].brightness;
    NSLog(@"%f",currentLight);
    
//    NSLog(@"%@",_player.player);
//    NSLog(@"%@",_player.playItme);
//    
//    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_player.player)));
//        NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_player.playItme)));
    
    
//    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_aview)));
//    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_aview.playerLayer.playerItme)));
//    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_aview.playerLayer.avplayer)));
//    NSLog(@"%ld",CFGetRetainCount((__bridge CFTypeRef)(_aview.playerLayer)));
   
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    //    app.shouldChangeOrientation = YES;
    if (app.shouldChangeOrientation == YES) {
        return UIInterfaceOrientationMaskLandscape;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
