//
//  DataSourceManager.m
//  ZJFriendLineDemo
//
//  Created by ZJ on 16/6/23.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import "DataSourceManager.h"
#import "FriendLineCellModel.h"
#import "CommentModel.h"
@implementation DataSourceManager
+(NSMutableArray *)loadDataArray
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    NSArray *nameArray = @[@"伤心天涯人",@"寂寞高手",@"怎么忍心怪你犯了错",@"布吉"];
    NSArray *msgStringArray = @[@"这是个测试数据",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据",
                                @"这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据，这是个测试数据，这是试数据，这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据这是个测试数据，这是个测试数据，这是个测试数据"];
    NSArray *headImgNameArray = @[@"icon1",@"icon2",@"icon3",@"icon4"];
    NSArray *picImageNamesArray = @[ @"pic0.jpg",
                                     @"pic1.jpg",
                                     @"pic2.jpg",
                                     @"pic3.jpg",
                                     @"pic4.jpg",
                                     @"pic5.jpg"
                                     ];
    for(int i = 0;i < 10 ;i++)
    {
        FriendLineCellModel *model = [[FriendLineCellModel alloc] init];
        int randomIndex = arc4random_uniform(4);// 生成 0-3随机数
        int picCount = arc4random_uniform(7);
        model.usernName = nameArray[randomIndex];
        model.headImgName = headImgNameArray[randomIndex];
        model.msgContent = msgStringArray[randomIndex];
        
        NSMutableArray *picTemArray = [NSMutableArray array];
        NSMutableArray *commentArray = @[].mutableCopy;
        for(int i = 0;i < picCount ;i++)
        {
            int picIndex = arc4random_uniform(6);
            [picTemArray addObject:picImageNamesArray[picIndex]];
        }
        if(picTemArray.count != 0)
        {
            //图片的数组
            model.picNameArray = [NSArray arrayWithArray:picTemArray];
        }
        for(int i=0;i<3;i++)
        {
            CommentModel *comment = [[CommentModel alloc] init];
            comment.userName = nameArray[i];
            comment.content = msgStringArray[i];
            if(i==1)
            {
                comment.replyUserName = nameArray[3];
            }
            [commentArray addObject:comment];
        }
        //赞的数组
        model.likeNameArray = @[@"怎么忍心怪你犯了错",@"伤心天涯人"];
        //评论的数组
        model.commentArray = [NSArray arrayWithArray:commentArray];
        [dataArray addObject:model];
    }
    return dataArray;
}
@end
