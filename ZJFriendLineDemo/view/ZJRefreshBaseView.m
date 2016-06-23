//
//  ZJRefreshBaseView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ZJRefreshBaseView.h"

NSString *const ZJBaseRefreshViewObserveKeyPath = @"contentOffset";

@implementation ZJRefreshBaseView


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    [self.superview removeObserver:self forKeyPath:ZJBaseRefreshViewObserveKeyPath];
    [newSuperview addObserver:self forKeyPath:ZJBaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    _scrollView = (UIScrollView *)newSuperview;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 子类实现
    
}
@end
