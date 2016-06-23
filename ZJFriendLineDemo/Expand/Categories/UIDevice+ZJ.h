//
//  UIDevice+ZJ.h
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (ZJ)
/**
 获取当前Version号
 */
+(NSString *)currentVersion;

/**
获取当前build号
*/
+(NSString *)currentBuild;

/*!
 系统版本
 */
+(CGFloat)systemVersion;

//屏幕宽高

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

//ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f

#define iphone4 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)
@end
