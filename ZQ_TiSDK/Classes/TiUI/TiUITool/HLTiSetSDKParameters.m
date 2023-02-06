//
//  HLTiSetSDKParameters.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiSetSDKParameters.h"

bool is_updateFilter = false;
bool is_updateFilterValue = false;

@interface HLTiSetSDKParameters ()

@end

@implementation HLTiSetSDKParameters

+ (void)initSDK{
    
    //美白指定初始值
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_WHITENING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinWhiteningValue forKey:TI_UIDCK_SKIN_WHITENING_SLIDER];
    }
    [[TiSDKManager shareManager] setSkinWhitening:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_WHITENING_SLIDER]];
    
    //磨皮指定初始值
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBlemishRemovalValue forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
    }
     [[TiSDKManager shareManager] setSkinBlemishRemoval:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER]];
    
    //精准美肤指定初始值
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinPreciseBeautyValue forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
    }
     [[TiSDKManager shareManager] setSkinPreciseBeauty:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER]];
    
    //亮度
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBrightnessValue forKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER];
    }
    [[TiSDKManager shareManager] setSkinBrightness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER]];
    
    //粉嫩
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinTendernessValue forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
    }
    [[TiSDKManager shareManager] setSkinTenderness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER]];

    //清晰
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SkinBrightValue forKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER];
    }
    [[TiSDKManager shareManager] setSkinSharpness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER]];
    
    //    ------------------------------------------
 
    //大眼
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_EYEMAGNIFYING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeMagnifyingValue forKey:TI_UIDCK_EYEMAGNIFYING_SLIDER];
    }
    [[TiSDKManager shareManager] setEyeMagnifying:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_EYEMAGNIFYING_SLIDER]];
    //瘦脸
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_CHINSLIMMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:ChinSlimmingValue forKey:TI_UIDCK_CHINSLIMMING_SLIDER];
    }
    [[TiSDKManager shareManager] setChinSlimming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_CHINSLIMMING_SLIDER]];
    //窄脸
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_FACENARROWING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:FaceNarrowingValue forKey:TI_UIDCK_FACENARROWING_SLIDER];
    }
    [[TiSDKManager shareManager] setFaceNarrowing:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_FACENARROWING_SLIDER]];
    //脸部
    //瘦颧骨
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:CheekboneSlimmingValue forKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER];
    }
    [[TiSDKManager shareManager] setCheekboneSlimming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER]];
    //瘦下颌
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_JAWBONESLIMMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:JawboneSlimmingValue forKey:TI_UIDCK_JAWBONESLIMMING_SLIDER];
    }
    [[TiSDKManager shareManager] setJawboneSlimming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_JAWBONESLIMMING_SLIDER]];
    //下巴
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_JAWTRANSFORMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:JawTransformingValue forKey:TI_UIDCK_JAWTRANSFORMING_SLIDER];
    }
    [[TiSDKManager shareManager] setJawTransforming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_JAWTRANSFORMING_SLIDER]];
    //削下巴
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_JAWSLIMMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:JawSlimmingValue forKey:TI_UIDCK_JAWSLIMMING_SLIDER];
    }
    [[TiSDKManager shareManager] setJawSlimming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_JAWSLIMMING_SLIDER]];
    //额头
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:ForeheadTransformingValue forKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER];
    }
    [[TiSDKManager shareManager] setForeheadTransforming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER]];
    //眼部
    //内眼角
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_EYEINNERCORNERS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeInnerCornersValue forKey:TI_UIDCK_EYEINNERCORNERS_SLIDER];
    }
    [[TiSDKManager shareManager] setEyeInnerCorners:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_EYEINNERCORNERS_SLIDER]];
    //外眼尾
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeOuterCornersValue forKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER];
    }
    [[TiSDKManager shareManager] setEyeOuterCorners:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER]];
    //眼间距
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_EYESPACING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeSpacingValue forKey:TI_UIDCK_EYESPACING_SLIDER];
    }
    [[TiSDKManager shareManager] setEyeSpacing:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_EYESPACING_SLIDER]];
    //眼角
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_EYECORNERS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeCornersValue forKey:TI_UIDCK_EYECORNERS_SLIDER];
    }
    [[TiSDKManager shareManager] setEyeCorners:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_EYECORNERS_SLIDER]];
    //鼻子
    //瘦鼻
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_NOSEMINIFYING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:NoseMinifyingValue forKey:TI_UIDCK_NOSEMINIFYING_SLIDER];
    }
    [[TiSDKManager shareManager] setNoseMinifying:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_NOSEMINIFYING_SLIDER]];
    //长鼻
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_NOSEELONGATING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:NoseElongatingValue forKey:TI_UIDCK_NOSEELONGATING_SLIDER];
    }
    [[TiSDKManager shareManager] setNoseElongating:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_NOSEELONGATING_SLIDER]];
    //嘴巴
    //嘴型
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:MouthTransformingValue forKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER];
    }
    [[TiSDKManager shareManager] setMouthTransforming:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER]];
    //嘴高低
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_MOUTHHEIGHT_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:MouthHeightValue forKey:TI_UIDCK_MOUTHHEIGHT_SLIDER];
    }
    [[TiSDKManager shareManager] setMouthHeight:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_MOUTHHEIGHT_SLIDER]];
    //唇厚薄
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:MouthLipSizeValue forKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER];
    }
    [[TiSDKManager shareManager] setMouthLipSize:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER]];
    //扬嘴角
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_MOUTHSMILING_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:MouthSmilingValue forKey:TI_UIDCK_MOUTHSMILING_SLIDER];
    }
    [[TiSDKManager shareManager] setMouthSmiling:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_MOUTHSMILING_SLIDER]];
    //眉毛
    //眉高低
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_BROWHEIGHT_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:BrowHeightValue forKey:TI_UIDCK_BROWHEIGHT_SLIDER];
    }
    [[TiSDKManager shareManager] setBrowHeight:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_BROWHEIGHT_SLIDER]];
    //眉长短
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_BROWLENGTH_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:BrowLengthValue forKey:TI_UIDCK_BROWLENGTH_SLIDER];
    }
    [[TiSDKManager shareManager] setBrowLength:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_BROWLENGTH_SLIDER]];
    //眉间距
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_BROWSPACE_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:BrowSpaceValue forKey:TI_UIDCK_BROWSPACE_SLIDER];
    }
    [[TiSDKManager shareManager] setBrowSpace:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_BROWSPACE_SLIDER]];
    //眉粗细
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_BROWSIZE_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:BrowSizeValue forKey:TI_UIDCK_BROWSIZE_SLIDER];
    }
    [[TiSDKManager shareManager] setBrowSize:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_BROWSIZE_SLIDER]];
    //提眉峰
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_BROWCORNER_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:BrowCornerValue forKey:TI_UIDCK_BROWCORNER_SLIDER];
    }
    [[TiSDKManager shareManager] setBrowCorner:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_BROWCORNER_SLIDER]];
    
    //    ------------------------------------------
    
    //    滤镜300～354
    for (int key = 300; key <= 354; key++) {
        if (!(key == 1 || key == 9 || key == 16 || key == 26 || key == 32 || key == 37 || key == 43 || key == 48)) {
            if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:key]) {
                [HLTiSetSDKParameters heliao_setFloatValue:FilterValue forKey:key];
            }
        }
    }
    
    //    TI_UIDCK_ONEKEY_SLIDER = 400, // 一键美颜
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_ONEKEY_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:OnewKeyBeautyValue forKey:TI_UIDCK_ONEKEY_SLIDER];
    }
    //    TI_UIDCK_FACESHAPE_SLIDER = 500, //脸型
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_FACESHAPE_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:FaceShapeBeautyValue forKey:TI_UIDCK_FACESHAPE_SLIDER];
    }
    //    TI_UIDCK_HAIRDRESS_SLIDER = 600, // 美发
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_HAIRDRESS_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:HairdressValue forKey:TI_UIDCK_HAIRDRESS_SLIDER];
    }
    //相似度
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SIMILARITY_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SimilarityValue forKey:TI_UIDCK_SIMILARITY_SLIDER];
    }
    int Similarity =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_SIMILARITY_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER] forKey:TI_UIDCK_SIMILARITY_SLIDER withIndex:Similarity];
    //平滑度
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_SMOOTH_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:SmoothnessValue forKey:TI_UIDCK_SMOOTH_SLIDER];
    }
    int Smoothness =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_SMOOTH_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER] forKey:TI_UIDCK_SMOOTH_SLIDER withIndex:Smoothness];
    //透明度
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_HYALINE_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:AlphaValue forKey:TI_UIDCK_HYALINE_SLIDER];
    }
    int Alpha =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_HYALINE_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER] forKey:TI_UIDCK_HYALINE_SLIDER withIndex:Alpha];
    // 美妆 腮红
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_CheekRed_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:CheekRedValue forKey:TI_UIDCK_CheekRed_SLIDER];
    }
    int index1 =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_CheekRed_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_CheekRed_SLIDER] forKey:TI_UIDCK_CheekRed_SLIDER withIndex:index1];
    
    // 美妆 睫毛
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_Eyelash_SLIDER]) {
            [HLTiSetSDKParameters heliao_setFloatValue:EyelashValue forKey:TI_UIDCK_Eyelash_SLIDER];
               }
    int index2 =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyelash_SLIDER];

    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_Eyelash_SLIDER] forKey:TI_UIDCK_Eyelash_SLIDER withIndex:index2];

    // 美妆 眉毛
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_Eyebrows_SLIDER]) {
            [HLTiSetSDKParameters heliao_setFloatValue:EyebrowsValue forKey:TI_UIDCK_Eyebrows_SLIDER];
    }
    int index3 =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyebrows_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_Eyebrows_SLIDER] forKey:TI_UIDCK_Eyebrows_SLIDER withIndex:index3];
    
    // 美妆 眼影
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_Eyeshadow_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyeshadowValue forKey:TI_UIDCK_Eyeshadow_SLIDER];
    }
    int index4 =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyeshadow_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_Eyeshadow_SLIDER] forKey:TI_UIDCK_Eyeshadow_SLIDER withIndex:index4];
    // 美妆 眼线
    if (![HLTiSetSDKParameters heliao_judgeCacheValueIsNullForKey:TI_UIDCK_Eyeline_SLIDER]) {
        [HLTiSetSDKParameters heliao_setFloatValue:EyelineValue forKey:TI_UIDCK_Eyeline_SLIDER];
    }
    int index5 =  [HLTiSetSDKParameters heliao_getBeautyMakeupIndexForKey:TI_UIDCK_Eyeline_SLIDER];
    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_Eyeline_SLIDER] forKey:TI_UIDCK_Eyeline_SLIDER withIndex:index5];
    /**
     * 切换贴纸函数
     *
     * @param stickerName 贴纸名称
     */
    [[TiSDKManager shareManager] setStickerName:@""];
    
    /**
      * 切换互动贴纸函数
      *
      * @param stickerName 互动贴纸名称
      */
     [[TiSDKManager shareManager] setInteraction:@""];
    
    /**
     * 设置礼物特效参数函数
     *
     * @param giftName 礼物名称
     */
    [[TiSDKManager shareManager] setGift:@""];
    /**
     * 切换滤镜函数
     *
     * @param filterEnum 参考宏定义TiFilterEnum
     */
//    [[TiSDKManager shareManager] setFilterEnum:NO_FILTER Param:[HLTiSetSDKParameters getFloatValueForKey:TI_UIDCK_FILTER0_SLIDER]];
    
    [[TiSDKManager shareManager] setBeautyFilter:@"" Param:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_FILTER0_SLIDER]];
    
    /**
     * 设置Rock特效参数函数
     *
     * @param rockEnum 参考宏定义TiRockEnum
     */
    [[TiSDKManager shareManager] setRockEnum:NO_ROCK];
     /**
      * 设置哈哈镜特效参数函数
      *
      * @param distortionEnum 参考宏定义TiDistortionEnum
      */
    [[TiSDKManager shareManager] setDistortionEnum:NO_DISTORTION];
    
    /**
     * 设置水印参数函数
     *
     * @param enable  true: 开启 false: 关闭
     * @param x         水印左上角横坐标[0, 100]
     * @param y         水印右上角纵坐标[0, 100]
     * @param ratio    水印横向占据屏幕的比例[0, 100]
     */
//    [[TiSDKManager shareManager] setWatermark:NO Left:0 Top:0 Ratio:0 FileName:@""];
    
    /**
     * 设置面具特效参数函数
     *
     * @param maskName 面具名称
     */
    [[TiSDKManager shareManager] setMask:@""];
     
    
   /**
     * 设置绿幕特效参数函数
     *
     * @param greenScreenName 幕布名称
     */
    [[TiSDKManager shareManager] setGreenScreen:@""];
    /**
     * 切换美发函数
     *
     * @param hairEnum 参考宏定义TiHairEnum
     */
    [[TiSDKManager shareManager] setHairEnum:NO_HAIR Param:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HAIRDRESS_SLIDER]];
    
}

+ (void)heliao_setFloatValue:(float)value forKey:(TiUIDataCategoryKey)key {
    NSString *keyString = [self getTiUIDataCategoryKey:key];
    if (keyString.length == 0 || keyString == nil) {
        return;
    } else {
//        value = value<0.1?0.1:value;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setFloat:value forKey:keyString];
        [defaults setInteger:value forKey:keyString];
        [defaults synchronize];
    }
}

+ (float)heliao_getFloatValueForKey:(TiUIDataCategoryKey)key {
    NSString *heliao_keyString = [self getTiUIDataCategoryKey:key];
    if (heliao_keyString.length == 0 || heliao_keyString == nil) {
        return 0;
    } else {
        NSUserDefaults *heliao_defaults = [NSUserDefaults standardUserDefaults];
//        return [defaults floatForKey:keyString];
        return [heliao_defaults integerForKey:heliao_keyString];
    }
}

//判断缓存的值是否为空
+ (NSString *)heliao_judgeCacheValueIsNullForKey:(TiUIDataCategoryKey)key {
    
    NSString *heliao_keyString = [self getTiUIDataCategoryKey:key];
    if (heliao_keyString.length == 0 || heliao_keyString == nil) {
        return @"";
    } else {
        NSUserDefaults *heliao_defaults = [NSUserDefaults standardUserDefaults];
        NSString *heliao_isNull = [heliao_defaults stringForKey:heliao_keyString];
        return heliao_isNull;
    }
    
}

+ (void)setSelectPosition:(NSInteger)position forKey:(TiUIDataCategoryKey)key{
    
    NSString *heliao_keyString = [self getTiUIDataCategoryKey:key];
    if (heliao_keyString.length == 0 || heliao_keyString == nil) {
        return;
    } else {
        NSUserDefaults *heliao_positionDefaults = [NSUserDefaults standardUserDefaults];
        [heliao_positionDefaults setInteger:position forKey:heliao_keyString];
        [heliao_positionDefaults synchronize];
//        NSLog(@"选中位置存入:%ld",(long)[positionDefaults integerForKey:keyString]);
    }
    
}

+ (NSInteger)heliao_getSelectPositionForKey:(TiUIDataCategoryKey)key{
    NSString *heliao_keyString = [self getTiUIDataCategoryKey:key];
    if (heliao_keyString.length == 0 || heliao_keyString == nil) {
        return 0;
    } else {
        NSUserDefaults *heliao_positionDefaults = [NSUserDefaults standardUserDefaults];
//        NSLog(@"选中位置获取:%ld",(long)[positionDefaults integerForKey:keyString]);
        return [heliao_positionDefaults integerForKey:heliao_keyString];
    }
}

// 保存选中美妆的坐标
+ (void)heliao_setBeautyMakeupIndex:(int)index forKey:(TiUIDataCategoryKey)key{
    NSString *heliao_keyString =  [NSString stringWithFormat:@"%@_index",[self getTiUIDataCategoryKey:key]];
      if (heliao_keyString.length == 0 || heliao_keyString == nil) {
          return;
      } else {
          NSUserDefaults *heliao_defaults = [NSUserDefaults standardUserDefaults];
          [heliao_defaults setInteger:index forKey:heliao_keyString];
          [heliao_defaults synchronize];
      }
}

 // 获取选中美妆的坐标
+ (int)heliao_getBeautyMakeupIndexForKey:(TiUIDataCategoryKey)key{
    NSString *heliao_keyString = [NSString stringWithFormat:@"%@_index",[self getTiUIDataCategoryKey:key]];
       if (heliao_keyString.length == 0 || heliao_keyString == nil) {
           return 0;
       } else {
           NSUserDefaults *heliao_defaults = [NSUserDefaults standardUserDefaults];
           return (int)[heliao_defaults integerForKey:heliao_keyString];
       }
}

+ (NSString *)getTiUIDataCategoryKey:(TiUIDataCategoryKey)key {
    switch (key) {
//            美颜
        case TI_UIDCK_SKIN_WHITENING_SLIDER://美白
            return @"TI_UIDCK_SKIN_WHITENING_SLIDER";
            break;
        case TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER://磨皮
            return @"TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER";
            break;
        case TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER://精准美肤
            return @"TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER";
            break;
        case TI_UIDCK_SKIN_TENDERNESS_SLIDER://粉嫩
            return @"TI_UIDCK_SKIN_TENDERNESS_SLIDER";
            break;
        case TI_UIDCK_SKIN_SKINBRIGGT_SLIDER://清晰
            return @"TI_UIDCK_SKIN_SKINBRIGGT_SLIDER";
            break;
        case TI_UIDCK_SKIN_BRIGHTNESS_SLIDER://亮度
            return @"TI_UIDCK_SKIN_BRIGHTNESS_SLIDER";
            break;
//            美型
        case TI_UIDCK_EYEMAGNIFYING_SLIDER:// 大眼
            return @"TI_UIDCK_EYEMAGNIFYING_SLIDER";
            break;
        case TI_UIDCK_CHINSLIMMING_SLIDER:// 瘦脸
            return @"TI_UIDCK_CHINSLIMMING_SLIDER";
            break;
        case TI_UIDCK_FACENARROWING_SLIDER:// 窄脸
            return @"TI_UIDCK_FACENARROWING_SLIDER";
            break;
        case TI_UIDCK_CHEEKBONESLIMMING_SLIDER:// 瘦颧骨
            return @"TI_UIDCK_CHEEKBONESLIMMING_SLIDER";
            break;
        case TI_UIDCK_JAWBONESLIMMING_SLIDER:// 瘦下颌
            return @"TI_UIDCK_JAWBONESLIMMING_SLIDER";
            break;
        case TI_UIDCK_JAWTRANSFORMING_SLIDER:// 下巴
            return @"TI_UIDCK_JAWTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_JAWSLIMMING_SLIDER:// 削下巴
            return @"TI_UIDCK_JAWSLIMMING_SLIDER";
            break;
        case TI_UIDCK_FOREHEADTRANSFORMING_SLIDER:// 额头
            return @"TI_UIDCK_FOREHEADTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_EYEINNERCORNERS_SLIDER:// 内眼角
            return @"TI_UIDCK_EYEINNERCORNERS_SLIDER";
            break;
        case TI_UIDCK_EYEOUTERCORNERS_SLIDER://外眼尾
            return @"TI_UIDCK_EYEOUTERCORNERS_SLIDER";
            break;
        case TI_UIDCK_EYESPACING_SLIDER:// 眼间距
            return @"TI_UIDCK_EYESPACING_SLIDER";
            break;
        case TI_UIDCK_EYECORNERS_SLIDER:// 眼角
            return @"TI_UIDCK_EYECORNERS_SLIDER";
            break;
        case TI_UIDCK_NOSEMINIFYING_SLIDER:// 瘦鼻
            return @"TI_UIDCK_NOSEMINIFYING_SLIDER";
            break;
        case TI_UIDCK_NOSEELONGATING_SLIDER:// 长鼻
            return @"TI_UIDCK_NOSEELONGATING_SLIDER";
            break;
        case TI_UIDCK_MOUTHTRANSFORMING_SLIDER://嘴型
            return @"TI_UIDCK_MOUTHTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_MOUTHHEIGHT_SLIDER:// 嘴高低
            return @"TI_UIDCK_MOUTHHEIGHT_SLIDER";
            break;
        case TI_UIDCK_MOUTHLIPSIZE_SLIDER:// 唇厚薄
            return @"TI_UIDCK_MOUTHLIPSIZE_SLIDER";
            break;
        case TI_UIDCK_MOUTHSMILING_SLIDER:// 扬嘴角
            return @"TI_UIDCK_MOUTHSMILING_SLIDER";
            break;
        case TI_UIDCK_BROWHEIGHT_SLIDER:// 眉高低
            return @"TI_UIDCK_BROWHEIGHT_SLIDER";
            break;
        case TI_UIDCK_BROWLENGTH_SLIDER:// 眉长短
            return @"TI_UIDCK_BROWLENGTH_SLIDER";
            break;
        case TI_UIDCK_BROWSPACE_SLIDER:// 眉间距
            return @"TI_UIDCK_BROWSPACE_SLIDER";
            break;
        case TI_UIDCK_BROWSIZE_SLIDER:// 眉粗细
            return @"TI_UIDCK_BROWSIZE_SLIDER";
            break;
        case TI_UIDCK_BROWCORNER_SLIDER:// 提眉峰
            return @"TI_UIDCK_BROWCORNER_SLIDER";
            break;
//            滤镜
        case TI_UIDCK_FILTER0_SLIDER:
            return @"TI_UIDCK_FILTER0_SLIDER";
            break;
        case TI_UIDCK_FILTER1_SLIDER:
            return @"TI_UIDCK_FILTER1_SLIDER";
            break;
        case TI_UIDCK_FILTER2_SLIDER:
            return @"TI_UIDCK_FILTER2_SLIDER";
            break;
        case TI_UIDCK_FILTER3_SLIDER:
            return @"TI_UIDCK_FILTER3_SLIDER";
            break;
        case TI_UIDCK_FILTER4_SLIDER:
            return @"TI_UIDCK_FILTER4_SLIDER";
            break;
        case TI_UIDCK_FILTER5_SLIDER:
            return @"TI_UIDCK_FILTER5_SLIDER";
            break;
        case TI_UIDCK_FILTER6_SLIDER:
            return @"TI_UIDCK_FILTER6_SLIDER";
            break;
        case TI_UIDCK_FILTER7_SLIDER:
            return @"TI_UIDCK_FILTER7_SLIDER";
            break;
        case TI_UIDCK_FILTER8_SLIDER:
            return @"TI_UIDCK_FILTER8_SLIDER";
            break;
        case TI_UIDCK_FILTER9_SLIDER:
            return @"TI_UIDCK_FILTER9_SLIDER";
            break;
        case TI_UIDCK_FILTER10_SLIDER:
            return @"TI_UIDCK_FILTER10_SLIDER";
            break;
        case TI_UIDCK_FILTER11_SLIDER:
            return @"TI_UIDCK_FILTER11_SLIDER";
            break;
        case TI_UIDCK_FILTER12_SLIDER:
            return @"TI_UIDCK_FILTER12_SLIDER";
            break;
        case TI_UIDCK_FILTER13_SLIDER:
            return @"TI_UIDCK_FILTER13_SLIDER";
            break;
        case TI_UIDCK_FILTER14_SLIDER:
            return @"TI_UIDCK_FILTER14_SLIDER";
            break;
        case TI_UIDCK_FILTER15_SLIDER:
            return @"TI_UIDCK_FILTER15_SLIDER";
            break;
        case TI_UIDCK_FILTER16_SLIDER:
            return @"TI_UIDCK_FILTER16_SLIDER";
            break;
        case TI_UIDCK_FILTER17_SLIDER:
            return @"TI_UIDCK_FILTER17_SLIDER";
            break;
        case TI_UIDCK_FILTER18_SLIDER:
            return @"TI_UIDCK_FILTER18_SLIDER";
            break;
        case TI_UIDCK_FILTER19_SLIDER:
            return @"TI_UIDCK_FILTER19_SLIDER";
            break;
        case TI_UIDCK_FILTER20_SLIDER:
            return @"TI_UIDCK_FILTER20_SLIDER";
            break;
        case TI_UIDCK_FILTER21_SLIDER:
            return @"TI_UIDCK_FILTER21_SLIDER";
            break;
        case TI_UIDCK_FILTER22_SLIDER:
            return @"TI_UIDCK_FILTER22_SLIDER";
            break;
        case TI_UIDCK_FILTER23_SLIDER:
            return @"TI_UIDCK_FILTER23_SLIDER";
            break;
        case TI_UIDCK_FILTER24_SLIDER:
            return @"TI_UIDCK_FILTER24_SLIDER";
            break;
        case TI_UIDCK_FILTER25_SLIDER:
            return @"TI_UIDCK_FILTER25_SLIDER";
            break;
        case TI_UIDCK_FILTER26_SLIDER:
            return @"TI_UIDCK_FILTER26_SLIDER";
            break;
        case TI_UIDCK_FILTER27_SLIDER:
            return @"TI_UIDCK_FILTER27_SLIDER";
            break;
        case TI_UIDCK_FILTER28_SLIDER:
            return @"TI_UIDCK_FILTER28_SLIDER";
            break;
        case TI_UIDCK_FILTER29_SLIDER:
            return @"TI_UIDCK_FILTER29_SLIDER";
            break;
        case TI_UIDCK_FILTER30_SLIDER:
            return @"TI_UIDCK_FILTER30_SLIDER";
            break;
        case TI_UIDCK_FILTER31_SLIDER:
            return @"TI_UIDCK_FILTER31_SLIDER";
            break;
        case TI_UIDCK_FILTER32_SLIDER:
            return @"TI_UIDCK_FILTER32_SLIDER";
            break;
        case TI_UIDCK_FILTER33_SLIDER:
            return @"TI_UIDCK_FILTER33_SLIDER";
            break;
        case TI_UIDCK_FILTER34_SLIDER:
            return @"TI_UIDCK_FILTER34_SLIDER";
            break;
        case TI_UIDCK_FILTER35_SLIDER:
            return @"TI_UIDCK_FILTER35_SLIDER";
            break;
        case TI_UIDCK_FILTER36_SLIDER:
            return @"TI_UIDCK_FILTER36_SLIDER";
            break;
        case TI_UIDCK_FILTER37_SLIDER:
            return @"TI_UIDCK_FILTER37_SLIDER";
            break;
        case TI_UIDCK_FILTER38_SLIDER:
            return @"TI_UIDCK_FILTER38_SLIDER";
            break;
        case TI_UIDCK_FILTER39_SLIDER:
            return @"TI_UIDCK_FILTER39_SLIDER";
            break;
        case TI_UIDCK_FILTER40_SLIDER:
            return @"TI_UIDCK_FILTER40_SLIDER";
            break;
        case TI_UIDCK_FILTER41_SLIDER:
            return @"TI_UIDCK_FILTER41_SLIDER";
            break;
        case TI_UIDCK_FILTER42_SLIDER:
            return @"TI_UIDCK_FILTER42_SLIDER";
            break;
        case TI_UIDCK_FILTER43_SLIDER:
            return @"TI_UIDCK_FILTER43_SLIDER";
            break;
        case TI_UIDCK_FILTER44_SLIDER:
            return @"TI_UIDCK_FILTER44_SLIDER";
            break;
        case TI_UIDCK_FILTER45_SLIDER:
            return @"TI_UIDCK_FILTER45_SLIDER";
            break;
        case TI_UIDCK_FILTER46_SLIDER:
            return @"TI_UIDCK_FILTER46_SLIDER";
            break;
//            滤镜位置
        case TI_UIDCK_FILTER_POSITION:
            return @"TiUIDCKFilterPosition";
            break;
//            美发
        case TI_UIDCK_HAIRDRESS_SLIDER://15
            return @"TiUIDCKHairSlider";
            break;
//            一键美颜
        case TI_UIDCK_ONEKEY_SLIDER:
            return @"TiUIDCKOneKeySlider";
            break;
//            一键美颜位置
        case TI_UIDCK_ONEKEY_POSITION:
            return @"TiUIDCKOneKeyPosition";
            break;
            //相似度
        case TI_UIDCK_SIMILARITY_SLIDER:
            return @"TI_UIDCK_SIMILARITY_SLIDER";
            break;
            //平滑度
        case TI_UIDCK_SMOOTH_SLIDER:
            return @"TI_UIDCK_SMOOTH_SLIDER";
            break;
            //透明度
        case TI_UIDCK_HYALINE_SLIDER:
            return @"TI_UIDCK_HYALINE_SLIDER";
            break;
//            TI_UIDCK_CheekRed_SLIDER = 1000, //  腮红
        case TI_UIDCK_CheekRed_SLIDER:
            return @"TI_UIDCK_CheekRed_SLIDER";
            break;
//            TI_UIDCK_Eyelash_SLIDER = 2000, // 睫毛
        case TI_UIDCK_Eyelash_SLIDER:
            return @"TI_UIDCK_Eyelash_SLIDER";
            break;
//            TI_UIDCK_Eyebrows_SLIDER = 3000, // 眉毛
        case TI_UIDCK_Eyebrows_SLIDER:
            return @"TI_UIDCK_Eyebrows_SLIDER";
            break;
        case TI_UIDCK_Eyeshadow_SLIDER:
            return @"TI_UIDCK_Eyeshadow_SLIDER";
            break;
        case TI_UIDCK_Eyeline_SLIDER:
            return @"TI_UIDCK_Eyeline_SLIDER";
            break;
//            脸型
        case TI_UIDCK_FACESHAPE_SLIDER:
            return @"TI_UIDCK_FACESHAPE_SLIDER";
            break;
        default:
            return @"";
            break;
    }
}

+ (void)heliao_setTotalEnable:(BOOL)enable toIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
    [[TiSDKManager shareManager] setBeautyEnable:enable];
            break;
        case 1:
    [[TiSDKManager shareManager] setFaceTrimEnable:enable];
            break;
            
        default:
            break;
    }
     
}

+ (void)heliao_updateSlider{
    
}

+ (void)heliao_setBeautySlider:(float)v forKey:(TiUIDataCategoryKey)key withIndex:(NSInteger)index{
    
    TIMenuMode *hairMods;
    
    switch (key) {
        case TI_UIDCK_SKIN_WHITENING_SLIDER:
            //美白
            [[TiSDKManager shareManager] setSkinWhitening:v];
            break;
        case TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER:
            //磨皮
            [[TiSDKManager shareManager] setSkinBlemishRemoval:v];
            break;
        case TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER:
            //精准美肤
            [[TiSDKManager shareManager] setSkinPreciseBeauty:v];
            break;
        case TI_UIDCK_SKIN_TENDERNESS_SLIDER:
            //粉嫩
            [[TiSDKManager shareManager] setSkinTenderness:v];
            break;
            //清晰
        case TI_UIDCK_SKIN_SKINBRIGGT_SLIDER:
            [[TiSDKManager shareManager] setSkinSharpness:v];
            break;
        case TI_UIDCK_SKIN_BRIGHTNESS_SLIDER:
            //亮度
            [[TiSDKManager shareManager] setSkinBrightness:v];
            break;
            //美型
        case TI_UIDCK_EYEMAGNIFYING_SLIDER:
            //大眼
            [[TiSDKManager shareManager] setEyeMagnifying:v];
            break;
        case TI_UIDCK_CHINSLIMMING_SLIDER:
            //瘦脸
            [[TiSDKManager shareManager] setChinSlimming:v];
            break;
        case TI_UIDCK_FACENARROWING_SLIDER:
            //窄脸
            [[TiSDKManager shareManager] setFaceNarrowing:v];
            break;
        case TI_UIDCK_CHEEKBONESLIMMING_SLIDER:
            //瘦颧骨
            [[TiSDKManager shareManager] setCheekboneSlimming:v];
            break;
        case TI_UIDCK_JAWBONESLIMMING_SLIDER:
            //瘦下颌
            [[TiSDKManager shareManager] setJawboneSlimming:v];
            break;
        case TI_UIDCK_JAWTRANSFORMING_SLIDER:
            //下巴
            [[TiSDKManager shareManager] setJawTransforming:v];
            break;
        case TI_UIDCK_JAWSLIMMING_SLIDER:
            //削下巴
            [[TiSDKManager shareManager] setJawSlimming:v];
            break;
        case TI_UIDCK_FOREHEADTRANSFORMING_SLIDER:
            //额头
            [[TiSDKManager shareManager] setForeheadTransforming:v];
            break;
        case TI_UIDCK_EYEINNERCORNERS_SLIDER:
            //内眼角
            [[TiSDKManager shareManager] setEyeInnerCorners:v];
            break;
        case TI_UIDCK_EYEOUTERCORNERS_SLIDER:
            //外眼尾
            [[TiSDKManager shareManager] setEyeOuterCorners:v];
            break;
        case TI_UIDCK_EYESPACING_SLIDER:
            //眼间距
            [[TiSDKManager shareManager] setEyeSpacing:v];
            break;
        case TI_UIDCK_EYECORNERS_SLIDER:
            //眼角
            [[TiSDKManager shareManager] setEyeCorners:v];
            break;
        case TI_UIDCK_NOSEMINIFYING_SLIDER:
            //瘦鼻
            [[TiSDKManager shareManager] setNoseMinifying:-v];
            break;
        case TI_UIDCK_NOSEELONGATING_SLIDER:
            //长鼻
            [[TiSDKManager shareManager] setNoseElongating:v];
            break;
        case TI_UIDCK_MOUTHTRANSFORMING_SLIDER:
            //嘴型
            [[TiSDKManager shareManager] setMouthTransforming:v];
            break;
        case TI_UIDCK_MOUTHHEIGHT_SLIDER:
            //嘴高低
            [[TiSDKManager shareManager] setMouthHeight:v];
            break;
        case TI_UIDCK_MOUTHLIPSIZE_SLIDER:
            //唇厚薄
            [[TiSDKManager shareManager] setMouthLipSize:v];
            break;
        case TI_UIDCK_MOUTHSMILING_SLIDER:
            //扬嘴角
            [[TiSDKManager shareManager] setMouthSmiling:v];
            break;
        case TI_UIDCK_BROWHEIGHT_SLIDER:
            //眉高低
            [[TiSDKManager shareManager] setBrowHeight:v];
            break;
        case TI_UIDCK_BROWLENGTH_SLIDER:
            //眉长短
            [[TiSDKManager shareManager] setBrowLength:v];
            break;
        case TI_UIDCK_BROWSPACE_SLIDER:
            //眉间距
            [[TiSDKManager shareManager] setBrowSpace:v];
            break;
        case TI_UIDCK_BROWSIZE_SLIDER:
            //眉粗细
            [[TiSDKManager shareManager] setBrowSize:v];
            break;
        case TI_UIDCK_BROWCORNER_SLIDER:
            //提眉峰
            [[TiSDKManager shareManager] setBrowCorner:v];
            break;
            
        case TI_UIDCK_FILTER0_SLIDER:
        case TI_UIDCK_FILTER1_SLIDER:
        case TI_UIDCK_FILTER2_SLIDER:
        case TI_UIDCK_FILTER3_SLIDER:
        case TI_UIDCK_FILTER4_SLIDER:
        case TI_UIDCK_FILTER5_SLIDER:
        case TI_UIDCK_FILTER6_SLIDER:
        case TI_UIDCK_FILTER7_SLIDER:
        case TI_UIDCK_FILTER8_SLIDER:
        case TI_UIDCK_FILTER9_SLIDER:
        case TI_UIDCK_FILTER10_SLIDER:
        case TI_UIDCK_FILTER11_SLIDER:
        case TI_UIDCK_FILTER12_SLIDER:
        case TI_UIDCK_FILTER13_SLIDER:
        case TI_UIDCK_FILTER14_SLIDER:
        case TI_UIDCK_FILTER15_SLIDER:
        case TI_UIDCK_FILTER16_SLIDER:
        case TI_UIDCK_FILTER17_SLIDER:
        case TI_UIDCK_FILTER18_SLIDER:
        case TI_UIDCK_FILTER19_SLIDER:
        case TI_UIDCK_FILTER20_SLIDER:
        case TI_UIDCK_FILTER21_SLIDER:
        case TI_UIDCK_FILTER22_SLIDER:
        case TI_UIDCK_FILTER23_SLIDER:
        case TI_UIDCK_FILTER24_SLIDER:
        case TI_UIDCK_FILTER25_SLIDER:
        case TI_UIDCK_FILTER26_SLIDER:
        case TI_UIDCK_FILTER27_SLIDER:
        case TI_UIDCK_FILTER28_SLIDER:
        case TI_UIDCK_FILTER29_SLIDER:
        case TI_UIDCK_FILTER30_SLIDER:
        case TI_UIDCK_FILTER31_SLIDER:
        case TI_UIDCK_FILTER32_SLIDER:
        case TI_UIDCK_FILTER33_SLIDER:
        case TI_UIDCK_FILTER34_SLIDER:
        case TI_UIDCK_FILTER35_SLIDER:
        case TI_UIDCK_FILTER36_SLIDER:
        case TI_UIDCK_FILTER37_SLIDER:
        case TI_UIDCK_FILTER38_SLIDER:
        case TI_UIDCK_FILTER39_SLIDER:
        case TI_UIDCK_FILTER40_SLIDER:
        case TI_UIDCK_FILTER41_SLIDER:
        case TI_UIDCK_FILTER42_SLIDER:
        case TI_UIDCK_FILTER43_SLIDER:
        case TI_UIDCK_FILTER44_SLIDER:
        case TI_UIDCK_FILTER45_SLIDER:
        case TI_UIDCK_FILTER46_SLIDER:
            if(is_updateFilter){
                //调整滤镜位置——发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuTwo_UpdateFilter" object:@(index)];
            }else if (is_updateFilterValue){
                //调整滤镜滑动条参数
                TIMenuMode *filterMod = [HLTiMenuPlistManager shareManager].heliao_filterModeArr[index];
                [[TiSDKManager shareManager] setBeautyFilter:filterMod.effectName Param:v];
            }else{
                for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_filterModeArr) {
                    if (mod.menuTag == index) {
                        [[TiSDKManager shareManager] setBeautyFilter:mod.effectName Param:v];
                    }
                }
            }
            break;
        case TI_UIDCK_ONEKEY_SLIDER:
            //一键美颜
            [HLTiSetSDKParameters heliao_setOneKeyBeautySlider:v Index:index];
            break;
        case TI_UIDCK_FACESHAPE_SLIDER:
            //脸型
            [HLTiSetSDKParameters heliao_setFaceShapeBeautySlider:v Index:index];
            break;
            //相似度
        case TI_UIDCK_SIMILARITY_SLIDER:
            [[TiSDKManager shareManager] setGreenScreen:@"绿幕抠图" Similarity:v Smoothness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER] Alpha:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];
            break;
            //平滑度
        case TI_UIDCK_SMOOTH_SLIDER:
            [[TiSDKManager shareManager] setGreenScreen:@"绿幕抠图" Similarity:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER] Smoothness:v Alpha:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];
            break;
            //透明度
        case TI_UIDCK_HYALINE_SLIDER:
            [[TiSDKManager shareManager] setGreenScreen:@"绿幕抠图" Similarity:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER] Smoothness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER] Alpha:v];
            break;
            //腮红
        case TI_UIDCK_CheekRed_SLIDER:
            [[TiSDKManager shareManager] setBlusher:[HLTiSetSDKParameters heliao_setMakeupByIndex:index] Param:v];
            break;
            //睫毛
        case TI_UIDCK_Eyelash_SLIDER:
            [[TiSDKManager shareManager] setEyeLash:[HLTiSetSDKParameters heliao_setMakeupByIndex:index] Param:v];
            break;
            //眉毛
        case TI_UIDCK_Eyebrows_SLIDER:
            [[TiSDKManager shareManager] setEyeBrow:[HLTiSetSDKParameters heliao_setMakeupByIndex:index] Param:v];
            break;
            //眼影
        case TI_UIDCK_Eyeshadow_SLIDER:
            [[TiSDKManager shareManager] setEyeShadow:[HLTiSetSDKParameters heliao_setMakeupByIndex:index] Param:v];
            break;
            //眼线
        case TI_UIDCK_Eyeline_SLIDER:
            [[TiSDKManager shareManager] setEyeLine:[HLTiSetSDKParameters heliao_setMakeupByIndex:index] Param:v];
            break;
        case TI_UIDCK_HAIRDRESS_SLIDER:
            //美发
            hairMods = [HLTiMenuPlistManager shareManager].heliao_hairdressModArr[index];
            [[TiSDKManager shareManager] setHairEnum:[HLTiSetSDKParameters heliao_getTiHairEnumForIndex:hairMods.menuTag] Param:v];
            break;
        default:
            break;
            
    }
    
}

+ (void)heliao_setOneKeyBeautySlider:(float)v Index:(NSInteger)index{
    
    //设置一键美颜效果
    [[TiSDKManager shareManager] setOnekeyBeauty:index Param:v];
    
    CGFloat a = v/100;
    NSDictionary *onekeyParameter = [[HLTiMenuPlistManager shareManager].heliao_onekeyParameter objectAtIndex:index];
    //将一键美颜对应的参数储存本地——美颜
    for (int beauty = 0; beauty < 5; beauty ++) {
        CGFloat value1 = [[onekeyParameter objectForKey:[HLTiSetSDKParameters getTiUIDataCategoryKey:100+beauty]] floatValue];
        [HLTiSetSDKParameters heliao_setFloatValue:value1  * a forKey:100+beauty];
    }
    //将一键美颜对应的参数储存本地——美型
    for (int facetrim = 0; facetrim < 23; facetrim ++) {
        CGFloat value2 = [[onekeyParameter objectForKey:[HLTiSetSDKParameters getTiUIDataCategoryKey:200+facetrim]] floatValue];
        [HLTiSetSDKParameters heliao_setFloatValue:value2  * a forKey:200+facetrim];
    }
    //将一键美颜对应的参数储存本地——滤镜
    NSInteger filterId = [[onekeyParameter objectForKey:@"TiFilterIndex"] intValue];
    TIMenuMode *filterMod = [HLTiMenuPlistManager shareManager].heliao_filterModeArr[filterId];
    CGFloat valueFilter = [[onekeyParameter objectForKey:[HLTiSetSDKParameters getTiUIDataCategoryKey:300+filterMod.menuTag]] floatValue];
    [HLTiSetSDKParameters heliao_setFloatValue:valueFilter  * a forKey:300+filterMod.menuTag];//将一键美颜的参数储存本地
    [HLTiSetSDKParameters heliao_setBeautySlider:valueFilter * a forKey:300+filterMod.menuTag withIndex:[[onekeyParameter objectForKey:@"TiFilterIndex"] intValue]];
    
}

+ (void)heliao_setFaceShapeBeautySlider:(float)v Index:(NSInteger)index{
    
    //设置脸型效果
    [[TiSDKManager shareManager] setFaceShape:index Param:v];
    
    CGFloat a = v/100;
    NSDictionary *FaceShapeParameter = [[HLTiMenuPlistManager shareManager].heliao_faceshapeParameter objectAtIndex:index];
    
    //将脸型对应的参数储存本地——美型
    for (int facetrim = 0; facetrim < 23; facetrim ++) {
        CGFloat valueF = [[FaceShapeParameter objectForKey:[HLTiSetSDKParameters getTiUIDataCategoryKey:200+facetrim]] floatValue];
        [HLTiSetSDKParameters heliao_setFloatValue:valueF  * a forKey:200+facetrim];
    }
    
}

+ (TiFilterEnum)heliao_getTiFilterEnumForIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return NO_FILTER; // 无
            break;
        case 50:
            return SKETCH_FILTER; // 1素描
            break;
        case 49:
            return SOBELEDGE_FILTER; // 2黑边
            break;
        case 48:
            return TOON_FILTER; // 3卡通
            break;
        case 47:
            return EMBOSS_FILTER; // 4浮雕
            break;
        case 36:
            return FILM_FILTER; // 5胶片
            break;
        case 46:
            return PIXELLATION_FILTER; // 6马赛克
            break;
        case 45:
            return HALFTONE_FILTER; // 7半色调
            break;
        case 44:
            return CROSSHATCH_FILTER; // 8交叉边
            break;
        case 12:
            return KISS_FILTER; // 19初吻
            break;
        case 27:
            return COFFEE_FILTER; // 10咖啡
            break;
        case 14:
            return CHOCOLATE_FILTER; // 11巧克力
            break;
        case 28:
            return COCO_FILTER; // 12可可
            break;
        case 29:
            return DELICIOUS_FILTER; // 13美味
            break;
        case 17:
            return FIRSTLOVE_FILTER; // 14初恋
            break;
        case 16:
            return FOREST_FILTER; // 15森林
            break;
        case 25:
            return GLOSSY_FILTER; // 16光泽
            break;
        case 18:
            return GRASS_FILTER; // 17禾草
            break;
        case 19:
            return HOLIDAY_FILTER; // 18假日
            break;
        case 11:
            return LOLITA_FILTER; // 20洛丽塔
            break;
        case 10:
            return RED_FILTER; // 26赤红
            break;
        case 32:
            return MEMORY_FILTER; // 21回忆
            break;
        case 30:
            return MOUSSE_FILTER; // 22慕斯
            break;
        case 13:
            return NASHVILLE_FILTER; // 9那舍尔
            break;
        case 15:
            return OXGEN_FILTER; // 24氧气
            break;
        case 23:
            return PLATYCODON_FILTER; // 25桔梗
            break;
        case 9:
            return VIGNETTE_FILTER; // 32光晕
            break;
        case 31:
            return SUNLESS_FILTER; // 27冷日
            break;
        case 43:
            return PINCH_DISTORTION_FILTER; // 28扭曲
            break;
        case 33:
            return KUWAHARA_FILTER; // 29油画
            break;
        case 35:
            return POSTERIZE_FILTER; // 30分色
            break;
        case 42:
            return SWIRL_DISTORTION_FILTER; // 31漩涡
            break;
        case 8:
            return AZREAL_FILTER; // 41素肌
            break;
        case 41:
            return ZOOM_BLUR_FILTER; // 33眩晕
            break;
        case 40:
            return POLKA_DOT_FILTER; // 34圆点
            break;
        case 39:
            return POLAR_PIXELLATE_FILTER; // 35极坐标
            break;
        case 38:
            return GLASS_SPHERE_REFRACTION_FILTER; // 36水晶球
            break;
        case 37:
            return SOLARIZE_FILTER; // 37曝光
            break;
        case 34:
            return INK_WASH_PAINTING_FILTER; // 38水墨
            break;
        case 26:
            return ARABICA_FILTER; // 39阿拉比卡
            break;
        case 22:
            return AVA_FILTER; // 40阿瓦
            break;
        case 7:
            return BYERS_FILTER; // 43拜尔斯
            break;
        case 21:
            return BOURBON_FILTER; // 42波旁
            break;
        case 6:
            return FUJI_REALA_FILTER; // 90真实
            break;
        case 5:
            return CHEMICAL_FILTER; // 44化学
            break;
        case 20:
            return CLAYTON_FILTER; // 45克莱顿
            break;
        case 2:
            return CLOUSEAU_FILTER; // 46克卢索
            break;
        case 4:
            return COBI_FILTER; // 47小新
            break;
        case 3:
            return CONTRAIL_FILTER; // 48凝迹
            break;
        case 24:
            return CUBICLE_FILTER; // 49隔间
            break;
        case 1:
            return DJANGO_FILTER; // 50姜戈
            break;
        default:
            return NO_FILTER;
            break;
    }
}

+ (TiRockEnum)heliao_setRockEnumByIndex:(NSInteger)index{
    
    switch(index) {
        case 0:
            return NO_ROCK;
            break;
        case 1:
            return DAZZLED_COLOR_ROCK;
            break;
        case 2:
            return LIGHT_COLOR_ROCK;
            break;
        case 3:
            return DIZZY_GIDDY_ROCK;
            break;
        case 4:
            return ASTRAL_PROJECTION_ROCK;
            break;
        case 5:
            return BLACK_MAGIC_ROCK;
            break;
        case 6:
            return VIRTUAL_MIRROR_ROCK;
            break;
        case 7:
            return DYNAMIC_SPLIT_SCREEN_ROCK;
            break;
        case 8:
            return BLACK_WHITE_FILM_ROCK;
            break;
        case 9:
            return GRAY_PETRIFACTION_ROCK; // 瞬间石化
            break;
        case 10:
            return BULGE_DISTORTION__ROCK; // 魔法镜面
            break;
        default:
            return NO_ROCK;
            break;
    }
    
}

+ (TiDistortionEnum)heliao_setDistortionEnumByIndex:(NSInteger)index {
    
    switch(index) {
        case 0:
            return NO_DISTORTION;
            break;
        case 1:
            return ET_DISTORTION;
            break;
        case 2:
            return PEAR_FACE_DISTORTION;
            break;
        case 3:
            return SLIM_FACE_DISTORTION;
            break;
        case 4:
            return SQUARE_FACE_DISTORTION;
            break;
        default:
            return NO_DISTORTION;
            break;
    }
    
}


+ (NSString *)heliao_setMakeupByIndex:(NSInteger)index {
    
    switch(index) {
        case 1000:
            return @"qingse";
            break;
        case 1001:
            return @"riza";
            break;
        case 1002:
            return @"tiancheng";
            break;
        case 1003:
            return @"youya";
            break;
        case 1004:
            return @"weixun";
            break;
        case 1005:
            return @"xindong";
            break;
        case 2000:
            return @"ziran";
            break;
        case 2001:
            return @"rouhe";
            break;
        case 2002:
            return @"nongmi";
            break;
        case 2003:
            return @"meihuo";
            break;
        case 2004:
            return @"babi";
            break;
        case 2005:
            return @"wumei";
            break;
        case 3000:
            return @"biaozhunmei";
            break;
        case 3001:
            return @"jianmei";
            break;
        case 3002:
            return @"liuyemei";
            break;
        case 3003:
            return @"pingzhimei";
            break;
        case 3004:
            return @"liuxingmei";
            break;
        case 3005:
            return @"oushimei";
            break;
        case 4000:
            return @"dadi";
            break;
        case 4001:
            return @"nvtuan";
            break;
        case 4002:
            return @"summer";
            break;
        case 4003:
            return @"taohua";
            break;
        case 4004:
            return @"yanxunzhuang";
            break;
        case 4005:
            return @"yuanqi";
            break;
        case 5000:
            return @"suyan";
            break;
        case 5001:
            return @"rouhua";
            break;
        case 5002:
            return @"shensui";
            break;
        case 5003:
            return @"meihei";
            break;
        case 5004:
            return @"gexing";
            break;
        case 5005:
            return @"wugu";
            break;
        case 5006:
            return @"qingqiao";
            break;
        default:
            return @"";
            break;
    }
    
}

+ (TiHairEnum)heliao_getTiHairEnumForIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
            return NO_HAIR; //原图
            break;
        case 1:
            return MY_PURPLE_HAIR;// 1神秘紫
            break;
        case 2:
            return CHOCOLATE_HAIR; // 2巧克力
            break;
        case 3:
            return VINTAGE_ROSE_HAIR; // 11复古玫瑰
            break;
        case 4:
            return TENDER_ROSE_HAIR; // 12深玫瑰
            break;
        case 5:
            return FROG_TARO_HAIR; // 15雾霾香芋
            break;
        case 6:
            return PEACOCK_BLUE_HAIR; // 16孔雀蓝
            break;
        case 7:
            return FB_GRAY_HAIR; // 17雾霾蓝灰
            break;
        default:
            return NO_HAIR;
            break;
    }
    
}


- (void)heliao_checkInfo {
    NSLog(@"Continue");
}
@end
