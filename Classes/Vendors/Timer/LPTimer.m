//
//  LSTimerApp.m
//  timerBlock
//
//  Created by lipeng on 14-7-4.
//  Copyright (c) 2014年 com.hollance. All rights reserved.
//

#import "LPTimer.h"
#import "NSTimer+BLocks.h"
//#import "LSUtilsMacro.h"

#ifdef ENABLE_LSTimer_LOG
#define LSTimerLog(fmt, ...) NSLog((@"%s [Line %d] %@ " fmt), __PRETTY_FUNCTION__, __LINE__,self, ##__VA_ARGS__)
#else
#define LSTimerLog(fmt, ...)
#endif
/*
 使用timer的类，需要实现startTimer，doTimer，stopTimer方法
 注意不可以直接在block中加入访问当前LSTimerApp的成员变量的代码，可以通过一层访问doTimer的间接方法。
 这样timer不会保留app。app保留timer。
 
 此是为了解决timer的循环引用问题。
 在LSTimeApp需要注意两个事项：
 1，启动timer要传递weak_self
 2，dealloc中需要调用timer的invalidate方法。
 */

@interface LPTimer ()
{
    NSTimer* _pollTimer;

    //timer selector
    __weak id _weak_target;
    SEL _selector;
    id  _userInfo;
}
@end

@implementation LPTimer

-(id)init
{
    if(self = [super init])
    {
    }
    return self;
}

- (id)userInfo
{
    return _userInfo;
}
- (NSTimeInterval)timeInterval
{
    return _pollTimer.timeInterval;
}

-(void)scheduleTimerWithTimerInternal:(NSTimeInterval)interval
                                 target:(id)target
                               selector:(SEL)aSelector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats
{
    __weak id weak_self = self;

    _weak_target = target;
    _selector = aSelector;
    _userInfo = userInfo;

    //借用第一个版本的block思想
    //使用了第二层间接，调用_weak_target的aSelector方法。
    //这样可以把stopTimer给封装进去，外部不需要管理timer的stop。
    _pollTimer = [NSTimer lsScheduleTimerWithTimerInternal:interval block:^{
        [weak_self doTimer];
    } repeats:repeats];
}
-(void)doTimer
{
    if ([_weak_target respondsToSelector:_selector]) {
        [_weak_target performSelector:_selector withObject:self];
    }
    else{
//        DLog(@"WARNNING: unknown selector");
    }
}
+ (LPTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo
{
    LPTimer* timer = [[LPTimer alloc]init];
    [timer scheduleTimerWithTimerInternal:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    return timer;
}
-(void)stopTimer
{
//    DLog(@"(%@)", self);
    [_pollTimer invalidate];
}
-(void)dealloc
{
    [self stopTimer];
}
@end
