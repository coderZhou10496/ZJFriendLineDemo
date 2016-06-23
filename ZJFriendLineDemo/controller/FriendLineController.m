//
//  FriendLineController.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/4/7.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "FriendLineController.h"
#import "FriendHeaderView.h"
#import "ZJRefresh.h"
#import "DataSourceManager.h"
#import "FriendLineCellModel.h"
#import "CommentModel.h"
#import "FriendLineCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "ZJImageViewBrowser.h"

#import "ChatKeyBoard.h"
#import "MoreItem.h"
#import "ChatToolBarItem.h"
#import "FaceSourceManager.h"
@interface FriendLineController ()<FriendLineCellDelegate,ChatKeyBoardDelegate, ChatKeyBoardDataSource>
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic,strong)NSIndexPath *commentIndexpath;
@property (nonatomic,strong)NSIndexPath *replyIndexpath;
@property (nonatomic,assign)float totalKeybordHeight;
@end
@implementation FriendLineController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"朋友圈";
    self.dataArray = [DataSourceManager loadDataArray].mutableCopy;
    FriendHeaderView *headerView = [[FriendHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240+64+20)];
    self.tableView.tableHeaderView = headerView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [self.tableView addRefreshHeaderViewWithCallback:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.dataArray = [DataSourceManager loadDataArray].mutableCopy;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView headerEndRefreshing];
        });
    }];
    
    _chatKeyBoard =[ChatKeyBoard keyBoardWithParentViewBounds:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _chatKeyBoard.delegate = self;
    _chatKeyBoard.dataSource = self;
    _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
    _chatKeyBoard.allowVoice = NO;
    _chatKeyBoard.allowMore = NO;
    UIWindow *window =  [UIApplication sharedApplication].delegate.window;
    [window addSubview:_chatKeyBoard];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   float h =  [FriendLineCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        FriendLineCell *cell = (FriendLineCell *)sourceCell;
        [self  configureCell:cell atIndexPath:indexPath];
    }];
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendLineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendLineCell"];
    if(cell==nil)
    {
        cell = [[FriendLineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendLineCell"];
        cell.delegate = self;
    }
    cell.backgroundColor = [UIColor whiteColor];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(FriendLineCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    [cell configCellWithModel:self.dataArray[indexPath.row] indexPath:indexPath];
}
#pragma mark -- FriendLineCellDelegate
#pragma mark -- 点击全文、收起
-(void)didClickedMoreBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath;
{
    FriendLineCellModel *model = self.dataArray[indexPath.row];
    model.isExpand = !model.isExpand;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark -- 点击图片
-(void)didClickImageViewWithCurrentView:(UIImageView *)imageView imageViewArray:(NSMutableArray *)array imageSuperView:(UIView *)view indexPath:(NSIndexPath *)indexPath
{
    ZJImageViewBrowser *browser = [[ZJImageViewBrowser alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) imageViewArray:array imageViewContainView:view];
    browser.selectedImageView = imageView;
    [browser show];
}
#pragma mark -- 点击赞
-(void)didClickenLikeBtnWithIndexPath:(NSIndexPath *)indexPath
{
    FriendLineCellModel *model = self.dataArray[indexPath.row];
    NSMutableArray *likeArray = [NSMutableArray arrayWithArray:model.likeNameArray];
    model.isLiked ==YES ? [likeArray removeObject:@"Sky"]:[likeArray addObject:@"Sky"];
    
    model.likeNameArray = [likeArray copy];
    model.isLiked = !model.isLiked;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark -- 点击评论按钮
-(void)didClickCommentBtnWithIndexPath:(NSIndexPath *)indexPath
{

    self.commentIndexpath = indexPath;
    FriendLineCellModel *model = self.dataArray[indexPath.row];
    self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论：%@",model.usernName];
    [self.chatKeyBoard keyboardUpforComment];
}
#pragma mark --点击评论内容的某一行
-(void)didClickRowWithFirstIndexPath:(NSIndexPath *)firIndexPath secondIndex:(NSIndexPath *)secIndexPath
{
    FriendLineCellModel *model = self.dataArray[firIndexPath.row];
    CommentModel *comModel = model.commentArray[secIndexPath.row];
    if([comModel.userName isEqualToString:@"Sky"])
    {
            UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil  message:@"是否删除该条评论" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"取消");
            }];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSMutableArray *mutableArray = model.commentArray.mutableCopy;
                [mutableArray removeObjectAtIndex:secIndexPath.row];
                model.commentArray = mutableArray.copy;
                [self.tableView reloadRowsAtIndexPaths:@[firIndexPath] withRowAnimation:UITableViewRowAnimationFade];
                
            }];
            [controller addAction:cancelAction];
            [controller addAction:okAction];
            [self presentViewController:controller animated:YES completion:nil];
    }
    else
    {
        self.commentIndexpath = firIndexPath;
        self.replyIndexpath = secIndexPath;
        
        self.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"回复：%@",comModel.userName];
        [self.chatKeyBoard keyboardUpforComment];
    }

}
#pragma mark -- ChatKeyBoardDelegate
- (void)chatKeyBoardSendText:(NSString *)text;
{
    FriendLineCellModel *model = self.dataArray[self.commentIndexpath.row];
    
    CommentModel *newComModel = [[CommentModel alloc] init];
    newComModel.userName = @"Sky";
    if(self.replyIndexpath)
    {
        CommentModel *comModel = model.commentArray[self.replyIndexpath.row];
        newComModel.replyUserName = comModel.userName;
    }
    newComModel.content = text;
    
    
    NSMutableArray *mutableArray = model.commentArray.mutableCopy;
    [mutableArray addObject:newComModel];
    model.commentArray = mutableArray.copy;
    
    [self.tableView reloadRowsAtIndexPaths:@[self.commentIndexpath] withRowAnimation:UITableViewRowAnimationFade];
    self.replyIndexpath = nil;
    [self.chatKeyBoard keyboardDownForComment];
    
}

#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems
{
    return nil;
}
- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems
{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboard"];
    return @[item1];
}
- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems
{
    return [FaceSourceManager loadFaceSource];
}

- (void)keyboardWillChangeNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if(rect.origin.y<ScreenHeight)
    {
        self.totalKeybordHeight  = rect.size.height + 49;
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.commentIndexpath];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //坐标转换
        CGRect rect = [cell.superview convertRect:cell.frame toView:window];
        
        CGFloat dis = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeybordHeight);
        CGPoint offset = self.tableView.contentOffset;
        offset.y += dis;
        if (offset.y < 0) {
            offset.y = 0;
        }
        
        [self.tableView setContentOffset:offset animated:YES];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.chatKeyBoard keyboardDownForComment];
}
-(void)dealloc
{
    NSLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
