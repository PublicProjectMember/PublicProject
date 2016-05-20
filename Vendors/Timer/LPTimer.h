//
//  LSTimer.h
//  timerBlock
//
//  Created by lipeng on 14-7-4.
//  Copyright (c) 2014年 com.hollance. All rights reserved.
//

/*
 使用方法：可以直接将LSTimer定义为成员，不会保留当前界面
 */

#import <Foundation/Foundation.h>

typedef void(^TimerBlock) (void);

@interface LPTimer : NSObject

- (id)userInfo;
- (NSTimeInterval)timeInterval;


-(void)scheduleTimerWithTimerInternal:(NSTimeInterval)interval
                                 target:(id)target
                               selector:(SEL)aSelector
                               userInfo:(id)userInfo
                                repeats:(BOOL)repeats;

-(void)stopTimer;

+ (LPTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end
