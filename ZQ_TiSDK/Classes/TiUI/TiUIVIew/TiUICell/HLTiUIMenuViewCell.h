//
//  HLTiUIMenuViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIMenuViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *heliao_menuMode;



NS_ASSUME_NONNULL_END
- (void)heliao_didGetInfoSuccess;
@end
