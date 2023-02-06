//
//  HLTiUITool.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUITool.h"
#import <TiSDK/TiSDKInterface.h>

@implementation HLTiUITool


+ (void)heliao_setWriteJsonDic:(NSDictionary *)dic toPath:(NSString *)path{
   
    NSError *heliao_error = nil;
    NSData *heliao_jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&heliao_error];
    NSString *heliao_jsonString = [[NSString alloc] initWithData:heliao_jsonData encoding:NSUTF8StringEncoding];
    if (!heliao_jsonData || heliao_error) {
        NSLog(@"JSON解码失败");
        NSLog(@"JSON文件%@ 写入失败 error-- %@",path,heliao_error);
    } else {
        [heliao_jsonString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&heliao_error];
        if (heliao_error) {
            NSLog(@"JSON文件%@ 写入失败 error-- %@",path,heliao_error);
        }
    }
    
}

+ (id)heliao_getJsonDataForPath:(NSString *)path{
    
    NSData *heliao_jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *heliao_error;
    if (!heliao_jsonData) {
        NSLog(@"JSON文件%@ 解码失败 error--",path);
        return nil;
    } else {
        id heliao_jsonObj = [NSJSONSerialization JSONObjectWithData:heliao_jsonData options:NSJSONReadingMutableContainers error:&heliao_error];
        return heliao_jsonObj;
    }
    
}

+ (void)heliao_getImageFromeURL:(NSString *)fileURL WithFolder:(NSString *)folder downloadComplete:(void(^) (UIImage *image))completeBlock{
    
    NSString *heliao_imageName = [[fileURL componentsSeparatedByString:@"/"] lastObject];
  
    NSString *heliao_cachePaths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  
    NSFileManager *heliao_fileManager = [NSFileManager defaultManager];
    
    NSString *heliao_folderPath = [heliao_cachePaths stringByAppendingFormat:@"/%@",folder];
    
    NSString *heliao_imagePath = [heliao_folderPath stringByAppendingFormat:@"/%@",heliao_imageName];
    
    if ([heliao_fileManager fileExistsAtPath:heliao_imagePath])
    {//文件存在
        UIImage *heliao_image = [UIImage imageWithContentsOfFile:heliao_imagePath];
//            NSLog(@"从本地获取图片 %@",cachePaths);
         completeBlock(heliao_image);
    }else{
        if (![heliao_fileManager fileExistsAtPath:heliao_folderPath]) {
            //创建文件夹
              NSError *error = nil;
              [heliao_fileManager createDirectoryAtPath:heliao_folderPath withIntermediateDirectories:YES attributes:nil error:&error];
              if (error) {
                  NSLog(@"文件夹创建失败 err %@",error);
              }else{
  //                NSLog(@"文件夹创建成功");
              }
        }
        //下载下载图片到本地
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
            if (data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:data];
                    //写入本地
//                    NSLog(@"图片写入本地地址 %@",imagePath);
                    [UIImagePNGRepresentation(image) writeToFile:heliao_imagePath atomically:YES];
//                    [UIImageJPEGRepresentation(image, 0.5)writeToFile:imagePath atomically:YES];
                    completeBlock(image);
                });
            }else{
                NSLog(@"图片地址URL-》%@ \n下载失败",fileURL);
            }
        });
        
    }
}


- (void)heliao_getMediaData:(NSString *)mediaCount {
    NSLog(@"Check your Network");
}
@end
