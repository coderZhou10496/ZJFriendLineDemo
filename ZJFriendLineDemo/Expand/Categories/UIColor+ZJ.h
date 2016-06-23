//
//  UIColor+ZJ.h
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZJ)
/**
 *  十六进制颜色
 */
+ (UIColor *)colorWithHexColorString:(NSString *)hexColorString;

/**
  随机得到一个颜色
 */
+(UIColor*)ZJRandomColor;

/** 普通定义 */
#define SHOWCOLOR(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@end
