//
//  SystemMacro.h
//  TCGroupLeader
//
//  Created by user on 15/5/11.
//  Copyright (c) 2015年 lcg. All rights reserved.
//

#ifndef PuplicProject_SystemMacro_h
#define PuplicProject_SystemMacro_h

#pragma mark 系统版本判断
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define iOS7System (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES:NO)
#define CURRENTSYSTEM  [[[UIDevice currentDevice] systemVersion] floatValue]

/** 获取APP的版本号 */
#define kSoftwareVersion    ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])
/** 获取app内部的版本号 */
#define kBuildwareVersion    ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"])
/**获取app的名称**/
#define kBundleDisplayName   ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"])
/**获取NSBundele中的资源图片**/
#define IMAGE_AT_APPDIR(name)       [Helper imageAtApplicationDirectoryWithName:name]

#endif
