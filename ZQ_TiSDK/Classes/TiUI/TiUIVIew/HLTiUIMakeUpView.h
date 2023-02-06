//
//  HLTiUIMakeUpView.h
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/1.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTiMenuPlistManager.h"
#import "HLTiButton.h"

NS_ASSUME_NONNULL_BEGIN

//全局变量——判断不同美妆的默认状态
extern bool heliao_Default_is_Null;
extern bool heliao_makeup_is_reset;

@interface HLTiUIMakeUpView : UIView

@property(nonatomic,copy)void(^heliao_clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy)void(^heliao_makeupShowDisappearBlock)(BOOL Hidden);

@property(nonatomic,copy)void(^heliao_backBlock)(BOOL is_back);

@property(nonatomic,strong) TIMenuMode *heliao_mode;

@property(nonatomic,strong)UIButton *heliao_backBtn;
@property(nonatomic,strong)UIView *heliao_lineView;
@property(nonatomic,strong)UIButton *heliao_defaultBtn;
@property(nonatomic,strong)UILabel *heliao_defaultLabel;

@property(nonatomic,strong) UICollectionView *heliao_menuCollectionView;

-(void)heliao_setHiddenAnimation:(BOOL)hidden;
-(void)heliao_defaultselected:(UIButton *)button;



NS_ASSUME_NONNULL_END
- (void)heliao_checkUserInfo;
@end
