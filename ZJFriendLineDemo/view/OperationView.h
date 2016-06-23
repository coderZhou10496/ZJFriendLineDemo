//
//  OperationView.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationView : UIView
@property (nonatomic,assign)BOOL isShowing;
@property (nonatomic,copy)void (^commentBtnClicked)();
@property (nonatomic,copy)void (^likeBtnClicked)();
@property (nonatomic,copy)NSString *praiseString;
@end
