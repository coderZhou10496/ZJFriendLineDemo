//
//  UIView+ZJ.m
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "UIView+ZJ.h"

@implementation UIView (ZJ)
- (CGFloat)sd_height
{
    return self.frame.size.height;
}

- (void)setSd_height:(CGFloat)sd_height
{
    CGRect temp = self.frame;
    temp.size.height = sd_height;
    self.frame = temp;
}

- (CGFloat)sd_width
{
    return self.frame.size.width;
}
- (void)setSd_width:(CGFloat)sd_width
{
    CGRect temp = self.frame;
    temp.size.width = sd_width;
    self.frame = temp;
}
- (CGFloat)sd_y
{
    return self.frame.origin.y;
}

- (void)setSd_y:(CGFloat)sd_y
{
    CGRect temp = self.frame;
    temp.origin.y = sd_y;
    self.frame = temp;
}

- (CGFloat)sd_x
{
    return self.frame.origin.x;
}

- (void)setSd_x:(CGFloat)sd_x
{
    CGRect temp = self.frame;
    temp.origin.x = sd_x;
    self.frame = temp;
}
@end
