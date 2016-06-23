//
//  ZJCustomScrollView.h
//  ZJPictureBrowseDemo
//
//  Created by ZJ on 16/4/14.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJCustomScrollViewDelegate <NSObject>

- (void)customScrollViewTappedWithObject:(id) sender;

@end

@interface ZJCustomScrollView : UIScrollView
@property (weak,nonatomic) id<ZJCustomScrollViewDelegate> i_delegate;
@property (nonatomic,strong)UIImage *image;
-(void)setImageViewFrame:(CGRect)rect;
-(void)beginRectAnimation;
-(void)changeOriginRect;
@end
