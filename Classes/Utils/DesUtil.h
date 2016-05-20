//
//  DesUtil.h
//  LaShouGroup
//
//  Created by 家伟 李 on 14-6-4.
//  Copyright (c) 2014年 LASHOU-INC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h> 

@interface DesUtil : NSObject


/**DES加密*/
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
/**DES解密*/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;

/**DES加密*/
+(NSData *) encryptUseDESWithData:(NSData *)textData key:(NSString *)key;
/**DES解密*/
+(NSData *) decryptUseDESWithData:(NSData *)hexData key:(NSString *)key;

@end
