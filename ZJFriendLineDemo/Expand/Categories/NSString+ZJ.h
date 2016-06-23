//
//  NSString+ZJ.h
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZJ)
/**
 * 是否是空字符串
 */
-(BOOL)isEmptyString;

/**
 * 是否是有效的电话号码
 */
-(BOOL)isValidatePhoneNumber;

/**
 是否是有效的邮箱
 */
-(BOOL)isValidateEmail;

/**
 是否是纯数字字符串
 */
-(BOOL)isOnlyNumberString;

/**
 是否是纯字母字符串
 */
-(BOOL)isOnlyCharcterString;

/**
 得到当前时间的字符串
 */
+(NSString *)getCurrentTime;

/**
 根据文字多少计算高度
 */
+ (float)stringHeightWithString:(NSString *)string size:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth;
@end
