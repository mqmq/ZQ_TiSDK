//
//  HLTiUISubMenuOneViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTiMenuPlistManager.h"
#import "TiConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIMenuOneViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *heliao_mode;
 
@property(nonatomic,copy)void(^heliao_clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy)void(^heliao_makeupShowDisappearBlock)(BOOL Hidden);

@property(nonatomic,assign) BOOL heliao_isMakeupShow;

@property(nonatomic,strong) UICollectionView *heliao_menuCollectionView;



NS_ASSUME_NONNULL_END
- (void)heliao_getLoginState;
@end
