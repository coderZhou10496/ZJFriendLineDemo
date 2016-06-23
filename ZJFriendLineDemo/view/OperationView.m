//
//  OperationView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "OperationView.h"

@implementation OperationView
{
    UIButton *_likeButton;
    UIButton *_commentButton;
}
-(id)init
{
    if(self = [super init])
    {
        self.clipsToBounds = YES;//AlbumLike   AlbumComment
        self.layer.cornerRadius = 5;
        self.backgroundColor = SHOWCOLOR(69, 74, 76);
        _likeButton = [self creatButtonWithTitle:@"赞" image:[UIImage imageNamed:@"AlbumLike"] selImage:nil target:self selector:@selector(likeButtonClicked)];
        [self addSubview:_likeButton];
        _commentButton = [self creatButtonWithTitle:@"评论" image:[UIImage imageNamed:@"AlbumComment"] selImage:nil target:self selector:@selector(commentButtonClicked)];
        [self addSubview:_commentButton];
        UIView *centerLine = [UIView new];
        centerLine.backgroundColor = [UIColor grayColor];
        [self addSubview:centerLine];
        
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(self).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(80);
        }];
        [centerLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(5);
            make.left.mas_equalTo(_likeButton.mas_right).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(1);
        }];
        [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(0);
            make.left.mas_equalTo(centerLine.mas_right).offset(5);
            make.bottom.mas_equalTo(self).offset(0);
            make.width.mas_equalTo(80);
        }];
        
    }
    return self;
}
- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0);
    return btn;
}
-(void)setPraiseString:(NSString *)praiseString
{
    _praiseString = praiseString;
    [_likeButton setTitle:praiseString forState:UIControlStateNormal];
}
- (void)likeButtonClicked
{
    if(self.likeBtnClicked)
    {
        self.likeBtnClicked();
    }

}
- (void)commentButtonClicked
{
    if(self.commentBtnClicked)
    {
        self.commentBtnClicked();
    }
}
-(void)setIsShowing:(BOOL)isShowing
{
    _isShowing = isShowing;
    if(isShowing)
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(180);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
    else
    {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self.superview layoutIfNeeded];
        }];
    }
}
@end
