//
//  HLTiMenuPlistManager.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLTiMenuPlistManager : NSObject

- (void)heliao_reset:(NSString *)resetName;

/**
*   初始化单例
*/
+ (HLTiMenuPlistManager *)shareManager;

+ (void)heliao_releaseShareManager;

@property(nonatomic,strong)NSArray *heliao_mainModeArr;

//美颜部分
@property(nonatomic,strong)NSArray *heliao_onekeyModeArr;//一键式美颜
@property(nonatomic,strong)NSArray *heliao_onekeyParameter;//一键式美颜参数
@property(nonatomic,strong)NSArray *heliao_beautyModeArr;//美颜
@property(nonatomic,strong)NSArray *heliao_faceshapeModeArr;//脸型
@property(nonatomic,strong)NSArray *heliao_faceshapeParameter;//脸型参数
@property(nonatomic,strong)NSArray *heliao_appearanceModeArr;//美型

//滤镜部分
@property(nonatomic,strong)NSArray *heliao_filterModeArr;//滤镜
@property(nonatomic,strong)NSArray *heliao_rockModeArr;//抖动
@property(nonatomic,strong)NSArray *heliao_distortionModeArr;//哈哈镜

//萌颜部分
@property(nonatomic,strong)NSArray *heliao_stickersModeArr;//贴纸
@property(nonatomic,strong)NSArray *heliao_interactionsArr;//互动
@property(nonatomic,strong)NSArray *heliao_masksModeArr;//面具
@property(nonatomic,strong)NSArray *heliao_giftModeArr;//礼物
@property(nonatomic,strong)NSArray *heliao_watermarksModeArr;//水印
@property(nonatomic,strong)NSArray *heliao_greenscreensModeArr;//绿幕抠图
@property(nonatomic,strong)NSArray *heliao_portraitsModArr;//人像抠图
@property(nonatomic,strong)NSArray *heliao_gesturesModArr;//手势识别

//美妆部分
@property(nonatomic,strong)NSArray *heliao_makeupModArr;//美妆主界面
@property(nonatomic,strong)NSArray *heliao_blusherModArr;//腮红
@property(nonatomic,strong)NSArray *heliao_eyelashModArr;//睫毛
@property(nonatomic,strong)NSArray *heliao_eyebrowsModArr;//眉毛
@property(nonatomic,strong)NSArray *heliao_eyeshadowModArr;//眼影
@property(nonatomic,strong)NSArray *heliao_eyeLineModArr;//眼线
@property(nonatomic,strong)NSArray *heliao_hairdressModArr;//美发

- (NSArray *)heliao_modifyObject:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path;

@end

@interface TIMenuMode : NSObject

typedef NS_ENUM(NSInteger, DownloadedState) {
    TI_DOWNLOAD_STATE_NOTBEGUN = 0, //下载状态----未下载
    TI_DOWNLOAD_STATE_BEBEING = 1, //下载状态----下载中
    TI_DOWNLOAD_STATE_CCOMPLET = 2,//下载状态----下载完成
};

@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) NSInteger menuTag;
@property(nonatomic,assign) BOOL selected;
@property(nonatomic,assign) BOOL totalSwitch;
@property(nonatomic,strong) NSString *subMenu;
@property(nonatomic,strong) NSString *effectName;//滤镜效果名称

@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *normalThumb;
@property(nonatomic,strong) NSString *normalwhiteThumb;
@property(nonatomic,strong) NSString *selectedThumb;
@property(nonatomic,assign) DownloadedState downloaded;

@property(nonatomic,assign) NSInteger x;
@property(nonatomic,assign) NSInteger y;
@property(nonatomic,assign) NSInteger ratio;

@property(nonatomic,strong) NSString *dir;
@property(nonatomic,strong) NSString *category;
@property(nonatomic,assign) BOOL voiced;
@property(nonatomic,strong) NSString *hint;

+ (instancetype)heliao_applicationWithDic:(NSDictionary*)dic;


- (void)heliao_didGetInfoSuccess;
@end
