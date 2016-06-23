//
//  ZJDataSaver.h
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJDataSaver : NSObject
/**
 将字符串存到自带plist文件中
 */
+(void)saveString:(NSString *)string forKey:(NSString *)key;

/**
 从plist文件中取出key所对应的值
 */
+(NSString*)getStringForKey:(NSString *)key;

/**
 从plist文件中删除键值
 */
+(void)removeStringForKey:(NSString *)key;

/**
 自定义单个对象存到本地
 */
+(void)saveCustomObject:(id)obj;

/**
 根据类名从本地取出自定义单个对象
 */
+(id)getCustomObjectWithClassName:(NSString *)name;

/**
 将字典、数组、字符串、数据 存到本地文件中
 */
+(void)saveCommonData:(id)obj withName:(NSString *)name;

/**
 将字典、数组、字符串、数据 从本地取出来
 */
+(id)getCommonDataWithFileName:(NSString *)name className:(Class)aclass;

/**
 根据文件名删除本地数据
 */
+(void)removeCommonDataWithName:(NSString *)name;

/**
 删除所有数据
 */
+(void)clearAllData;

/**
 获得文件总大小(kb)
 */
+(float)floderSize;

/**
 获取Documents文件夹目录
 */
+(NSString *)getDocumentsPath;

/**
 获取library文件夹目录
 */
+(NSString *)getLibraryPath;

/**
 获取cache文件夹目录
 */
+(NSString *)getCachePath;

/**
 获取temp文件夹目录
 */
+(NSString *)getTempPath;
@end
