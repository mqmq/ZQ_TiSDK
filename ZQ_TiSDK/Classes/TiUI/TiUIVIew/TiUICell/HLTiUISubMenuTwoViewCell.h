//
//  HLTiUISubMenuTwoViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"

typedef NS_ENUM(NSInteger, TiUISubMenuTwoViewCellType) {
    TI_UI_TWOSUBCELL_TYPE_ONE,
    TI_UI_TWOSUBCELL_TYPE_TWO
};

@interface HLTiUISubMenuTwoViewCell : UICollectionViewCell

@property(nonatomic,assign) TiUISubMenuTwoViewCellType heliao_setCellType;

@property(nonatomic,strong)TIMenuMode *heliao_setSubMod;


- (void)heliao_getUsersMostFollowerSuccess;
@end
