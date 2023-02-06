//
//  HLTiUIMainMenuView.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLTiUIClassifyView.h"
#import "HLTiUISliderRelatedView.h"

NS_ASSUME_NONNULL_BEGIN

// --- 全局变量 ---

//是否打开重置开关
extern bool heliao_is_reset;
//当前重置对象
extern NSString *heliao_resetObject;
//绿幕编辑
extern int heliao_is_greenEdit;

extern bool heliao_isRefreshOneKey;
extern bool heliao_isRefreshFilter;

@interface HLTiUIMainMenuView : UIView

@property(nonatomic,assign) BOOL heliao_isClassifyShow;
@property(nonatomic,strong) UIButton *heliao_backBtn;
@property(nonatomic,strong) UIButton *heliao_back2Btn;
@property(nonatomic,strong) UIView *heliao_backView;
@property(nonatomic,strong) UIView *heliao_lineView;
@property(nonatomic,strong) UIButton *heliao_resetBtn;

//美颜菜单view
@property(nonatomic,strong) UICollectionView *heliao_menuView;
//美颜菜单view字体颜色
@property(nonatomic,strong) UIColor *_Nullable heliao_menuFontColor;
//滑块相关View
@property(nonatomic,strong) HLTiUISliderRelatedView  *heliao_sliderRelatedView;
//菜单view背景
@property(nonatomic,strong) UIView *heliao_backgroundView;
//新增UI美颜分类功能
@property(nonatomic,strong) HLTiUIClassifyView *heliao_classifyView;
//美颜分组菜单信息
@property(nonatomic,strong) NSArray *heliao_classifyArr;
//美颜菜单二级联动CollectionView子菜单
@property(nonatomic,strong) UICollectionView *heliao_subMenuView;
//重置功能界面
@property(nonatomic,strong) UIView * _Nullable heliao_masklayersView;
@property(nonatomic,strong) UIView * _Nullable heliao_resetBgView;
@property(nonatomic,strong) UILabel * _Nullable heliao_resetBgLabel;
@property(nonatomic,strong) UIButton * _Nullable heliao_reset_MY_YesBtn;
@property(nonatomic,strong) UIButton * _Nullable heliao_reset_MY_NoBtn;
//腮红、睫毛title。。
@property(nonatomic,strong)UIView *heliao_topView;
@property(nonatomic,strong)UILabel *heliao_topLabel;

- (void)heliao_showClassifyView;
- (void)heliao_hiddenClassifyView;
- (void)heliao_setMakeUpTitle:(BOOL)is_hidden withName:(NSString *)name;
- (void)heliao_setSliderTypeAndValue;
- (void)heliao_didSelectParentMenuCell:(NSIndexPath *)indexPath;
- (void)heliao_setEditTitle:(BOOL)is_hidden withName:(NSString *)name;



NS_ASSUME_NONNULL_END
- (void)heliao_upload;
@end
