//
//  HLTiUIMenuThreeViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"

@interface HLTiUIMenuThreeViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *heliao_mode;

@property(nonatomic,strong) UICollectionView *heliao_menuCollectionView;


- (void)heliao_getUsersMostLikedSuccess;
@end
