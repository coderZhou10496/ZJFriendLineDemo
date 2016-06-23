//
//  CommentModel.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/21.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *replyUserName;
@property (nonatomic,copy)NSString *content;
@end
