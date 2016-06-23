//
//  ContainView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/5/4.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ContainView.h"
@interface ContainView()
@property (nonatomic,strong)NSMutableArray *cusImageViewArray;
@property (nonatomic,strong)UIImageView *imageView;
@end
@implementation ContainView

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}
-(void)setModel:(FriendLineCellModel *)model
{
    _model = model;
    self.cusImageViewArray = [NSMutableArray array];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if(model.picNameArray.count > 0)
    {
        float heightAndWidth = (ScreenWidth - 80 - 10)/3;
        [model.picNameArray enumerateObjectsUsingBlock:^(NSString *  imageName, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.userInteractionEnabled = YES;
            imageView.frame = CGRectMake((idx%3) * (heightAndWidth+5), (idx/3)* (heightAndWidth+5), heightAndWidth, heightAndWidth);
            imageView.image = [UIImage imageNamed:imageName];
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
            [self.cusImageViewArray addObject:imageView];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            [imageView addGestureRecognizer:tap];
        }];
    }

}
-(void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *view = (UIImageView *)tap.view;
    if([_delegate respondsToSelector:@selector(didClickImageViewWithCurrentImageView:imageViewArray:imageSuperView:)])
    {
        [_delegate didClickImageViewWithCurrentImageView:view imageViewArray:self.cusImageViewArray imageSuperView:self];
    }
}
@end
