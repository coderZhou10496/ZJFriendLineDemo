//
//  MyCollectionViewCell.m
//  Mission
//
//  Created by 李阳 on 15/8/31.
//  Copyright (c) 2015年 WXDL. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell
-(UIImageView *)customImgView
{
    if(!_customImgView)
    {
        _customImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _customImgView.backgroundColor = [UIColor cyanColor];
        [self addSubview:_customImgView];
    }
    return _customImgView;
}
@end
