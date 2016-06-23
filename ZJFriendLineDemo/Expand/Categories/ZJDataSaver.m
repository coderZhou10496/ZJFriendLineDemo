//
//  ZJDataSaver.m
//  MyCategories
//
//  Created by ZJ on 15/11/11.
//  Copyright © 2015年 WXDL. All rights reserved.
//

#import "ZJDataSaver.h"

@implementation ZJDataSaver
+(void)saveString:(NSString *)string forKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:string forKey:key];
    [defaults synchronize];
}

+(NSString *)getStringForKey:(NSString *)key
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+(void)removeStringForKey:(NSString *)key
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
+(void)saveCustomObject:(id)obj
{
    NSString *string = NSStringFromClass([obj class]);
    NSString *filePath = [self getFilePathWithName:string];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [data writeToFile:filePath atomically:YES];
}
+(id)getCustomObjectWithClassName:(NSString *)name
{
    NSData * data = [NSData dataWithContentsOfFile:[self getFilePathWithName:name]];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return object;
}
+(void)saveCommonData:(id)obj withName:(NSString *)name
{
    NSString *filePath = [self getFilePathWithName:name];
    if ([obj isKindOfClass:[NSString class]])
    {
        [((NSString*)obj) writeToFile:filePath
                           atomically:YES
                             encoding:NSUTF8StringEncoding
                                error:nil];
    }
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        [((NSDictionary*)obj) writeToFile:filePath
                               atomically:YES];
    }
    
    if ([obj isKindOfClass:[NSArray class]]) {
        [((NSArray*)obj) writeToFile:filePath
                          atomically:YES];
    }
    
    if ([obj isKindOfClass:[NSData class]]) {
        [((NSData*)obj) writeToFile:filePath atomically:YES];
    }
}
+(id)getCommonDataWithFileName:(NSString *)name className:(Class)aclass
{
    NSString *filePath = [self getFilePathWithName:name];
    NSString *className = NSStringFromClass(aclass);
    if([className isEqualToString:@"NSArray"])
    {
        NSArray * getArray = [[NSArray alloc]initWithContentsOfFile:filePath];
        return getArray;
    }
    if([className isEqualToString:@"NSDictionary"])
    {
        NSDictionary * getDic = [[NSDictionary alloc]initWithContentsOfFile:filePath];
        return getDic;
    }
    if([className isEqualToString:@"NSString"])
    {
        NSString * string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        return string;
    }
    if([className isEqualToString:@"NSData"])
    {
        NSData * getData = [[NSData alloc]initWithContentsOfFile:filePath];
        return getData;
    }
    return nil;
}
+(void)removeCommonDataWithName:(NSString *)name
{
    NSString *filePath = [self getFilePathWithName:name];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath
                                error:nil];
    }
    
}
+(void)clearAllData
{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/ZJDataSaver",NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path
                                error:nil];
    }
}
+(float)floderSize
{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/ZJDataSaver",NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) return 0;
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:path] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [path stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
        
    }
    return folderSize/(1024.0);
    
}
+ (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        
    }
    return 0;
    
}
+(NSString *)getDocumentsPath
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [docPath objectAtIndex:0];
    return documentsPath;
}
+(NSString *)getLibraryPath
{
    NSArray *libsPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libsPath objectAtIndex:0];
    return libPath;
}
+(NSString *)getCachePath
{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    return cachePath;
}
+(NSString *)getTempPath
{
    NSString *tempPath = NSTemporaryDirectory();
    return tempPath;
}
+(NSString * )getFilePathWithName:(NSString *)name
{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/ZJDataSaver",NSHomeDirectory()];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExits = [fileManager fileExistsAtPath:path];
    if(!fileExits)
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString * filePath = [NSString stringWithFormat:@"%@/%@",path,name];
    return filePath;
}
@end
