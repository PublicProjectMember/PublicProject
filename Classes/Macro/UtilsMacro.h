//
//  UtilsMacro.h
//
//  Created by 家伟 李 on 15/5/18.
//

#ifndef PuplicProject_UtilsMacro_h
#define PuplicProject_UtilsMacro_h


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define NSLog(...)
#   define DLog(...)
#endif

#endif
