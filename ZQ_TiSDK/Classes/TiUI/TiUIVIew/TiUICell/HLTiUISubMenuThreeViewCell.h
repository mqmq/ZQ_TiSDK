//
//  HLTiUISubMenuThreeViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"
#import "HLTiButton.h"

@interface HLTiUISubMenuThreeViewCell : UICollectionViewCell

@property(nonatomic,strong)TIMenuMode *heliao_subMod;

- (void)heliao_setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag;
- (void)heliao_setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag isEnabled:(BOOL)isEnabled;

- (BOOL)heliao_isEdit;

- (void)heliao_startAnimation;
- (void)heliao_endAnimation;


- (void)heliao_checkDefualtSetting;
@end
