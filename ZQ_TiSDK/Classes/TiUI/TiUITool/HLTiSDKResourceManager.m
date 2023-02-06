//
//  HLTiSDKResourceManager.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiSDKResourceManager.h"

@interface HLTiSDKResourceManager ()

@end

@implementation HLTiSDKResourceManager

static HLTiSDKResourceManager *shareManager = nil;
static dispatch_once_t token;

// MARK: --单例初始化方法--
+ (HLTiSDKResourceManager *)shareManager {
    dispatch_once(&token, ^{
        shareManager = [[HLTiSDKResourceManager alloc] init];
    });
    return shareManager;
}

+ (void)heliao_releaseShareManager{
    token = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    //   [shareManager release];
    shareManager = nil;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        NSString *heliao_stickerPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"sticker"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_stickerPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_stickerPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_giftPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gift"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_giftPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_giftPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_watermarkPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"watermark"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_watermarkPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_watermarkPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_maskPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mask"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_maskPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_maskPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_GreenscreenPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"greenscreen"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_GreenscreenPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_GreenscreenPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_portraitPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"portrait"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_portraitPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_portraitPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        NSString *heliao_gesturesPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"gestures"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_gesturesPath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:heliao_gesturesPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
        
        // 拷贝本地贴纸文件到沙盒
        NSString *heliao_localPath1 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"sticker"];
        NSArray *heliao_dirArr1 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath1 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr1) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath1 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath1 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath1 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地礼物文件到沙盒
        NSString *heliao_localPath2 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"gift"];
        NSArray *heliao_dirArr2 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath2 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr2) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath2 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath2 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath2 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地水印文件到沙盒
        NSString *heliao_localPath3 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"watermark"];
        NSArray *heliao_dirArr3 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath3 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr3) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath3 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath3 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath3 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地面具文件到沙盒
        NSString *heliao_localPath4 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"mask"];
        NSArray *heliao_dirArr4 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath4 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr4) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath4 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath4 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath4 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地绿幕文件到沙盒
        NSString *heliao_localPath5 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"greenscreen"];
        NSArray *heliao_dirArr5 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath5 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr5) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath5 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath5 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath5 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地互动贴纸文件到沙盒
        NSString *heliao_localPath6 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"interaction"];
        NSArray *heliao_dirArr6 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath6 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr6) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath6 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath6 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath6 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地抠图文件到沙盒
        NSString *heliao_localPath7 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"portrait"];
        NSArray *heliao_dirArr7 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath7 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr7) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath7 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath7 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath7 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        // 拷贝本地手势文件到沙盒
        NSString *heliao_localPath8 =
        [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:@"gesture"];
        NSArray *heliao_dirArr8 = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath8 error:NULL];
        for (NSString *heliao_pathName in heliao_dirArr8) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[heliao_localPath8 stringByAppendingPathComponent:heliao_pathName]]) {
                [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath8 stringByAppendingPathComponent:heliao_pathName] toPath:[heliao_localPath8 stringByAppendingPathComponent:heliao_pathName] error:NULL];
            }
        }
        
    }
    return self;
}


- (void)heliao_getUserFollowSuccess {
    NSLog(@"Continue");
}
@end
