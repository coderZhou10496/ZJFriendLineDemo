//
//  FriendLineCell.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/13.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FriendLineCell.h"
#import "FriendLineCellModel.h"
#import "ContainView.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "OperationView.h"
#import "CommentView.h"
@interface FriendLineCell ()<ContainViewDelegate,CommentViewDelegate>
@property (nonatomic,strong)UIImageView *headImageView;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *msgLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic,strong)ContainView *imageViewContainView;//图片所在的view
@property (nonatomic,strong)UIButton *operationBtn;

@property (nonatomic,strong)UILabel *praiseLabel;//赞 label
@property (nonatomic,strong)CommentView *commentView; // 评论view
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic,strong)FriendLineCellModel *model;
@end


NSString *const ZJFriendLineCellOperationButtonClickedNotification = @"ZJFriendLineCellOperationButtonClickedNotification";


@implementation FriendLineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setup
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:ZJFriendLineCellOperationButtonClickedNotification object:nil];
    
    UIImageView *headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:headImageView];
    self.headImageView = headImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *msgLabel = [[UILabel alloc] init];
   // msgLabel.backgroundColor = [UIColor blueColor];
    msgLabel.font = [UIFont systemFontOfSize:15];
    msgLabel.numberOfLines = 0;
    [self.contentView addSubview:msgLabel];
    self.msgLabel = msgLabel;
    
    UIButton *moreBtn = [[UIButton alloc] init];
    [moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [moreBtn setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    moreBtn.selected = NO;
    [moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:moreBtn];
    self.moreBtn = moreBtn;
    ContainView *containView = [[ContainView alloc] init];
    containView.delegate = self;
  //  containView.backgroundColor = [UIColor cyanColor];
    [self.contentView addSubview:containView];
    self.imageViewContainView = containView;
    
    UIButton *operationBtn = [UIButton new];
    [operationBtn setBackgroundImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [operationBtn addTarget:self action:@selector(operationBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:operationBtn];
    self.operationBtn = operationBtn;
    
    OperationView *opView = [[OperationView alloc] init];
     __weak typeof(opView) weakOpView = opView;
    __weak typeof(self) weakSelf = self;
    [opView setLikeBtnClicked:^{
        weakOpView.isShowing = NO;
       if([weakSelf.delegate respondsToSelector:@selector(didClickenLikeBtnWithIndexPath:)])
       {
           [weakSelf.delegate didClickenLikeBtnWithIndexPath:weakSelf.indexPath];
       }
    }];
    [opView setCommentBtnClicked:^{
        weakOpView.isShowing = NO;
        if([weakSelf.delegate respondsToSelector:@selector(didClickCommentBtnWithIndexPath:)])
        {
            [weakSelf.delegate didClickCommentBtnWithIndexPath:weakSelf.indexPath];
        }
    }];
    [self.contentView addSubview:opView];
    self.operationView = opView;
    
    CommentView *comView = [[CommentView alloc] init];
    comView.delegate = self;
    comView.backgroundColor = SHOWCOLOR(240, 240, 240);
    [self.contentView addSubview:comView];
    self.commentView = comView;
    
    //头像图片
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
        make.right.equalTo(nameLabel.mas_left).with.offset(-10);
    }];
    //名字
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.left.equalTo(headImageView.mas_right).with.offset(10);
        
        make.size.mas_equalTo(CGSizeMake(150, 30));
        make.bottom.equalTo(msgLabel.mas_top).with.offset(-5);
    }];
    //文字信息
    [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(5);
        make.left.mas_equalTo(nameLabel);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
    }];
    msgLabel.preferredMaxLayoutWidth = ScreenWidth-80;
    //更多按钮
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(msgLabel.mas_bottom).offset(0);
        make.left.mas_equalTo(msgLabel);
    }];

    //图片
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moreBtn.mas_bottom).with.offset(10);
        make.left.mas_equalTo(moreBtn);
    }];
    
    [operationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViewContainView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.msgLabel);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    //喜欢和评论按钮
    [opView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageViewContainView.mas_bottom).offset(5);
        make.right.mas_equalTo(self.operationBtn.mas_left).offset(-3);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(32);
    }];
    
    //赞 评论的View
    [comView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.operationView.mas_bottom).offset(5);
        make.left.right.mas_equalTo(self.msgLabel);
        
    }];
    self.hyb_lastViewInCell = comView;
    self.hyb_bottomOffsetToCell = 10;
    
}
- (void)configCellWithModel:(FriendLineCellModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.model = model;
    self.indexPath = indexPath;
    self.headImageView.image = [UIImage imageNamed:model.headImgName];
    self.nameLabel.text = model.usernName;
    self.msgLabel.text = model.msgContent;
    // self.imageViewContainView.model = model;
    float msgHeight = [NSString stringHeightWithString:model.msgContent size:15 maxWidth: ScreenWidth-80];
    if(msgHeight <=60)
    {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msgLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.msgLabel);
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
    else
    {
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.msgLabel.mas_bottom).offset(0);
            make.left.mas_equalTo(self.msgLabel);
        }];
    }
    if(model.isExpand)
    {
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(msgHeight);
        }];
    }
    else
    {
        [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).with.offset(5);
            make.left.mas_equalTo(self.nameLabel);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.height.mas_lessThanOrEqualTo(60);
        }];
    }
    self.moreBtn.selected = model.isExpand;
    CGSize imageContainViewSize;
    if(model.picNameArray.count==0)
    {
        imageContainViewSize = CGSizeMake(0, 0);
    }
    else if (model.picNameArray.count>0 && model.picNameArray.count<4)
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80, (ScreenWidth-80-10)/3);
    }
    else
    {
        imageContainViewSize = CGSizeMake(ScreenWidth-80,(2*(ScreenWidth-90)/3)+5);
    }
    [self.imageViewContainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreBtn.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.moreBtn);
        make.size.mas_equalTo(imageContainViewSize);
    }];
    self.imageViewContainView.model = model;
    [self.commentView configCellWithModel:model indexPath:indexPath];
}

-(void)moreAction:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(didClickedMoreBtn:indexPath:)])
    {
        [_delegate didClickedMoreBtn:sender indexPath:self.indexPath];
    }
}
-(void)didClickImageViewWithCurrentImageView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)superView
{
    if([_delegate respondsToSelector:@selector(didClickImageViewWithCurrentView:imageViewArray:imageSuperView:indexPath:)])
    {
        [_delegate didClickImageViewWithCurrentView:imageView imageViewArray:array imageSuperView:superView indexPath:self.indexPath];
    }
}
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)])
    {
        [_delegate didClickRowWithFirstIndexPath:firIndexPath secondIndex:secIndexPath];
    }
}
-(void)operationBtnClick
{

    if(self.model.isLiked)
    {
        self.operationView.praiseString = @"取消赞";
    }
    else
    {
        self.operationView.praiseString = @"赞";
    }
    self.operationView.isShowing = !self.operationView.isShowing;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.operationView.isShowing = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZJFriendLineCellOperationButtonClickedNotification object:self.operationBtn];
}
- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{
    UIButton *btn = notification.object;
    if(btn != self.operationBtn && self.operationView.isShowing == YES)
    {
        self.operationView.isShowing = NO;
    }
}
-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
