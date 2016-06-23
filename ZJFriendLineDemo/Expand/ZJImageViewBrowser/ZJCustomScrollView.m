//
//  ZJCustomScrollView.m
//  ZJPictureBrowseDemo
//
//  Created by ZJ on 16/4/14.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ZJCustomScrollView.h"


@interface ZJCustomScrollView ()<UIScrollViewDelegate>
{
    UIImageView *_imageView;
    CGRect _originRect;//记录imageView在父视图刚开始的坐标
    CGRect _changedRect;//动画后的坐标
    CGSize _imageSize;//图片原大小
}
@end
@implementation ZJCustomScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.minimumZoomScale = 1.0;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.clipsToBounds = YES;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
    }
    return self;
}
-(void)setImage:(UIImage *)image
{
    _imageView.image = image;
    _imageSize = image.size;
    //判断首先缩放的值
    
    float scaleX = _imageSize.width/self.frame.size.width;
    float scaleY = _imageSize.height/self.frame.size.height;
    if(scaleX > scaleY)
    {
        //宽度比更大一些
        float imageViewHeight = image.size.height/scaleX;
        self.maximumZoomScale = self.frame.size.height/imageViewHeight;
        
        _changedRect = CGRectMake(0, (self.frame.size.height-imageViewHeight)/2, self.frame.size.width, imageViewHeight);
    }
    else
    {
        float imageViewWidth = image.size.width/scaleY;
        self.maximumZoomScale =self.frame.size.width/imageViewWidth;
        
        _changedRect = CGRectMake((self.frame.size.width-imageViewWidth)/2, 0, imageViewWidth, self.frame.size.height);
    }
   // NSLog(@"%f",self.maximumZoomScale);
}
-(void)setImageViewFrame:(CGRect)rect
{
    _imageView.frame = rect;
    _originRect = rect;
}
-(void)beginRectAnimation
{
    _imageView.frame = _changedRect;
    
}
-(void)changeOriginRect
{
    self.zoomScale = 1;
    _imageView.frame = _originRect;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([_i_delegate respondsToSelector:@selector(customScrollViewTappedWithObject:)])
    {
        [_i_delegate customScrollViewTappedWithObject:self];
    }
}
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        
        centerPoint.y = boundsSize.height/2;
    }
    
    _imageView.center = centerPoint;
}
@end
