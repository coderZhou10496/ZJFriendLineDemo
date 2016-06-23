//
//  UIDevice+ZJ.m
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "UIDevice+ZJ.h"

@implementation UIDevice (ZJ)
+(NSString *)currentVersion
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

+(NSString *)currentBuild
{
     NSString *currentBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return currentBuild;
}
+(CGFloat)systemVersion
{
    CGFloat version = 0;
    UIDevice *currentDevice = [UIDevice currentDevice];
    version = currentDevice.systemVersion.floatValue;
    return version;
}
@end
