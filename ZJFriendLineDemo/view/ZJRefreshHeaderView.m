//
//  ZJRefreshHeaderView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ZJRefreshHeaderView.h"

@implementation ZJRefreshHeaderView
{
    CABasicAnimation *_rotateAnimation;
    UIImageView *_imageView;
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
        self.bounds = _imageView.bounds;
        self.center = CGPointMake(40, 40);
        
        [self addSubview:_imageView];
        [self bringSubviewToFront:_imageView];
        _rotateAnimation = [[CABasicAnimation alloc] init];
        _rotateAnimation.keyPath = @"transform.rotation.z";
        _rotateAnimation.fromValue = @0;
        _rotateAnimation.toValue = @(M_PI * 2);
        _rotateAnimation.duration = 1.0;
        _rotateAnimation.repeatCount = MAXFLOAT;
    }
    
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    // 子类实现
    if(keyPath != ZJBaseRefreshViewObserveKeyPath) return;
    float offsetY = self.scrollView.contentOffset.y;
    //NSLog(@"%f",offsetY);
    
    if(offsetY>-60)
    {
        if(self.scrollView.isDragging && self.refreshState != ZJRefreshStatePulling)
        {
            self.refreshState = ZJRefreshStatePulling;
            
        }
    }
    else
    {
        if(!self.scrollView.isDragging && self.refreshState == ZJRefreshStatePulling)
        {
            self.refreshState = ZJRefreshStateRefreshing;
            
        }
    }
    CGFloat rotateValue = offsetY / 50.0 * M_PI;
    CGAffineTransform transform = CGAffineTransformIdentity;
    if(self.refreshState == ZJRefreshStateRefreshing)
    {
       transform = CGAffineTransformTranslate(transform, 0, offsetY+60);
    }
    else
    {
        if(offsetY<-60)
        {
            transform = CGAffineTransformTranslate(transform, 0, offsetY+60);
        }
    }
    transform = CGAffineTransformRotate(transform, rotateValue);
    _imageView.transform = transform;


}
-(void)setRefreshState:(ZJRefreshState)refreshState
{
    [super setRefreshState:refreshState];
    if(refreshState == ZJRefreshStateRefreshing)
    {
        if (self.callbackBlock)
        {
            self.callbackBlock();
        }
        [_imageView.layer addAnimation:_rotateAnimation forKey:@"ZJRefreshHeaderRotateAnimationKey"];
    }
    if(refreshState == ZJRefreshStateNormal)
    {
        [_imageView.layer removeAnimationForKey:@"ZJRefreshHeaderRotateAnimationKey"];
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.transform = CGAffineTransformIdentity;
        }];
        NSLog(@"%@ \n%@",NSStringFromClass(self.superview.class),NSStringFromClass(_imageView.superview.class));
        [self.superview bringSubviewToFront:self];
    }
}
@end
