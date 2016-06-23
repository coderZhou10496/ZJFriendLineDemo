//
//  NSString+ZJ.m
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "NSString+ZJ.h"

@implementation NSString (ZJ)
-(BOOL)isEmptyString
{
    if (self == nil || self == NULL)
        return YES;
    if (self.length==0)
        return YES;
    if ([self isEqualToString:@""])
        return YES;
    if ([self isKindOfClass:[NSNull class]])
        return YES;
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
        return YES;
    if ([self isEqualToString:@"(null)"])
        return YES;
    if ([self isEqualToString:@"<null>"])
        return YES;
    return NO;
}
-(BOOL)isValidatePhoneNumber
{
    NSString * phoneRegex = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
-(BOOL)isOnlyNumberString
{
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet
                                             characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSRange foundRange = [self rangeOfCharacterFromSet:disallowedCharacters];
    if (foundRange.location != NSNotFound)
    {
        //不是纯数字
        return NO;
    }
    else
    {
        //是纯数字
        return YES;
    }
}
-(BOOL)isOnlyCharcterString
{
    NSString* number=@"^[A-Za-z]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return  [numberPre evaluateWithObject:self];
}
+(NSString *)getCurrentTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
/**
 根据文字多少计算高度
 */
+ (float)stringHeightWithString:(NSString *)string size:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth
{
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil];

    float height = [string boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    return ceilf(height);
}
@end
