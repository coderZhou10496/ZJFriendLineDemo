//
//  FriendLineCell.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/13.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FriendLineCellModel;
@class OperationView;
@protocol FriendLineCellDelegate <NSObject>

-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath;
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath;
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath;
@end

@interface FriendLineCell : UITableViewCell
@property (nonatomic,strong)OperationView *operationView;
@property (nonatomic,weak)id <FriendLineCellDelegate>delegate;

- (void)configCellWithModel:(FriendLineCellModel *)model indexPath:(NSIndexPath *)indexPath;
@end
