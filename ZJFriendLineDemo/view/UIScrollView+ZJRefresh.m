//
//  UIScrollView+ZJRefresh.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "UIScrollView+ZJRefresh.h"
#import "ZJRefreshHeaderView.h"
#import <objc/runtime.h>
@interface UIScrollView()
@property (nonatomic,strong)ZJRefreshHeaderView *headerView;
@end

@implementation UIScrollView (ZJRefresh)

static char ZJRefreshHeaderViewKey;

- (void)setHeaderView:(ZJRefreshHeaderView *)headerView
{
    [self willChangeValueForKey:@"ZJRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &ZJRefreshHeaderViewKey,
                             headerView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ZJRefreshHeaderViewKey"];
}
- (ZJRefreshHeaderView *)headerView {
    return objc_getAssociatedObject(self, &ZJRefreshHeaderViewKey);
}
-(void)addRefreshHeaderViewWithCallback:(void(^)())callback
{

    if(!self.headerView)
    {
        ZJRefreshHeaderView *headerView = [[ZJRefreshHeaderView alloc] init];
        headerView.callbackBlock = callback;
        
        [self addSubview:headerView];
        [self bringSubviewToFront:headerView];
        self.headerView = headerView;
    }
}
-(void)headerEndRefreshing
{
    
    self.headerView.refreshState = ZJRefreshStateNormal;
}
-(void)beginHeaderRefresh;
{
    self.headerView.refreshState = ZJRefreshStateRefreshing;
}
@end
