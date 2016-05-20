//
//  PathMacro.h
//  
//
//  Created by 家伟 李 on 14-5-5.
//


#import <UIKit/UIKit.h>
#ifndef PuplicProject_PathMacro_h
#define PuplicProject_PathMacro_h

#define PATH_AT_DOCDIR(name)        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
#define PATH_AT_TMPDIR(name)        [NSTemporaryDirectory() stringByAppendingPathComponent:name]
#define PATH_AT_CACHEDIR(name)		[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name]
#endif
