//
//  ContainView.h
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/5/4.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendLineCellModel.h"

@protocol ContainViewDelegate <NSObject>

-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView;

@end

@interface ContainView : UIView
@property (nonatomic,strong)FriendLineCellModel *model;
@property (nonatomic,weak)id <ContainViewDelegate>delegate;
@end
