//
//  HLTiUIMenuTwoViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"

@interface HLTiUIMenuTwoViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *heliao_mode;
@property(nonatomic,copy)void(^heliao_clickOnCellBlock)(NSInteger index);
@property(nonatomic,strong) UICollectionView *heliao_menuCollectionView;

- (instancetype)initWithFrame:(CGRect)frame;


- (void)heliao_getMediaFailed:(NSString *)followCount;
@end
