//
//  NSTimer+LSAdditions.h
//  timerBlock
//
//  Created by lipeng on 14-7-4.
//  Copyright (c) 2014年 com.hollance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(BLocks)

+(NSTimer*) lsScheduleTimerWithTimerInternal:(NSTimeInterval)interval
                                       block:(void(^)())block
                                     repeats:(BOOL)repeats;
@end
