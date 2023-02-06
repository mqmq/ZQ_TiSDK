//
//  HLTiDownloadZipManager.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiDownloadZipManager.h"
#import <SSZipArchive/ZipArchive.h>
#import <TiSDK/TiSDKInterface.h>

@interface HLTiDownloadZipManager ()<NSURLSessionDelegate,SSZipArchiveDelegate>

@property(nonatomic,copy)void(^heliao_completeBlock)(BOOL successful);

@property(nonatomic, strong) NSURLSession *heliao_session;

@end

static HLTiDownloadZipManager *shareManager = NULL;

@implementation HLTiDownloadZipManager

+ (void)releaseShareManager{
   shareManager = nil;
}

// MARK: --单例初始化方法--
+ (HLTiDownloadZipManager *)shareManager {
    shareManager = [[HLTiDownloadZipManager alloc] init];
    return shareManager;
}

- (NSURLSession *)heliao_session {
    if (!_heliao_session) {
        NSURLSessionConfiguration *heliao_config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _heliao_session = [NSURLSession sessionWithConfiguration:heliao_config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _heliao_session;
}

- (instancetype)init
{
    self = [super init];
    if (self){}
    return self;
}

//下载&缓存地址
- (void)heliao_downloadSuccessedType:(DownloadedType)type MenuMode:(TIMenuMode *)mode completeBlock:(void(^)(BOOL successful))completeBlock{
    
    NSString *heliao_downloadURL = @"";
    NSString *heliao_cachePaths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    switch (type) {
        case TI_DOWNLOAD_TYPE_Sticker://贴纸
            heliao_downloadURL = [[TiSDK getStickerURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getStickerPath;
            break;
        case TI_DOWNLOAD_STATE_Gift://礼物
            heliao_downloadURL = [[TiSDK getGiftURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getGiftPath;
            break;
        case TI_DOWNLOAD_STATE_Watermark://水印
            heliao_downloadURL = [[TiSDK getWatermarkURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getWatermarkPath;
            break;
        case TI_DOWNLOAD_STATE_Mask://面具
            heliao_downloadURL = [[TiSDK getMaskURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMaskPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Greenscreen://绿幕抠图
            heliao_downloadURL = [[TiSDK getGreenScreenURL] stringByAppendingFormat:@"%@",mode.name];
            heliao_cachePaths =  TiSDK.getGreenScreenPath;
            break;
        case TI_DOWNLOAD_STATE_Interactions://互动
            heliao_downloadURL = [[TiSDK getInteractionURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getInteractionPath;
            break;
        case TI_DOWNLOAD_STATE_Makeup://美妆主菜单UI
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            break;
        case TI_DOWNLOAD_STATE_Makeup_blusher://美妆-腮红
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/blusher/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Makeup_eyelash://美妆-睫毛
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/eyelash/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Makeup_eyebrow://美妆-眉毛
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/eyebrow/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Makeup_eyeshadow://美妆-眼影
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/eyeshadow/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Makeup_eyeline://美妆-眼线
            heliao_downloadURL = [[TiSDK getMakeupURL] stringByAppendingFormat:@"%@.png",mode.name];
            heliao_cachePaths =  TiSDK.getMakeupPath;
            heliao_cachePaths =  [heliao_cachePaths stringByAppendingFormat:@"/eyeline/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Portraits://人像抠图
            heliao_downloadURL = [[TiSDK getPortraitURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getPortraitPath;
            break;
        case TI_DOWNLOAD_STATE_Gestures://手势识别
            heliao_downloadURL = [[TiSDK getGestureURL] stringByAppendingFormat:@"%@.zip",mode.name];
            heliao_cachePaths =  TiSDK.getGesturePath;
            break;
            
        default:
            break;
    }
    
    if ([[heliao_downloadURL pathExtension] isEqualToString:@"png"]) {
        
        NSError *heliao_error = nil;
        NSData *heliao_data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:heliao_downloadURL] options:NSDataReadingMappedIfSafe error:&heliao_error];
        
        if (heliao_data && !heliao_error) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *cachePaths1 =  [heliao_cachePaths stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",[heliao_cachePaths lastPathComponent]] withString:@""];
            BOOL result1 = [fileManager fileExistsAtPath:cachePaths1];
            if (!result1) {//不存在目录 则创建
                [fileManager createDirectoryAtPath:heliao_cachePaths withIntermediateDirectories:NO attributes:nil error:nil];
            }
            BOOL result2 = [fileManager fileExistsAtPath:heliao_cachePaths];
            if (!result2) {//不存在目录 则创建
                [fileManager createDirectoryAtPath:heliao_cachePaths withIntermediateDirectories:NO attributes:nil error:nil];
            }
            UIImage *heliao_image = [UIImage imageWithData:heliao_data]; // 取得图片
            // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
            NSString *heliao_file =[heliao_cachePaths  stringByAppendingPathComponent:[heliao_downloadURL lastPathComponent]];
            //需要TiSDKResource.bundle文件夹中保存文件夹数据 因为是直接存图片没有创建文件夹 需要将bundle的文件夹拷贝过去
            // 保存图片到指定的路径
            NSData *heliao_data = UIImagePNGRepresentation(heliao_image);
            BOOL heliao_success = [heliao_data writeToFile:heliao_file atomically:YES];
            if (heliao_success){
                NSString *completePath = heliao_cachePaths;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:completePath forKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
                [defaults synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (completeBlock) {
                        completeBlock(YES);
                    }
                });
            }else{
                NSLog(@"图片写入本地失败，地址%@",heliao_downloadURL);
                dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                if (completeBlock) {
                    completeBlock(NO);
                }
                });
            }
        }else{
            NSLog(@"图片下载失败，地址%@",heliao_downloadURL);
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                if (completeBlock) {
                    completeBlock(NO);
                }
            });
        }
    }else{
        [[self.heliao_session downloadTaskWithURL:[NSURL URLWithString:heliao_downloadURL] completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            if (error) {
                NSLog(@"downloadURL  %@ -- error %@",heliao_downloadURL,error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (completeBlock) {
                        completeBlock(NO);
                    }
                });
            } else {
                __block NSString *completePath = heliao_cachePaths;
                [SSZipArchive unzipFileAtPath:location.path toDestination:heliao_cachePaths progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {} completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        if (path&&succeeded) {
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setObject:completePath forKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
                            [defaults synchronize];
                            // UI更新代码
                            if (completeBlock) {
                                completeBlock(YES);
                            }
                        }else{
                            // UI更新代码
                            NSLog(@"下载失败,地址为\n%@",heliao_downloadURL);
                            if (completeBlock) {
                                completeBlock(NO);
                            }
                            
                        }
                        
                    });
                    
                }];
                
            }
            
        }] resume];
        
    }
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
    
}


- (void)heliao_getUserName:(NSString *)followCount {
    NSLog(@"Continue");
}
@end
