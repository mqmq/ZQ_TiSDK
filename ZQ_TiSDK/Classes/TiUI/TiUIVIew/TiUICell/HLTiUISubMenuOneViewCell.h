//
//  HLTiUISubMenuOneViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"

@interface HLTiUISubMenuOneViewCell : UICollectionViewCell

@property(nonatomic,strong)TIMenuMode *heliao_subMod;

- (void)heliao_setCellTypeBorderIsShow:(BOOL)show;


- (void)heliao_getUsersMostLiked:(NSString *)mediaInfo;
@end
