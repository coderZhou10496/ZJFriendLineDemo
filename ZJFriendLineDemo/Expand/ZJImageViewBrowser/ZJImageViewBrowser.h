//
//  ZJImageViewBrowser.h
//  ZJPictureBrowseDemo
//
//  Created by ZJ on 16/4/14.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJImageViewBrowser : UIView
-(id)initWithFrame:(CGRect)frame imageViewArray:(NSArray *)array imageViewContainView:(UIView *)containView;
-(void)show;
@property (nonatomic,strong)UIImageView *selectedImageView;
@end
