//
//艺考在线APP	[项目名称]
//
//Created by 刘野 on 2016/5/25
//Copyright 2016  北京育艺之星科技有限公司. All rights reserved.
//
//系统名称:封装
//功能描述:控件初始化的封装
//

#import "MyControl.h"
//#import "MJExtension.h"
@implementation MyControl
- (NSDictionary *)timeStringWitherPlayer:(AVPlayer *)player
{
    
    NSTimeInterval duration = CMTimeGetSeconds(player.currentItem.duration);
    NSTimeInterval currentTime = CMTimeGetSeconds(player.currentTime);
    NSDictionary *time = [self stringWithCurrentTime:currentTime duration:duration];
    //字条串是否包含有某字符串
//    if ([time rangeOfString:@"-"].location == NSNotFound)
//    {
        return time;
//
////    } else {
////        
////        return @"00:00";
////    }
}

- (NSDictionary *)stringWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration
{
    
    NSInteger dMin = duration / 60;
    NSInteger dSec = (NSInteger)duration % 60;
    
    NSInteger cMin = currentTime / 60;
    NSInteger cSec = (NSInteger)currentTime % 60;
    
    NSString *durationString = [NSString stringWithFormat:@"%02ld:%02ld", (long)dMin, (long)dSec];
    NSString *currentString = [NSString stringWithFormat:@"%02ld:%02ld", (long)cMin, (long)cSec];
    
    return @{@"currentString":currentString,@"durationString":durationString};
}
@end





