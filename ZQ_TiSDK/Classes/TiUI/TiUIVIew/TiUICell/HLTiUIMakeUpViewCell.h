//
//  HLTiUIMakeUpViewCell.h
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"
#import "HLTiButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIMakeUpViewCell : UICollectionViewCell

@property(nonatomic,strong)TIMenuMode *heliao_subMod;
@property(nonatomic ,strong)HLTiButton *heliao_cellButton;

-(void)heliao_setCellTypeBorderIsShow:(BOOL)show;



NS_ASSUME_NONNULL_END
- (void)heliao_getLoginState;
@end
