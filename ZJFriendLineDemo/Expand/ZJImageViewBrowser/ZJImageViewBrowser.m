//
//  ZJImageViewBrowser.m
//  ZJPictureBrowseDemo
//
//  Created by ZJ on 16/4/14.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "ZJImageViewBrowser.h"
#import "ZJCustomScrollView.h"
@interface ZJImageViewBrowser ()<UIScrollViewDelegate,ZJCustomScrollViewDelegate>
@property (nonatomic,strong)NSArray *imageViewArray;
@property (nonatomic,strong)NSMutableArray *customScrollArray;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIView *imageViewContainView;
@property (nonatomic,assign)int currentIndex;
@property (nonatomic,strong)UIView *blackView;
@end

@implementation ZJImageViewBrowser
-(id)initWithFrame:(CGRect)frame imageViewArray:(NSArray *)array imageViewContainView:(UIView *)containView
{
    if([super initWithFrame:frame])
    {
        if(!array || array.count == 0)
        {
            NSLog(@"ZJImageViewBrowser:图片数组不能为空！！");
        }
        self.imageViewArray = [NSArray arrayWithArray:array];
        self.imageViewContainView = containView;
        self.customScrollArray = [NSMutableArray array];
        [self setUp];
    }
    return self;
}
-(void)show
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
    [self.customScrollArray enumerateObjectsUsingBlock:^(ZJCustomScrollView *customScrollView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [UIView animateWithDuration:0.4 animations:^{
            [customScrollView beginRectAnimation];
            self.blackView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
    }];
}
-(void)setUp
{
    UIView *blackView = [[UIView alloc] initWithFrame:self.bounds];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0;
    [self addSubview:blackView];
    self.blackView = blackView;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.alpha = 1;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL * _Nonnull stop) {
       
        ZJCustomScrollView *customScrollView  = [[ZJCustomScrollView alloc] initWithFrame:CGRectMake(idx * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        customScrollView.image = imageView.image;
        customScrollView.i_delegate = self;
        
        CGRect rect = [self.imageViewContainView convertRect:imageView.frame toView:self];
        [customScrollView setImageViewFrame:rect];
        
        [scrollView addSubview:customScrollView];
        [self.customScrollArray addObject:customScrollView];
    }];
    scrollView.contentSize = CGSizeMake(self.bounds.size.width * self.imageViewArray.count, self.bounds.size.height);
    self.scrollView = scrollView;
}
-(void)setSelectedImageView:(UIImageView *)selectedImageView
{
    _selectedImageView = selectedImageView;
    self.currentIndex = (int)[self.imageViewArray indexOfObject:selectedImageView];
    self.scrollView.contentOffset = CGPointMake(self.bounds.size.width*self.currentIndex, 0);
}
- (void)customScrollViewTappedWithObject:(id) sender
{
    ZJCustomScrollView *customScrollView = sender;
    [UIView animateWithDuration:0.4 animations:^{
        [customScrollView changeOriginRect];
        self.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
@end
