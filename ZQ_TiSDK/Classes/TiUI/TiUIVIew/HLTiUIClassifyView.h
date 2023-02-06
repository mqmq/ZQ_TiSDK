//
//  HLTiUIClassifyView.h
//  TiFancy
//
//  Created by iMacA1002 on 2020/4/26.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLTiUIClassifyView : UIView
- (void)heliao_showView;
- (void)heliao_hiddenView;

@property (copy, nonatomic)void(^heliao_executeShowOrHiddenBlock)(BOOL);
@property (copy, nonatomic)void(^heliao_clickOnTheClassificationBlock)(NSArray * classifyArr);

@property(nonatomic,strong) NSMutableArray *heliao_iconArr;
@property(nonatomic,strong) UIColor *heliao_titleColor;
@property(nonatomic,strong) UICollectionView *heliao_classifyMenuView;

//萌颜Block
@property (copy, nonatomic)void(^heliao_CutefaceBlock)(NSString * name);

@property(nonatomic,strong) NSArray *heliao_modArr;



NS_ASSUME_NONNULL_END
- (void)heliao_getLoginState:(NSString *)isLogin;
@end
