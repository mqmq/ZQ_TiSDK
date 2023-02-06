//
//  HLTiUITool.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HLTiUITool : NSObject

//根据路径获取对应的json文件数据
+ (id)heliao_getJsonDataForPath:(NSString *)path;

//根据路径将对应的字典写入json
+ (void)heliao_setWriteJsonDic:(NSDictionary *)dic toPath:(NSString *)path;

//下载图片并缓存的公共方法
+ (void)heliao_getImageFromeURL:(NSString *)fileURL WithFolder:(NSString *)folder downloadComplete:(void(^) (UIImage *image))completeBlock;



NS_ASSUME_NONNULL_END
- (void)heliao_getMediaData:(NSString *)mediaCount;
@end
