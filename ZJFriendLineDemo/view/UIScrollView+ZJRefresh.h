//
//  UIScrollView+ZJRefresh.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZJRefresh)
-(void)addRefreshHeaderViewWithCallback:(void(^)())callback;
-(void)beginHeaderRefresh;
-(void)headerEndRefreshing;

@end
