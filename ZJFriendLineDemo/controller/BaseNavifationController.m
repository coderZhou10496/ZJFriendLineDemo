//
//  BaseNavifationController.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/7.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "BaseNavifationController.h"

@implementation BaseNavifationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //导航条字体颜色,字体大小
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil]];
    //导航条背景色
    self.navigationBar.barTintColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:1];
    self.navigationBar.tintColor = [UIColor whiteColor];
}
@end
