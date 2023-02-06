//
//  HLTiUISubMenuThreeViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUISubMenuThreeViewCell.h"
#import "HLTiUITool.h"

@interface HLTiUISubMenuThreeViewCell ()

@property(nonatomic ,strong)HLTiButton *heliao_cellButton;

@end

@implementation HLTiUISubMenuThreeViewCell


- (HLTiButton *)heliao_cellButton{
    if (!_heliao_cellButton) {
        _heliao_cellButton = [[HLTiButton alloc] initWithScaling:1.0];
        _heliao_cellButton.userInteractionEnabled = NO;
    }
    return _heliao_cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.heliao_cellButton];
        [self.heliao_cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
    }
    return self;
}

//判断是否可编辑
- (BOOL)heliao_isEdit{
    if (self.heliao_cellButton.isEnabled) {
        return YES;
    }else{
        return NO;
    }
}

//编辑绿幕
- (void)heliao_setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag isEnabled:(BOOL)isEnabled{
    
    if (subMod.menuTag == 99 && tag == 9) {
        [self.heliao_cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(17, 17, 17, 17));
        }];
        [self.heliao_cellButton setImage:[UIImage imageNamed:@"icon_lvmu_bianji.png"] forState:UIControlStateNormal];
        [self.heliao_cellButton setImage:[UIImage imageNamed:@"icon_lvmu_bianji_disabled.png"] forState:UIControlStateDisabled];
        [self heliao_endAnimation];
        [self.heliao_cellButton heliao_setDownloaded:YES];
        [self.heliao_cellButton setEnabled:isEnabled];
    }
    
}

- (void)heliao_setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag
{
    if (subMod) {
    _heliao_subMod = subMod;
        if (subMod.menuTag == 99 && tag == 9) {
            //默认绿幕编辑功能不可选
            [self heliao_setSubMod:subMod WithTag:tag isEnabled:NO];
        }else{
            if (subMod.menuTag) {
                [self.heliao_cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.left.right.equalTo(self);
                }];
                [self.heliao_cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
                [self.heliao_cellButton setBorderWidth:1.0 BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
                WeakSelf;
                NSString *iconUrl = @"";
                NSString *folder = @"";
                switch (tag) {
                    case 2:
                        iconUrl = [TiSDK getStickerIconURL];
                        folder = @"sticker_icon";
                        break;
                    case 3:
                        iconUrl = [TiSDK getGiftIconURL];
                        folder = @"gift_icon";
                        break;
                    case 7:
                        iconUrl = [TiSDK getWatermarkIconURL];
                        folder = @"watermark_icon";
                        break;
                    case 8:
                        iconUrl = [TiSDK getMaskIconURL];
                        folder = @"mask_icon";
                        break;
                    case 9:
                        iconUrl = [TiSDK getGreenScreenIconURL];
                        folder = @"greenscreen_icon";
                        break;
                    case 11:
                        iconUrl = [TiSDK getInteractionIconURL];
                        folder = @"interaction_icon";
                        break;
                    case 14:
                        iconUrl = [TiSDK getPortraitIconURL];
                        folder = @"portrait_icon";
                        break;
                    case 16:
                        iconUrl = [TiSDK getGestureIconURL];
                        folder = @"gesture_icon";
                        break;
                    default:
                        break;
                }
                
                iconUrl = iconUrl?iconUrl:@"";
                [HLTiUITool heliao_getImageFromeURL:[NSString stringWithFormat:@"%@%@", iconUrl, subMod.thumb] WithFolder:folder downloadComplete:^(UIImage *image) {
                    [weakSelf.heliao_cellButton heliao_setTitle:nil withImage:image withTextColor:nil forState:UIControlStateNormal];
                    [weakSelf.heliao_cellButton heliao_setTitle:nil withImage:image withTextColor:nil forState:UIControlStateSelected];
                }];
                
                switch (subMod.downloaded) {
                    case TI_DOWNLOAD_STATE_CCOMPLET://下载完成
                        [self heliao_endAnimation];
                        [self.heliao_cellButton heliao_setDownloaded:YES];
                        
                            break;
                        case TI_DOWNLOAD_STATE_NOTBEGUN://未下载
                        
                        [self heliao_endAnimation];
                        [self.heliao_cellButton heliao_setDownloaded:NO];
                        
                            break;
                        case TI_DOWNLOAD_STATE_BEBEING://下载中。。。
                        
                        [self heliao_startAnimation];
                        [self.heliao_cellButton heliao_setDownloaded:YES];
                            break;
                    default:
                        break;
                }
                
            }else{
                [self.heliao_cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(17, 17, 17, 17));
                }];
                [self.heliao_cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
                [self.heliao_cellButton setBorderWidth:0.0 BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
                [self.heliao_cellButton heliao_setTitle:nil
                                withImage:[UIImage imageNamed:subMod.normalThumb]
                            withTextColor:nil
                                 forState:UIControlStateNormal];
                [self.heliao_cellButton heliao_setTitle:nil
                                withImage:[UIImage imageNamed:subMod.thumb]
                            withTextColor:nil
                                 forState:UIControlStateSelected];
                [self heliao_endAnimation];
                [self.heliao_cellButton heliao_setDownloaded:YES];
            }
            [self.heliao_cellButton setSelected:subMod.selected];
        }
        
    }
    
}

- (void)heliao_startAnimation{
    [self.heliao_cellButton heliao_startAnimation];
}

- (void)heliao_endAnimation{
    [self.heliao_cellButton heliao_endAnimation]; 
}


- (void)heliao_checkDefualtSetting {
    NSLog(@"Get Info Success");
}
@end
