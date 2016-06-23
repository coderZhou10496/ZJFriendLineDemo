//
//  FriendLineCellModel.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/13.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendLineCellModel : NSObject
@property (nonatomic,copy)NSString *usernName;
@property (nonatomic,copy)NSString *headImgName;
@property (nonatomic,copy)NSString *msgContent;
@property (nonatomic,strong)NSArray *picNameArray;

@property (nonatomic,strong)NSArray *likeNameArray;
@property (nonatomic,strong)NSArray *commentArray;

@property (nonatomic,assign)BOOL isLiked;
///发布说说的展开状态
@property (nonatomic, assign) BOOL isExpand;
@end
