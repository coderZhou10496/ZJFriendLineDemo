//
//  CommentCell.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@interface CommentCell : UITableViewCell
- (void)configCellWithModel:(CommentModel *)model;
@end
