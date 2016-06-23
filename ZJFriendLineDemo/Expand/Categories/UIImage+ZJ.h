//
//  UIImage+ZJ.h
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZJ)

/**
 *  拉伸图片 自定义比例
 */
+(UIImage *)resizeWithImageName:(NSString *)name leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

/**
 *返回中心拉伸的图片
 */
+(UIImage *)resizeWithImageName:(NSString *)name;

/**
 *  从给定UIView中截图：UIView转UIImage
 */
+(UIImage *)cutFromView:(UIView *)view;

/**
 *  从给定UIImage和指定Frame截图：
 */
-(UIImage *)cutWithFrame:(CGRect)frame;
@end
