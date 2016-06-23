//
//  CommentView.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@class FriendLineCellModel;

@protocol CommentViewDelegate <NSObject>

-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;

@end

@interface CommentView : UIView
-(id)init;
- (void)configCellWithModel:(FriendLineCellModel *)model indexPath:(NSIndexPath *)indexPath;

@property (nonatomic,weak) id <CommentViewDelegate>delegate;

@end
