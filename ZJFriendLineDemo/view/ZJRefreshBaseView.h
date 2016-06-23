//
//  ZJRefreshBaseView.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ZJBaseRefreshViewObserveKeyPath;

typedef NS_ENUM(NSInteger, ZJRefreshState) {
    ZJRefreshStatePulling,
    ZJRefreshStateNormal,
    ZJRefreshStateRefreshing
};
@interface ZJRefreshBaseView : UIView
@property (nonatomic,assign)ZJRefreshState refreshState;
@property (nonatomic,copy)void(^callbackBlock)();
@property (nonatomic, strong) UIScrollView *scrollView;
@end
