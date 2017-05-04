//
//  ViewController.m
//  sizeToFit
//
//  Created by 韩智星 on 2017/4/27.
//  Copyright © 2017年 韩智星. All rights reserved.
//

#import "ViewController.h"
#import "AVFoundation/AVFoundation.h"
#import "AudioToolBox/AudioToolBox.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "AFNetworking.h"
#import "LYAnimation.h"
@interface ViewController ()
{
    AVAudioPlayer *_playMusic;//背景音乐
    SystemSoundID _sound;//音效
}
@property (nonatomic,copy) NSString *className;
@property (nonatomic,copy) NSString *classTitle;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    NSDictionary *parameters = @{@"foo": @"bar"};
//    [manager POST:@"http://appmcp.iartsee.com/api/public/pass.php?k=k329sdk30slelkds90234k&a=gp" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    self.view.backgroundColor = [UIColor purpleColor];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }
//}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
-(SystemSoundID)loadSound:(NSString *)soundFileNAme{
//    2)需要制定声音的文件路径，这个方法需要加载不同的音效
    NSString *path = [[NSBundle mainBundle]pathForResource:soundFileNAme ofType:nil];
//    3)将路径字符串转换为url
    NSURL *url = [NSURL fileURLWithPath:path];
//    4)初始化音效
//    (url - CFURLRef
//     SystemSoundID)
    SystemSoundID soundId;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url),&soundId);
    return soundId;
}
//3)调用音效效果
//_sound =[self loadSound:@“音乐.aiff"];
//         AudioServicesPlaySystemSound(_sound);

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    _sound =[self loadSound:@"水滴声.mp3"];
//    AudioServicesPlaySystemSound(_sound);
    [LYAnimation rippleShakeAnimation:self.view Subtype:kCATransitionFromLeft];
}

 - (NSArray *) allPropertyNames{
        ///存储所有的属性名称
      NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
         ///存储属性的个数
         unsigned int propertyCount = 0;
    
         ///通过运行时获取当前类的属性
         objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
       //把属性放到数组中
      for (int i = 0; i < propertyCount; i ++) {
              ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
        [self setValue:[NSString stringWithUTF8String:propertyName] forKey:[NSString stringWithUTF8String:propertyName]];
        }
        ///释放
         free(propertys);
     
        return allNames;
    }
@end
