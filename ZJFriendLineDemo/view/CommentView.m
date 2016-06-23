//
//  CommentView.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/20.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "CommentView.h"
#import "CommentCell.h"
#import "FriendLineCellModel.h"
#import "CommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "MLLinkLabel.h"
@interface CommentView ()<UITableViewDelegate,UITableViewDataSource,MLLinkLabelDelegate>
@property (nonatomic,strong)NSMutableArray *likeArray;
@property (nonatomic,strong)NSMutableArray *commentDataArray;
@property (nonatomic,strong)UIImageView *bigImageView;
@property (nonatomic,strong)MLLinkLabel *praiseLabel;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation CommentView

-(id)init
{
    if(self = [super init])
    {
//        self.commentDataArray = @[].mutableCopy;
//        self.likeArray = @[].mutableCopy;
//        UIImageView *bigImageView = [[UIImageView alloc] init];
//        UIImage *bgImage = [[[UIImage imageNamed:@"LikeCmtBg"] stretchableImageWithLeftCapWidth:40 topCapHeight:30] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        bigImageView.image = bgImage;
//        [self addSubview:bigImageView];
//        self.bigImageView = bigImageView;
        
        MLLinkLabel *praiseLabel = [MLLinkLabel new];
        praiseLabel.delegate = self;
        praiseLabel.linkTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:92/255.0 green:140/255.0 blue:255/255.0 alpha:1.0]};
        praiseLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
        praiseLabel.numberOfLines = 0;
        praiseLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:praiseLabel];
        self.praiseLabel = praiseLabel;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1.0];
        [self addSubview:lineView];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.scrollEnabled = NO;

        [self addSubview:tableView];
        self.tableView = tableView;
//        [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
        
        self.praiseLabel.preferredMaxLayoutWidth = ScreenWidth-80;;
        [praiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.top.mas_equalTo(self).offset(5);
            make.left.right.mas_equalTo(self).offset(0);
            make.bottom.mas_equalTo(lineView.mas_top).offset(-5);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.praiseLabel.mas_bottom).offset(5);
            make.left.right.mas_equalTo(self).offset(0);
            make.height.mas_equalTo(1);
        }];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).offset(5);
            make.left.bottom.right.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=  [CommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        CommentCell *cell = (CommentCell *)sourceCell;
        [cell configCellWithModel:self.commentDataArray[indexPath.row]];
    } ];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    if(cell==nil)
    {
        cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CommentCell"];
      //  cell.delegate = self;
    }
    cell.backgroundColor = SHOWCOLOR(240, 240, 240);;
    [cell configCellWithModel:self.commentDataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([_delegate respondsToSelector:@selector(didClickRowWithFirstIndexPath:secondIndex:)])
    {
        [_delegate didClickRowWithFirstIndexPath:self.indexPath secondIndex:indexPath];
    }
}
- (void)configCellWithModel:(FriendLineCellModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.commentDataArray = [NSMutableArray arrayWithArray:model.commentArray];
    self.likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    self.indexPath = indexPath;
    [self setPraiseLabelTextWithLikeArray:model.likeNameArray];
    [self.tableView reloadData];
    float height;
    for(CommentModel *model in self.commentDataArray)
    {
        float cellHeight = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            CommentCell *cell = (CommentCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
        height += cellHeight;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    [self.superview layoutIfNeeded];
}
-(void)setPraiseLabelTextWithLikeArray:(NSArray *)array
{
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"Like"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    for(int i=0;i<array.count;i++)
    {
        NSString *string = array[i];
        if(i>0)
        {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
        [attString setAttributes:@{ NSLinkAttributeName :string} range:[string rangeOfString:string]];
        [attributedText appendAttributedString:attString];
    }
    self.praiseLabel.attributedText = [attributedText copy];
}
- (void)didClickLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel
{
    NSLog(@"点击了：%@",link.linkValue);
}
@end
