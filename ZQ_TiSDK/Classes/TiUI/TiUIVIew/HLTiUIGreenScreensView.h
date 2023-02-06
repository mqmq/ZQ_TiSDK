//
//  HLTiUIGreenScreensView.h
//  TiFancy
//
//  Created by N17 on 2021/4/16.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"
#import "HLTiButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIGreenScreensView : UIView

@property(nonatomic,strong) HLTiButton *heliao_resetBtn;//恢复
@property(nonatomic,strong) UIView *heliao_dividingLine;//分割线

@property(nonatomic,strong) HLTiButton *heliao_similarityBtn;//相似度
@property(nonatomic,strong) HLTiButton *heliao_smoothBtn;//平滑度
@property(nonatomic,strong) HLTiButton *heliao_hyalineBtn;//透明度



NS_ASSUME_NONNULL_END
- (void)heliao_didGetInfoSuccess;
@end
