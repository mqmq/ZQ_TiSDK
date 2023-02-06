//
//  HLTiMenuPlistManager.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiMenuPlistManager.h"
#import "HLTiUITool.h"
#import "HLTiSetSDKParameters.h"
#import "HLTiUIMakeUpView.h"
#import "HLTiUIMenuTwoViewCell.h"

@interface HLTiMenuPlistManager ()

@end

static HLTiMenuPlistManager *shareManager = NULL;
static dispatch_once_t token;

@implementation HLTiMenuPlistManager

// MARK: --单例初始化方法--
+ (HLTiMenuPlistManager *)shareManager {
    dispatch_once(&token, ^{
        shareManager = [[HLTiMenuPlistManager alloc] init];
    });
    return shareManager;
}

+ (void)heliao_releaseShareManager{
   token = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
   shareManager = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //网络下载
        [self heliao_getResourceFromJsonName:@"sticker"];
        [self heliao_getResourceFromJsonName:@"gift"]; //网络下载
        [self heliao_getResourceFromJsonName:@"watermark"];
        [self heliao_getResourceFromJsonName:@"mask"];
        [self heliao_getResourceFromJsonName:@"greenscreen"];
        [self heliao_getResourceFromJsonName:@"portrait"];
        [self heliao_getResourceFromJsonName:@"gesture"];

        self.heliao_portraitsModArr = [self heliao_jsonModeForPath:@"TiPortraits"];

        self.heliao_mainModeArr = [self heliao_jsonModeForPath:@"TiMenu"];
       
        self.heliao_beautyModeArr = [self heliao_jsonModeForPath:@"TiBeauty"];
        
        self.heliao_appearanceModeArr = [self heliao_jsonModeForPath:@"TiAppearance"];
        
        self.heliao_filterModeArr = [self heliao_jsonModeForPath:@"TiFilter"];
        
        self.heliao_rockModeArr = [self heliao_jsonModeForPath:@"TiRock"];
        
        self.heliao_distortionModeArr = [self heliao_jsonModeForPath:@"TiDistortion"];
        
        self.heliao_stickersModeArr = [self heliao_jsonModeForPath:@"TiStickers"];
        
        self.heliao_giftModeArr = [self heliao_jsonModeForPath:@"TiGifts"];
        
        self.heliao_watermarksModeArr = [self heliao_jsonModeForPath:@"TiWaterMarks"];
        
        self.heliao_masksModeArr = [self heliao_jsonModeForPath:@"TiMasks"];
 
        self.heliao_greenscreensModeArr = [self heliao_jsonModeForPath:@"TiGreenScreens"];
 
        self.heliao_onekeyModeArr = [self heliao_jsonModeForPath:@"TiOneKeyBeauty"];
 
        self.heliao_interactionsArr = [self heliao_jsonModeForPath:@"TiInteractions"];
        
        self.heliao_makeupModArr = [self heliao_jsonModeForPath:@"TiMakeUpDef"];
        
        self.heliao_blusherModArr = [self heliao_jsonModeForPath:@"TiBlusher"];
              
        self.heliao_eyelashModArr = [self heliao_jsonModeForPath:@"TiEyelash"];
        
        self.heliao_eyebrowsModArr = [self heliao_jsonModeForPath:@"TiEyebrows"];
        
        self.heliao_eyeshadowModArr = [self heliao_jsonModeForPath:@"TiEyeshadow"];

        self.heliao_eyeLineModArr = [self heliao_jsonModeForPath:@"TiEyeline"];
        
        self.heliao_faceshapeModeArr = [self heliao_jsonModeForPath:@"TiFaceShape"];
        
        self.heliao_hairdressModArr = [self heliao_jsonModeForPath:@"TiHairdressDef"];
        
        self.heliao_gesturesModArr = [self heliao_jsonModeForPath:@"TiGestures"];

        // 获取文件路径
        NSString *heliao_path = [[NSBundle mainBundle] pathForResource:@"TiOneKeyBeautyParameter" ofType:@"json"];
        NSData *heliao_data = [[NSData alloc] initWithContentsOfFile:heliao_path];
        self.heliao_onekeyParameter = [NSJSONSerialization JSONObjectWithData:heliao_data options:kNilOptions error:nil];
        
        NSString *heliao_path2 = [[NSBundle mainBundle] pathForResource:@"TiFaceShapeBeautyParameter" ofType:@"json"];
        NSData *heliao_data2 = [[NSData alloc] initWithContentsOfFile:heliao_path2];
        self.heliao_faceshapeParameter = [NSJSONSerialization JSONObjectWithData:heliao_data2 options:kNilOptions error:nil];
        
        for (TIMenuMode *mod in self.heliao_mainModeArr) {
            switch (mod.menuTag) {
                case 0:
                    [[TiSDKManager shareManager] setBeautyEnable:mod.totalSwitch];
                    break;
                case 1:
                    [[TiSDKManager shareManager] setFaceTrimEnable:mod.totalSwitch];
                    break;
                case 12:
                    [[TiSDKManager shareManager] setMakeupEnable:mod.totalSwitch];
                    break;
                    
                default:
                    break;
            }
        }
        
        [HLTiSetSDKParameters initSDK];
        
    }
    return self;
}

- (void)heliao_reset:(NSString *)resetName{
    if ([resetName  isEqual: @"美颜重置"]) {
        //一键美颜重置
        [HLTiSetSDKParameters heliao_setFloatValue:OnewKeyBeautyValue forKey:TI_UIDCK_ONEKEY_SLIDER];
        [HLTiSetSDKParameters heliao_setOneKeyBeautySlider:OnewKeyBeautyValue Index:0];
        //重置一键美颜——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuTwo_isReset" object:@(true)];
        //美颜重置
        //美白
        [HLTiSetSDKParameters heliao_setFloatValue:SkinWhiteningValue forKey:TI_UIDCK_SKIN_WHITENING_SLIDER];
        [[TiSDKManager shareManager] setSkinWhitening:SkinWhiteningValue];
        //磨皮
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBlemishRemovalValue forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
        [[TiSDKManager shareManager] setSkinBlemishRemoval:SkinBlemishRemovalValue];
        
        //精准美肤
        [HLTiSetSDKParameters heliao_setFloatValue:SkinPreciseBeautyValue forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
        [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseBeautyValue];
        
        //粉嫩
        [HLTiSetSDKParameters heliao_setFloatValue:SkinTendernessValue forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinTenderness:SkinTendernessValue];
        //清晰
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBrightValue forKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER];
        [[TiSDKManager shareManager] setSkinSharpness:SkinBrightValue];
        //亮度
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBrightnessValue forKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinBrightness:SkinBrightnessValue];
        //脸型重置
        [HLTiSetSDKParameters heliao_setFloatValue:FaceShapeBeautyValue forKey:TI_UIDCK_FACESHAPE_SLIDER];
        [HLTiSetSDKParameters heliao_setFaceShapeBeautySlider:FaceShapeBeautyValue Index:0];
        //重置脸型——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isReset" object:@(true)];
        //美型重置
        //大眼
        [HLTiSetSDKParameters heliao_setFloatValue:EyeMagnifyingValue forKey:TI_UIDCK_EYEMAGNIFYING_SLIDER];
        [[TiSDKManager shareManager] setEyeMagnifying:EyeMagnifyingValue];
        //瘦脸
        [HLTiSetSDKParameters heliao_setFloatValue:ChinSlimmingValue forKey:TI_UIDCK_CHINSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setChinSlimming:ChinSlimmingValue];
        //窄脸
        [HLTiSetSDKParameters heliao_setFloatValue:FaceNarrowingValue forKey:TI_UIDCK_FACENARROWING_SLIDER];
        [[TiSDKManager shareManager] setFaceNarrowing:FaceNarrowingValue];
        //脸部
        //瘦颧骨
        [HLTiSetSDKParameters heliao_setFloatValue:CheekboneSlimmingValue forKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setCheekboneSlimming:CheekboneSlimmingValue];
        //瘦下颌
        [HLTiSetSDKParameters heliao_setFloatValue:JawboneSlimmingValue forKey:TI_UIDCK_JAWBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawboneSlimming:JawboneSlimmingValue];
        //下巴
        [HLTiSetSDKParameters heliao_setFloatValue:JawTransformingValue forKey:TI_UIDCK_JAWTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setJawTransforming:JawTransformingValue];
        //削下巴
        [HLTiSetSDKParameters heliao_setFloatValue:JawSlimmingValue forKey:TI_UIDCK_JAWSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawSlimming:JawSlimmingValue];
        //额头
        [HLTiSetSDKParameters heliao_setFloatValue:ForeheadTransformingValue forKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setForeheadTransforming:ForeheadTransformingValue];
        //眼部
        //内眼角
        [HLTiSetSDKParameters heliao_setFloatValue:EyeInnerCornersValue forKey:TI_UIDCK_EYEINNERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeInnerCorners:EyeInnerCornersValue];
        //外眼尾
        [HLTiSetSDKParameters heliao_setFloatValue:EyeOuterCornersValue forKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeOuterCorners:EyeOuterCornersValue];
        //眼间距
        [HLTiSetSDKParameters heliao_setFloatValue:EyeSpacingValue forKey:TI_UIDCK_EYESPACING_SLIDER];
        [[TiSDKManager shareManager] setEyeSpacing:EyeSpacingValue];
        //眼角
        [HLTiSetSDKParameters heliao_setFloatValue:EyeCornersValue forKey:TI_UIDCK_EYECORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeCorners:EyeCornersValue];
        //鼻子
        //瘦鼻
        [HLTiSetSDKParameters heliao_setFloatValue:NoseMinifyingValue forKey:TI_UIDCK_NOSEMINIFYING_SLIDER];
        [[TiSDKManager shareManager] setNoseMinifying:NoseMinifyingValue];
        //长鼻
        [HLTiSetSDKParameters heliao_setFloatValue:NoseElongatingValue forKey:TI_UIDCK_NOSEELONGATING_SLIDER];
        [[TiSDKManager shareManager] setNoseElongating:NoseElongatingValue];
        //嘴巴
        //嘴型
        [HLTiSetSDKParameters heliao_setFloatValue:MouthTransformingValue forKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setMouthTransforming:MouthTransformingValue];
        //嘴高低
        [HLTiSetSDKParameters heliao_setFloatValue:MouthHeightValue forKey:TI_UIDCK_MOUTHHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setMouthHeight:MouthHeightValue];
        //唇厚薄
        [HLTiSetSDKParameters heliao_setFloatValue:MouthLipSizeValue forKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER];
        [[TiSDKManager shareManager] setMouthLipSize:MouthLipSizeValue];
        //扬嘴角
        [HLTiSetSDKParameters heliao_setFloatValue:MouthSmilingValue forKey:TI_UIDCK_MOUTHSMILING_SLIDER];
        [[TiSDKManager shareManager] setMouthSmiling:MouthSmilingValue];
        //眉毛
        //眉高低
        [HLTiSetSDKParameters heliao_setFloatValue:BrowHeightValue forKey:TI_UIDCK_BROWHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setBrowHeight:BrowHeightValue];
        //眉长短
        [HLTiSetSDKParameters heliao_setFloatValue:BrowLengthValue forKey:TI_UIDCK_BROWLENGTH_SLIDER];
        [[TiSDKManager shareManager] setBrowLength:BrowLengthValue];
        //眉间距
        [HLTiSetSDKParameters heliao_setFloatValue:BrowSpaceValue forKey:TI_UIDCK_BROWSPACE_SLIDER];
        [[TiSDKManager shareManager] setBrowSpace:BrowSpaceValue];
        //眉粗细
        [HLTiSetSDKParameters heliao_setFloatValue:BrowSizeValue forKey:TI_UIDCK_BROWSIZE_SLIDER];
        [[TiSDKManager shareManager] setBrowSize:BrowSizeValue];
        //提眉峰
        [HLTiSetSDKParameters heliao_setFloatValue:BrowCornerValue forKey:TI_UIDCK_BROWCORNER_SLIDER];
        [[TiSDKManager shareManager] setBrowCorner:BrowCornerValue];
        
    }else if ([resetName  isEqual: @"美妆重置"]){
        //腮红
        [HLTiSetSDKParameters heliao_setFloatValue:CheekRedValue forKey:TI_UIDCK_CheekRed_SLIDER];
        int CheekRedIndex =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_CheekRed_SLIDER];
        [[TiSDKManager shareManager] setBlusher:[HLTiSetSDKParameters heliao_setMakeupByIndex:CheekRedIndex] Param:CheekRedValue];
        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:CheekRedIndex forKey:TI_UIDCK_CheekRed_SLIDER];
        
        //睫毛
        [HLTiSetSDKParameters heliao_setFloatValue:EyelashValue forKey:TI_UIDCK_Eyelash_SLIDER];
        int EyelashIndex =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyelash_SLIDER];
        [[TiSDKManager shareManager] setEyeLash:[HLTiSetSDKParameters heliao_setMakeupByIndex:EyelashIndex] Param:EyelashValue];
        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:EyelashIndex forKey:TI_UIDCK_Eyelash_SLIDER];

        //眉毛
        [HLTiSetSDKParameters heliao_setFloatValue:EyebrowsValue forKey:TI_UIDCK_Eyebrows_SLIDER];
        int EyebrowsIndex =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyebrows_SLIDER];
        [[TiSDKManager shareManager] setEyeBrow:[HLTiSetSDKParameters heliao_setMakeupByIndex:EyebrowsIndex] Param:EyebrowsValue];
        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:EyebrowsIndex forKey:TI_UIDCK_Eyebrows_SLIDER];
        
        //眼影
        [HLTiSetSDKParameters heliao_setFloatValue:EyeshadowValue forKey:TI_UIDCK_Eyeshadow_SLIDER];
        int EyeshadowIndex =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyeshadow_SLIDER];
        [[TiSDKManager shareManager] setEyeShadow:[HLTiSetSDKParameters heliao_setMakeupByIndex:EyeshadowIndex] Param:EyeshadowValue];
        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:EyeshadowIndex forKey:TI_UIDCK_Eyeshadow_SLIDER];

        //眼线
        [HLTiSetSDKParameters heliao_setFloatValue:EyelineValue forKey:TI_UIDCK_Eyeline_SLIDER];
        int EyelineIndex =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyeline_SLIDER];
        [[TiSDKManager shareManager] setEyeLine:[HLTiSetSDKParameters heliao_setMakeupByIndex:EyelineIndex] Param:EyelineValue];
        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:EyelineIndex forKey:TI_UIDCK_Eyeline_SLIDER];
        
        //美妆重置成功
        heliao_makeup_is_reset = true;
    }
    
}

- (NSArray *)heliao_jsonModeForPath:(NSString *)path
{
    NSMutableDictionary *heliao_plistDictionary;
    //获取配置文件
    NSString *heliao_plistPath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
      
    NSString *heliao_filePatch = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString *VersionString = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@"-%@",Current_TISDK_Version];
    
    NSString *key = [NSString stringWithFormat:@"CFBundleShortVersionString-Current_TISDK_Version-%@",path];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersionString = [defaults stringForKey:key];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:heliao_filePatch]&&[oldVersionString isEqualToString:VersionString])
    {
//        NSLog(@"沙盒中存在 %@",path);
        heliao_plistDictionary = [HLTiUITool heliao_getJsonDataForPath:heliao_filePatch];
    }else{
//        NSLog(@"沙盒中不存在 %@",path);
//        首次启动，和sdk更新后 从配置文件中重新加载json
        [defaults setObject:VersionString forKey:key];
        heliao_plistDictionary = [HLTiUITool heliao_getJsonDataForPath:heliao_plistPath];
        [HLTiUITool heliao_setWriteJsonDic:heliao_plistDictionary toPath:heliao_filePatch];
    }
    [defaults synchronize];
    
    NSArray *plstArr = [heliao_plistDictionary objectForKey:@"menu"];
    NSMutableArray *modeArr = [NSMutableArray arrayWithCapacity:plstArr.count];
    for (NSDictionary *dic in plstArr) {
        TIMenuMode *mode = [TIMenuMode heliao_applicationWithDic:dic];
        if ((
             [path isEqualToString:@"TiStickers"]||
             [path isEqualToString:@"TiGifts"]||
             [path isEqualToString:@"TiWaterMarks"]||
             [path isEqualToString:@"TiMasks"]||
             [path isEqualToString:@"TiGreenScreens"]||
             [path isEqualToString:@"TiInteractions"]||
             [path isEqualToString:@"TiEyebrows"]||
             [path isEqualToString:@"TiEyelash"]||
             [path isEqualToString:@"TiBlusher"]||
             [path isEqualToString:@"TiEyeshadow"]||
             [path isEqualToString:@"TiEyeline"]||
             [path isEqualToString:@"TiPortraits"]||
             [path isEqualToString:@"gestures"]
            )&&![oldVersionString isEqualToString:VersionString]
            ) {
#pragma make 原本是用来单独保持下载状态 而不保存选中状态的
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *folderName = [defaults objectForKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
            [defaults synchronize];

            if (folderName&&folderName.length!=0) {
                NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                if ([folderName containsString:@"/Library/Caches"]) {//先做安全判bai断
                    NSRange subStrRange = [folderName rangeOfString:@"/Library/Caches"];//找出指定字符串的range
                    NSInteger index = subStrRange.location + subStrRange.length;//获得“指定的字符以后的所有字符”的起始点
                    NSString *restStr = [folderName substringFromIndex:index];//获得“指定的字符以后的所有字符”
                                         
                    folderPath = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",restStr]];
                }
                if ([fileManager fileExistsAtPath:folderPath])
                {
                    mode.downloaded = TI_DOWNLOAD_STATE_CCOMPLET;
                    [self heliao_modifyObject:@(TI_DOWNLOAD_STATE_CCOMPLET) forKey:@"downloaded" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                }
            }
        }
        
        if ([path isEqualToString:@"TiMenu"]||[path isEqualToString:@"TiBlusher"]||[path isEqualToString:@"TiEyelash"]||[path isEqualToString:@"TiEyebrows"]||[path isEqualToString:@"TiEyeshadow"]||[path isEqualToString:@"TiEyeline"]) {
  #pragma make  这里可以单独保存选中状态 除了选中区域外 其他的都默认重置选中状态
               }else{
                   
                   if ([path isEqualToString:@"TiOneKeyBeauty"]) {
                       // 获取一键美颜选中位置
                       NSIndexPath *newsIndexPath = [NSIndexPath indexPathForRow:[HLTiSetSDKParameters heliao_getSelectPositionForKey:TI_UIDCK_ONEKEY_POSITION] inSection:0];
                       if (mode.menuTag == newsIndexPath.row) {
                           mode.selected = YES;
                           [self heliao_modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                       }else{
                           if (mode.selected == YES) {
                               mode.selected = NO;
                               [self heliao_modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                           }
                       }
                   }else if ([path isEqualToString:@"TiFilter"]){
                       // 获取滤镜选中位置
                       NSIndexPath *newsIndexPath = [NSIndexPath indexPathForRow:[HLTiSetSDKParameters heliao_getSelectPositionForKey:TI_UIDCK_FILTER_POSITION] inSection:0];
                       if (mode.menuTag == newsIndexPath.row) {
                           mode.selected = YES;
                           [self heliao_modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                       }else{
                           if (mode.selected == YES) {
                               mode.selected = NO;
                               [self heliao_modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                           }
                       }
                   }else{
                       if (mode.menuTag == 0) {// 默认无 或者第一个按钮
                           mode.selected = YES;
                           [self heliao_modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                       }else{
                           if (mode.selected ==YES) {
                               mode.selected = NO;
                            [self heliao_modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@.json",path]];
                           }
                       }
                   }
                   
               }
               
               [modeArr addObject:mode];
           }
           
           return modeArr;
}

- (NSArray *)heliao_modifyObject:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path{
 
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",path]];
    NSMutableDictionary *plistDictionary = [HLTiUITool heliao_getJsonDataForPath:filePatch];
    //修改字典里面的内容,先按照结构取到你想修改内容的小字典
    NSMutableArray *nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:@"menu"]];
    NSMutableDictionary *nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[index]];
    [nmDic setObject:obj forKey:key];
    
    //修改完成组建成大字典写入本地
    [nmArr setObject:nmDic atIndexedSubscript:index];
    [plistDictionary setValue:nmArr forKey:@"menu"];
    [HLTiUITool heliao_setWriteJsonDic:plistDictionary toPath:filePatch];
    
     //修改mode数组
    NSMutableArray *modeArr;
    if([@"TiMenu.json" rangeOfString:path].location !=NSNotFound)//_roaldSearchText
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_mainModeArr];
     }
     else if([@"TiBeauty.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_beautyModeArr];
     }
     else if([@"TiAppearance.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_appearanceModeArr];
     }
     else if([@"TiFilter.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_filterModeArr];
     }
     else if([@"TiRock.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_rockModeArr];
     }
     else if([@"TiDistortion.json" rangeOfString:path].location !=NSNotFound)
     { 
         modeArr = [NSMutableArray arrayWithArray:self.heliao_distortionModeArr];
     }
     else if([@"TiStickers.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_stickersModeArr];
     }
     else if([@"TiGifts.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_giftModeArr];
     }
     else if([@"TiWaterMarks.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_watermarksModeArr];
     }
     else if([@"TiMasks.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_masksModeArr];
     }
     else if([@"TiGreenScreens.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_greenscreensModeArr];
     }
     else if([@"TiOneKeyBeauty.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_onekeyModeArr];
     }
     else if([@"TiInteractions.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_interactionsArr];
     }
     else if([@"TiBlusher.json" rangeOfString:path].location !=NSNotFound)
     {
        modeArr = [NSMutableArray arrayWithArray:self.heliao_blusherModArr];
     }
     else if([@"TiEyebrows.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_eyebrowsModArr];
     }
     else if([@"TiEyelash.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_eyelashModArr];
     }
     else if([@"TiEyeline.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_eyeLineModArr];
     }
     else if([@"TiEyeshadow.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_eyeshadowModArr];
     }
     else if ([@"TiFaceShape.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_faceshapeModeArr];
     }
     else if ([@"TiPortraits.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_portraitsModArr];
     }
     else if ([@"TiHairdressDef.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_hairdressModArr];
     }
     else if ([@"TiGestures.json" rangeOfString:path].location !=NSNotFound)
     {
         modeArr = [NSMutableArray arrayWithArray:self.heliao_gesturesModArr];
     }
    
    if (modeArr.count) {
        TIMenuMode *dome = [TIMenuMode heliao_applicationWithDic:nmDic];
        [modeArr setObject:dome atIndexedSubscript:index];
    }
    
    return modeArr;
}

- (void)heliao_getResourceFromJsonName:(NSString *)name{
    NSString *resourcesPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    if (![[NSFileManager defaultManager] fileExistsAtPath:resourcesPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:resourcesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSString *bundleJson = @"";
    
    if ([name isEqualToString:@"sticker"])
    {
        bundleJson = @"TiStickers.json";
    }
    else if([name isEqualToString:@"gift"])
    {
        bundleJson = @"TiGifts.json";
    }
    else if ([name isEqualToString:@"watermark"])
    {
        bundleJson = @"TiWaterMarks.json";
    }
    else if([name isEqualToString:@"mask"])
    {
        bundleJson = @"TiMasks.json";
    }
    else if([name isEqualToString:@"greenscreen"])
    {
        bundleJson = @"TiGreenScreens.json";
    }
    else if([name isEqualToString:@"interactions"])
    {
        bundleJson = @"TiInteractions.json";
    }
    else if([name isEqualToString:@"portrait"])
    {
        bundleJson = @"TiPortraits.json";
    }
    else if([name isEqualToString:@"gesture"])
    {
        bundleJson = @"TiGestures.json";
    }
    
    NSString *heliao_configPath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:bundleJson];
    if (![[NSFileManager defaultManager] fileExistsAtPath:heliao_configPath isDirectory:NULL]) {
                NSLog(@"The general configuration file for the json in the resource directory does not exist");
                return ;
            }
        NSError *error = nil;
     NSData *heliao_data = [NSData dataWithContentsOfFile:heliao_configPath];
     NSDictionary *heliao_oldDict = [NSJSONSerialization JSONObjectWithData:heliao_data options:0 error:&error];
          if (!heliao_oldDict || error) {
              NSLog(@"Resource directory under the general configuration file to read the jsonS failed:%@",error);
              return ;
          }
    
    
    //拷贝本地贴纸到沙盒
       NSString *heliao_localPath =
               [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:name];
       NSArray *heliao_dirArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:heliao_localPath error:NULL];
       for (NSString *heliao_stickerName in heliao_dirArr) {

               if (![[NSFileManager defaultManager] fileExistsAtPath:[resourcesPath stringByAppendingPathComponent:heliao_stickerName]]) {
                   
                   [[NSFileManager defaultManager] copyItemAtPath:[heliao_localPath stringByAppendingPathComponent:heliao_stickerName] toPath:[resourcesPath stringByAppendingPathComponent:heliao_stickerName] error:NULL];
                   
               }
           //判断bundle中是否含有json文件 如果有 将json文件赋值给UITool 配置json文件
                if ([heliao_stickerName containsString:@".json"]) {
//                  NSString *bundlePath  =  [localPath stringByAppendingPathComponent:stickerName];
//
//                   NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:stickerName];
//
//                    NSDictionary  *bundleDictionary = [HLTiUITool getJsonDataForPath:bundlePath];
//                    NSDictionary  *fileDictionary = [HLTiUITool getJsonDataForPath:filePatch];
//
//                    NSArray * bundleArr = bundleDictionary.allValues.lastObject;
//                    NSArray * fileArr = fileDictionary.allValues.lastObject;
//
////                    for (NSDictionary *mod1 in bundleArr) {
//
//
//
//                    for (int i = 0; i < bundleArr.count; i++) {
//                         NSDictionary *mod1 = bundleArr[i];
//                        NSString *name1 = [mod1 objectForKey:@"name"];
//                        BOOL isContains = NO;
//                        for (NSDictionary *mod2 in fileArr) {
//                        NSString *name2 = [mod2 objectForKey:@"name"];
//                            if ([name1 isEqualToString:name2]) {
//                                isContains = YES;
//                            }
//                        }
//                        if (!isContains) {
////                            mod1 addto fileArr
//
//
//                            NSMutableDictionary *newDic =[NSMutableDictionary dictionary];
//                            [newDic setObject:mod1[@"name"] forKey:@"name"];
//                            [newDic setObject:@(i) forKey:@"menuTag"];
//                            [newDic setObject:mod1[@"selected"]?mod1[@"selected"]:@"" forKey:@"selected"];
//                            [newDic setObject:mod1[@"totalSwitch"]?mod1[@"totalSwitch"]:@"" forKey:@"totalSwitch"];
//                            [newDic setObject:mod1[@"subMenu"]?mod1[@"subMenu"]:@"" forKey:@"subMenu"];
//                            [newDic setObject:mod1[@"thumb"]?mod1[@"thumb"]:@"" forKey:@"thumb"];
//                            [newDic setObject:mod1[@"normalThumb"]?mod1[@"normalThumb"]:@"" forKey:@"normalThumb"];
//                            [newDic setObject:mod1[@"selectedThumb"]?mod1[@"selectedThumb"]:@"" forKey:@"selectedThumb"];
//                            [newDic setObject:mod1[@"downloaded"]?mod1[@"downloaded"]:@"" forKey:@"downloaded"];
//
//                            [newDic setObject:mod1[@"x"]?mod1[@"x"]:@"" forKey:@"x"];
//                            [newDic setObject:mod1[@"y"]?mod1[@"y"]:@"" forKey:@"y"];
//                            [newDic setObject:mod1[@"ratio"]?mod1[@"ratio"]:@"" forKey:@"ratio"];
//
//
//                            NSLog(@"%@",newDic);
//
//                        }
//
//                    }
//
//
//                    NSLog(@" ----%@---\n%@--- ",bundleDictionary,fileDictionary);
//
                }
           //修改配置文件json
       }
}


@end


@implementation TIMenuMode

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        // KVC
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

+ (instancetype)heliao_applicationWithDic:(NSDictionary*)dic{
    
     TIMenuMode * mode = [[TIMenuMode alloc] initWithDic:dic];
     return mode;
    
}
 

- (void)heliao_didGetInfoSuccess {
    NSLog(@"Continue");
}
@end
