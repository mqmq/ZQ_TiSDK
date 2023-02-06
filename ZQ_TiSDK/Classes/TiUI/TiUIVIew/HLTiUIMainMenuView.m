//
//  HLTiUIMainMenuView.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMainMenuView.h"
#import "HLTiSetSDKParameters.h"
#import "HLTiDownloadZipManager.h"

#import "HLTiUIMenuViewCell.h"

#import "HLTiUIMenuOneViewCell.h"
#import "HLTiUIMenuTwoViewCell.h"
#import "HLTiUIMenuThreeViewCell.h"

#import "HLTiUIMakeUpView.h"

bool heliao_is_reset = false;
bool is_resetBeauty = false;
NSString *heliao_resetObject = @"";
int heliao_is_greenEdit = 1;
bool heliao_isRefreshOneKey = false;
bool heliao_isRefreshFilter = false;

@interface HLTiUIMainMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *heliao_selectedIndexPath;
@property(nonatomic,assign) NSInteger heliao_mainindex;
@property(nonatomic,assign) NSInteger heliao_subindex;
@property(nonatomic,strong) NSIndexPath *heliao_lx_indexPath;
@property(nonatomic,strong) NSIndexPath *heliao_lv_indexPath;
@property(nonatomic,strong) NSIndexPath *heliao_tz_indexPath;
@property(nonatomic,strong) NSIndexPath *heliao_mz_indexPath;

//绿幕抠图编辑页面title。。
@property(nonatomic,strong)UIView *heliao_editView;
@property(nonatomic,strong)UILabel *heliao_editLabel;

@end

static NSString *const heliao_TiUIMenuViewCollectionViewCellId = @"TiUIMainMenuViewCollectionViewCellId";
static NSString *const heliao_TiUISubMenuViewCollectionViewCellId = @"TiUIMainSubMenuViewCollectionViewCellId";

@implementation HLTiUIMainMenuView

- (HLTiUISliderRelatedView *)heliao_sliderRelatedView{
    if (!_heliao_sliderRelatedView) {
        _heliao_sliderRelatedView = [[HLTiUISliderRelatedView alloc]init];
        //默认美白滑动条

        [_heliao_sliderRelatedView.heliao_sliderView heliao_setSliderType:TI_UI_SLIDER_TYPE_ONE WithValue:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SKIN_WHITENING_SLIDER]];
        
        WeakSelf;//滑动滑动条调用成回调
        [_heliao_sliderRelatedView.heliao_sliderView setHeliao_refreshValueBlock:^(CGFloat value) {
            typeof(weakSelf) strongSelf = weakSelf;
            TiUIDataCategoryKey valueForKey;
            
            if (weakSelf.heliao_mainindex == 10) {//一键美颜
                
                if (value == 100 && strongSelf.heliao_subindex == 0) {
                    [strongSelf heliao_setResetStatus:@"关闭"];
                }else{
                    [strongSelf heliao_setResetStatus:@"美颜"];
                }
                valueForKey = TI_UIDCK_ONEKEY_SLIDER;
                
            }else if (weakSelf.heliao_mainindex == 0){//美颜
                

                [strongSelf heliao_setResetStatus:@"美颜"];
                TIMenuMode *mod = [HLTiMenuPlistManager shareManager].heliao_beautyModeArr[weakSelf.heliao_subindex];
                valueForKey  = (weakSelf.heliao_mainindex+1)*100 + mod.menuTag;

                
            }else if (weakSelf.heliao_mainindex == 13){//脸型
                
                [strongSelf heliao_setResetStatus:@"美颜"];
                valueForKey = TI_UIDCK_FACESHAPE_SLIDER;
                
            }else if (weakSelf.heliao_mainindex == 1){//美型
                
                [strongSelf heliao_setResetStatus:@"美颜"];
                valueForKey  = (weakSelf.heliao_mainindex+1)*100 + weakSelf.heliao_subindex;
                
            }else if (weakSelf.heliao_mainindex==4) {//滤镜
                
                valueForKey = (weakSelf.heliao_mainindex-1)*100 + weakSelf.heliao_subindex;
                
            }else if (weakSelf.heliao_mainindex == 9){//绿幕
                
                valueForKey = 700 + heliao_is_greenEdit;
                //发送通知——开启绿幕编辑恢复功能
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TiUIGreenScreensView_isResetEdit" object:@(true)];
                
            }else if(weakSelf.heliao_mainindex ==12){//美妆
                
                [strongSelf heliao_setResetStatus:@"美妆"];
                int thousand =  (int)self.heliao_subindex/1000 *1000;//千
                 valueForKey = thousand;
                
            }else if (weakSelf.heliao_mainindex==15) {//美发
                
                valueForKey = TI_UIDCK_HAIRDRESS_SLIDER;
                
            }else{
                
                valueForKey  = (weakSelf.heliao_mainindex+1)*100 + weakSelf.heliao_subindex;
                
            }
            
            //储存滑条参数
            [HLTiSetSDKParameters heliao_setFloatValue:value forKey:valueForKey];
            //设置美颜参数

            [HLTiSetSDKParameters heliao_setBeautySlider:value forKey:valueForKey withIndex:weakSelf.heliao_subindex];

            
        }];
        
    }
    return _heliao_sliderRelatedView;
}

- (void)heliao_setResetStatus:(NSString *)setResetObject{
    
    if ([setResetObject  isEqual: @"美颜"]) {
        
        //开启美颜重置功能
        [self.heliao_resetBtn setEnabled:true];
        //设置重置按钮状态——美颜
        [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"beautystate"];
        
    }else if ([setResetObject  isEqual: @"美妆"]){
        
        //开启美妆重置功能
        [self.heliao_resetBtn setEnabled:true];
        heliao_makeup_is_reset = false;
        //设置重置按钮状态——美妆
        [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"makeupstate"];
        
    }else if ([setResetObject  isEqual: @"关闭"]){
        
        //关闭美颜重置功能
        [self.heliao_resetBtn setEnabled:false];
        //设置重置按钮状态——关闭
        [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
        
    }
    
}

- (UIView *)heliao_backgroundView
{
    if (!_heliao_backgroundView) {
        _heliao_backgroundView = [[UIView alloc]init];
    }
    return _heliao_backgroundView;
}

- (HLTiUIClassifyView *)heliao_classifyView{
    if (!_heliao_classifyView) {
        _heliao_classifyView = [[HLTiUIClassifyView alloc]init];
        _heliao_isClassifyShow = YES;
        WeakSelf;
        [_heliao_classifyView setHeliao_executeShowOrHiddenBlock:^(BOOL show) {
             weakSelf.heliao_sliderRelatedView.hidden = show;
             weakSelf.heliao_isClassifyShow = show;
        }];
        [_heliao_classifyView setHeliao_clickOnTheClassificationBlock:^(NSArray * _Nonnull classifyIndexArr) {

            weakSelf.heliao_classifyArr = classifyIndexArr;
            [weakSelf.heliao_menuView reloadData];
            [weakSelf.heliao_subMenuView reloadData];
            for (int i = 0; i<weakSelf.heliao_classifyArr.count; i++){
                NSNumber *menuTag = weakSelf.heliao_classifyArr[i];
                TIMenuMode *mode =  [[HLTiMenuPlistManager shareManager] heliao_mainModeArr][[menuTag intValue]];

                if (mode.selected)
                {
                    NSIndexPath * menuIndex = [NSIndexPath indexPathForRow:i inSection:0];
                    weakSelf.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [weakSelf.heliao_menuView scrollToItemAtIndexPath:menuIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                 }
            }
            
            if (classifyIndexArr == [weakSelf.heliao_classifyView.heliao_modArr[0] objectForKey:@"TIMenuClassify"]){}
            
        }];
        [_heliao_classifyView setHeliao_CutefaceBlock:^(NSString * name) {
            if ([name  isEqual: @"萌颜"]) {
                [weakSelf.heliao_backBtn setHidden:true];
                [weakSelf.heliao_backView setHidden:false];
                [weakSelf.heliao_back2Btn setHidden:false];
                [weakSelf.heliao_lineView setHidden:false];
            }else{
                [weakSelf.heliao_backBtn setHidden:false];
                [weakSelf.heliao_backView setHidden:false];
                [weakSelf.heliao_back2Btn setHidden:true];
                [weakSelf.heliao_lineView setHidden:true];
            }
        }];
    }
    return _heliao_classifyView;
}

- (UIButton *)heliao_backBtn{
    if (!_heliao_backBtn) {
        _heliao_backBtn = [[UIButton alloc] init];
        [_heliao_backBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [_heliao_backBtn addTarget:self action:@selector(heliao_BackPrevious:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_backBtn;
}

- (UIButton *)heliao_back2Btn{
    if (!_heliao_back2Btn) {
        _heliao_back2Btn = [[UIButton alloc] init];
        [_heliao_back2Btn setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [_heliao_back2Btn addTarget:self action:@selector(heliao_BackPrevious:) forControlEvents:UIControlEventTouchUpInside];
        [_heliao_back2Btn setHidden:true];
    }
    return _heliao_back2Btn;
}

- (UIView *)heliao_backView{
    if (!_heliao_backView) {
        _heliao_backView = [[UIView alloc] init];
        _heliao_backView.backgroundColor = TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6);
        [_heliao_backView setHidden:true];
    }
    return _heliao_backView;
}

- (UIView *)heliao_lineView{
    if (!_heliao_lineView) {
        _heliao_lineView = [[UIView alloc] init];
        _heliao_lineView.backgroundColor = TI_RGB_Alpha(238.0, 238.0, 238.0, 0.6);
        [_heliao_lineView setHidden:true];
    }
    return _heliao_lineView;
}

- (UIButton *)heliao_resetBtn{
    if (!_heliao_resetBtn) {
        
        _heliao_resetBtn = [[UIButton alloc] init];
        [_heliao_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_heliao_resetBtn setTitleColor:TI_RGB_Alpha(254.0, 254.0, 254.0, 1.0) forState:UIControlStateNormal];
        [_heliao_resetBtn setTitleColor:TI_RGB_Alpha(254.0, 254.0, 254.0, 0.4) forState:UIControlStateDisabled];
        [_heliao_resetBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:10]];
        [_heliao_resetBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
        [_heliao_resetBtn setImage:[UIImage imageNamed:@"icon_chongzhi_def.png"] forState:UIControlStateNormal];
        [_heliao_resetBtn setImage:[UIImage imageNamed:@"icon_chongzhi_disabled.png"] forState:UIControlStateDisabled];
        [_heliao_resetBtn addTarget:self action:@selector(heliao_ResetClick:) forControlEvents:UIControlEventTouchUpInside];
        //判断重置按钮状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *beautystate = [defaults objectForKey:@"beautystate"];
        NSString *makeupstate = [defaults objectForKey:@"makeupstate"];
        if ([heliao_resetObject  isEqual: @"美颜"]) {
            if ([beautystate  isEqual: @"optional"]) {
                [_heliao_resetBtn setEnabled:true];
            }else{
                //默认不可点击
                [_heliao_resetBtn setEnabled:false];
            }
        }else if ([heliao_resetObject  isEqual: @"美妆"]){
            if ([makeupstate  isEqual: @"optional"]) {
                [_heliao_resetBtn setEnabled:true];
            }else{
                [_heliao_resetBtn setEnabled:false];
            }
        }
        [_heliao_resetBtn setHidden:true];
    }
    return _heliao_resetBtn;
}

- (UIView *)heliao_masklayersView{
    if (!_heliao_masklayersView) {
        _heliao_masklayersView = [[UIView alloc] init];
        _heliao_masklayersView.backgroundColor = TI_RGB_Alpha(0.0, 0.0, 0.0, 0.4);
        [_heliao_masklayersView setHidden:true];
    }
    return _heliao_masklayersView;
}

- (UIView *)heliao_resetBgView{
    if (!_heliao_resetBgView) {
        _heliao_resetBgView = [[UIView alloc] init];
        _heliao_resetBgView.backgroundColor = TI_RGB_Alpha(255.0, 255.0, 255.0, 1.0);
        _heliao_resetBgView.layer.cornerRadius = 10;
        [_heliao_resetBgView setHidden:true];
    }
    return _heliao_resetBgView;
}

- (UILabel *)heliao_resetBgLabel{
    if(!_heliao_resetBgLabel){
        _heliao_resetBgLabel = [[UILabel alloc] init];
        _heliao_resetBgLabel.textColor = TI_RGB_Alpha(68.0, 68.0, 68.0, 1.0);
        _heliao_resetBgLabel.textAlignment = NSTextAlignmentCenter;
        _heliao_resetBgLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _heliao_resetBgLabel.text = @"确定将所有参数值恢复默认吗？";
        [_heliao_resetBgLabel setHidden:true];
    }
    return _heliao_resetBgLabel;
}

- (UIButton *)heliao_reset_MY_YesBtn{
    if (!_heliao_reset_MY_YesBtn) {
        _heliao_reset_MY_YesBtn = [UIButton buttonWithType:0];
        _heliao_reset_MY_YesBtn.backgroundColor = TI_RGB_Alpha(255.0, 255.0, 255.0, 1.0);
        [_heliao_reset_MY_YesBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_heliao_reset_MY_YesBtn setTitleColor: TI_RGB_Alpha(255.0, 255.0, 255.0, 1.0) forState:UIControlStateNormal];
        [_heliao_reset_MY_YesBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_heliao_reset_MY_YesBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:16]];
        [_heliao_reset_MY_YesBtn addTarget:self action:@selector(heliao_ResetYNClick:) forControlEvents:UIControlEventTouchUpInside];
        [_heliao_reset_MY_YesBtn setBackgroundImage:[UIImage imageNamed:@"bg_chongzhi_yes.png"] forState:UIControlStateNormal];
        [_heliao_reset_MY_YesBtn setHidden:true];
        [_heliao_reset_MY_YesBtn setEnabled:false];
    }
    return _heliao_reset_MY_YesBtn;
}

- (UIButton *)heliao_reset_MY_NoBtn{
    if (!_heliao_reset_MY_NoBtn) {
        _heliao_reset_MY_NoBtn = [UIButton buttonWithType:0];
        _heliao_reset_MY_NoBtn.backgroundColor = TI_RGB_Alpha(255.0, 255.0, 255.0, 1.0);
        [_heliao_reset_MY_NoBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_heliao_reset_MY_NoBtn setTitleColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0) forState:UIControlStateNormal];
        [_heliao_reset_MY_NoBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_heliao_reset_MY_NoBtn.titleLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:16]];
        [_heliao_reset_MY_NoBtn addTarget:self action:@selector(heliao_ResetYNClick:) forControlEvents:UIControlEventTouchUpInside];
        _heliao_reset_MY_NoBtn.layer.borderWidth = 0.5;
        _heliao_reset_MY_NoBtn.layer.borderColor = TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0).CGColor;
        _heliao_reset_MY_NoBtn.layer.cornerRadius = 20;
        [_heliao_reset_MY_NoBtn setHidden:true];
    }
    return _heliao_reset_MY_NoBtn;
}

//腮红、睫毛。。
- (UIView *)heliao_topView{
    if (!_heliao_topView) {
        _heliao_topView = [[UIView alloc] init];
        [_heliao_topView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
        [_heliao_topView setHidden:true];
    }
    return _heliao_topView;
}

- (UILabel *)heliao_topLabel{
    if (!_heliao_topLabel) {
        _heliao_topLabel = [[UILabel alloc] init];
        _heliao_topLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        _heliao_topLabel.textAlignment = NSTextAlignmentLeft;
        _heliao_topLabel.textColor = UIColor.whiteColor;
        [_heliao_topLabel setHidden:true];
    }
    return _heliao_topLabel;
}

//绿幕抠图编辑标题。。
- (UIView *)heliao_editView{
    if (!_heliao_editView) {
        _heliao_editView = [[UIView alloc] init];
        [_heliao_editView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
        [_heliao_editView setHidden:true];
    }
    return _heliao_editView;
}

- (UILabel *)heliao_editLabel{
    if (!_heliao_editLabel) {
        _heliao_editLabel = [[UILabel alloc] init];
        _heliao_editLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        _heliao_editLabel.textAlignment = NSTextAlignmentLeft;
        _heliao_editLabel.textColor = UIColor.whiteColor;
        [_heliao_editLabel setHidden:true];
    }
    return _heliao_editLabel;
}

- (void)heliao_setMakeUpTitle:(BOOL)is_hidden withName:(NSString *)name{
    if (is_hidden) {
        [self.heliao_topView setHidden:true];
        [self.heliao_topLabel setHidden:true];
    }else{
        [self.heliao_topView setHidden:false];
        [self.heliao_topLabel setText:name];
        [self.heliao_topLabel setHidden:false];
    }
}

- (void)heliao_setEditTitle:(BOOL)is_hidden withName:(NSString *)name{
    [self.heliao_editView setHidden:!is_hidden];
    [self.heliao_editLabel setHidden:!is_hidden];
    [self.heliao_editLabel setText:name];
    [self.heliao_menuView setHidden:is_hidden];
    [self.heliao_back2Btn setHidden:is_hidden];
    [self.heliao_lineView setHidden:is_hidden];
    [self.heliao_backView setHidden:is_hidden];
}

- (void)heliao_ResetClick:(UIButton *)sender{
    if ([heliao_resetObject  isEqual: @"美颜"]) {
        //美颜重置
        //弹出弹框
        [self.heliao_masklayersView setHidden:false];
        [self.heliao_resetBgView setHidden:false];
        [self.heliao_resetBgLabel setHidden:false];
        [self.heliao_reset_MY_YesBtn setHidden:false];
        [self.heliao_reset_MY_YesBtn setEnabled:true];
        [self.heliao_reset_MY_NoBtn setHidden:false];
        heliao_is_reset = true;
    }else if([heliao_resetObject  isEqual: @"美妆"]){
        //美妆重置
        //弹出弹框
        [self.heliao_masklayersView setHidden:false];
        [self.heliao_resetBgView setHidden:false];
        [self.heliao_resetBgLabel setHidden:false];
        [self.heliao_reset_MY_YesBtn setHidden:false];
        [self.heliao_reset_MY_YesBtn setEnabled:true];
        [self.heliao_reset_MY_NoBtn setHidden:false];
        heliao_is_reset = true;
    }
}

- (void)heliao_ResetYNClick:(UIButton *)sender{
    
    if (sender == _heliao_reset_MY_YesBtn) {
        //确认重置
        [self.heliao_masklayersView setHidden:true];
        [self.heliao_resetBgView setHidden:true];
        [self.heliao_resetBgLabel setHidden:true];
        [self.heliao_reset_MY_YesBtn setHidden:true];
        [self.heliao_reset_MY_NoBtn setHidden:true];
        if ([heliao_resetObject  isEqual: @"美颜"]) {
            is_resetBeauty = true;
            [[HLTiMenuPlistManager shareManager] heliao_reset:@"美颜重置"];
            //设置重置按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];

        }else if([heliao_resetObject  isEqual: @"美妆"]){
            [[HLTiMenuPlistManager shareManager] heliao_reset:@"美妆重置"];

            //设置重置按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"makeupstate"];
        }
        
        [self heliao_didSelectParentMenuCell:self.heliao_selectedIndexPath];
        //关闭重置功能
        [self.heliao_resetBtn setEnabled:false];
        heliao_is_reset = false;
    }else if (sender == _heliao_reset_MY_NoBtn){
        //取消重置
        [self.heliao_masklayersView setHidden:true];
        [self.heliao_resetBgView setHidden:true];
        [self.heliao_resetBgLabel setHidden:true];
        [self.heliao_reset_MY_YesBtn setHidden:true];
        [self.heliao_reset_MY_NoBtn setHidden:true];
        heliao_is_reset = false;
    }
    
}

//让超出父控件的方法触发响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (!view) {
        //转换坐标系
        CGPoint newPointYes = [self.heliao_reset_MY_YesBtn convertPoint:point fromView:self];
        CGPoint newPointNo = [self.heliao_reset_MY_NoBtn convertPoint:point fromView:self];
        //判断触摸点是否在button上
        if (CGRectContainsPoint(self.heliao_reset_MY_YesBtn.bounds, newPointYes)) {
            //resetYesBtn就是我们想点击的控件，让这个控件作为可点击的view返回
            view = self.heliao_reset_MY_YesBtn;
        }
        if (CGRectContainsPoint(self.heliao_reset_MY_NoBtn.bounds, newPointNo)) {
            view = self.heliao_reset_MY_NoBtn;
        }
    }
    return view;
}

- (void)heliao_BackPrevious:(UIButton *)sender{
    
    [_heliao_backView setHidden:true];
    if (!self.heliao_resetBtn.hidden) {
        self.heliao_resetBtn.hidden = YES;
    }
    if (sender == _heliao_back2Btn) {
        [_heliao_back2Btn setHidden:true];
        [_heliao_lineView setHidden:true];
    }

    if ([HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_isClassifyShow) {
        [[HLTiUIManager shareManager] heliao_popAllViews];
    }else{
        [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_showClassifyView];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kTiUIManagerDidExit object:nil];
}

- (UICollectionView *)heliao_menuView{
    if (!_heliao_menuView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _heliao_menuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_heliao_menuView setTag:10];
        _heliao_menuView.showsHorizontalScrollIndicator = NO;
        _heliao_menuView.backgroundColor = TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6);
        _heliao_menuView.dataSource= self;
        _heliao_menuView.delegate = self;
        [_heliao_menuView registerClass:[HLTiUIMenuViewCell class] forCellWithReuseIdentifier:heliao_TiUIMenuViewCollectionViewCellId];
    }
    return _heliao_menuView;
}

- (UICollectionView *)heliao_subMenuView{
    if (!_heliao_subMenuView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, TiUIViewBoxTotalHeight- TiUIMenuViewHeight - TiUISliderRelatedViewHeight-1);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _heliao_subMenuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_heliao_subMenuView setTag:20];
        _heliao_subMenuView.showsHorizontalScrollIndicator = NO;
        _heliao_subMenuView.backgroundColor = TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6);
        _heliao_subMenuView.dataSource= self;
        _heliao_subMenuView.scrollEnabled = NO;//禁止滑动
        //注册多个cell 不重用，重用会导致嵌套的UICollectionView内的cell 错乱
        // FIXME: --json 数据完善后可再次尝试--
        for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_mainModeArr) {
            
            switch (mod.menuTag) {
                case 0:
                case 1:
                case 6:
                case 12:
                case 13:
                {
                    [_heliao_subMenuView registerClass:[HLTiUIMenuOneViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                }
                    break;
                case 4:
                case 5:
                case 10:
                case 15:
                      {
                    [_heliao_subMenuView registerClass:[HLTiUIMenuTwoViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                      }
                     break;
                case 2:
                case 3:
                case 7:
                case 8:
                case 9:
                case 11:
                case 14:
                case 16:
                       {
                     [_heliao_subMenuView registerClass:[HLTiUIMenuThreeViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                        }
                    break;
                    
                default:
                {
                [_heliao_subMenuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                }
                    break;
            }
            
        }
    }
    return _heliao_subMenuView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.heliao_sliderRelatedView];//滑动条模块
        [self addSubview:self.heliao_backgroundView];
        [self.heliao_backgroundView addSubview:self.heliao_menuView];//美颜分割线上的一级菜单
        [self.heliao_backgroundView addSubview:self.heliao_subMenuView];//二级菜单
        [self.heliao_backgroundView addSubview:self.heliao_classifyView];//最上层大分类视图
        
        [self.heliao_backgroundView addSubview:self.heliao_backBtn];
        [self.heliao_backgroundView addSubview:self.heliao_backView];
        [self.heliao_backView addSubview:self.heliao_back2Btn];
        [self.heliao_backgroundView addSubview:self.heliao_resetBtn];
        [self.heliao_backgroundView addSubview:self.heliao_lineView];
        
        self.heliao_sliderRelatedView.hidden = YES;
        [self.heliao_sliderRelatedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_offset(TiUISliderRelatedViewHeight);
        }];
        [self.heliao_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.heliao_sliderRelatedView.mas_bottom);
        }];
        [self.heliao_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.heliao_backgroundView).offset(-55);
            make.top.equalTo(self.heliao_backgroundView);
            make.left.equalTo(self.heliao_backgroundView);
            make.height.mas_offset(TiUIMenuViewHeight);
        }];
        [self.heliao_subMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.bottom.equalTo(self.heliao_backgroundView);
              make.top.equalTo(self.heliao_menuView.mas_bottom);
         }];
         
        [self.heliao_classifyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.heliao_backgroundView);
        }];
        
        [self.heliao_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.bottom.equalTo(self).offset(-44);
            make.width.height.equalTo(@18);
        }];
        [self.heliao_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.bottom.equalTo(self.heliao_menuView);
            make.width.equalTo(@55);
        }];
        [self.heliao_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-55);
            make.width.equalTo(@0.5);
            make.height.equalTo(@18);
            make.centerY.equalTo(self.heliao_menuView);
        }];
        [self.heliao_back2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.heliao_backView);
            make.width.height.equalTo(@18);
        }];
        [self.heliao_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-30);
            make.centerY.equalTo(self.heliao_backBtn);
            make.width.equalTo(@48);
            make.height.equalTo(@20);
        }];
        //美妆
        [self addSubview:self.heliao_topView];
        [self.heliao_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.heliao_backgroundView);
            make.left.equalTo(self.heliao_backgroundView);
            make.height.mas_offset(TiUIMenuViewHeight+0.5);
        }];
        [self addSubview:self.heliao_topLabel];
        [self.heliao_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.centerY.equalTo(self.heliao_topView);
            make.width.equalTo(@50);
        }];
        //绿幕编辑
        [self addSubview:self.heliao_editView];
        [self.heliao_editView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.equalTo(self.heliao_backgroundView);
            make.left.equalTo(self.heliao_backgroundView);
            make.height.mas_offset(TiUIMenuViewHeight);
        }];
        [self addSubview:self.heliao_editLabel];
        [self.heliao_editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.centerY.equalTo(self.heliao_editView);
            make.width.equalTo(@100);
        }];
        //重置功能
        [self addSubview:self.heliao_masklayersView];
        [self addSubview:self.heliao_resetBgView];
        [self addSubview:self.heliao_resetBgLabel];
        [self.heliao_resetBgView addSubview:self.heliao_reset_MY_YesBtn];
        [self.heliao_resetBgView addSubview:self.heliao_reset_MY_NoBtn];
        [self.heliao_masklayersView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.top.equalTo(self).offset(self.frame.size.height-SCREEN_HEIGHT);
        }];
        [self.heliao_resetBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.heliao_masklayersView);
            make.centerX.equalTo(self.heliao_masklayersView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*280/375, (SCREEN_WIDTH*280/375)*200/280));
        }];
        [self.heliao_resetBgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.heliao_resetBgView).offset(40);
            make.centerX.equalTo(self.heliao_resetBgView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*280/375, 15));
        }];
        [self.heliao_reset_MY_YesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.heliao_resetBgView).offset(78);
            make.centerX.equalTo(self.heliao_resetBgView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*180/375, (SCREEN_WIDTH*180/375)*40/180));
        }];
        [self.heliao_reset_MY_NoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.heliao_reset_MY_YesBtn.mas_bottom).offset(12);
            make.centerX.equalTo(self.heliao_resetBgView);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH*180/375, (SCREEN_WIDTH*180/375)*40/180));
        }];
    }
    return self;
}

 
#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==10) {
        return self.heliao_classifyArr.count;
    }else{
        return [[HLTiMenuPlistManager shareManager] heliao_mainModeArr].count;
    }
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag ==10) {

        int menuTag = [self.heliao_classifyArr[indexPath.row] intValue];
        TIMenuMode *mode =  [[HLTiMenuPlistManager shareManager] heliao_mainModeArr][menuTag];
        CGSize size = [self heliao_sizeWithString:mode.name font:TI_Font_Default_Size_Medium];
        return CGSizeMake(size.width, TiUIMenuViewHeight);
    }else{
        return CGSizeMake(SCREEN_WIDTH, TiUIViewBoxTotalHeight- TiUIMenuViewHeight - TiUISliderRelatedViewHeight-1);
    }
}

//自适应大小
- (CGSize)heliao_sizeWithString:(NSString *)str font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(1000,2000);//设置最大容量
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;//计算实际高度和宽度
    return size;
}

// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, 30, 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 36;
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 36;
}

 //返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag==10) {
        

        int menuTag = [self.heliao_classifyArr[indexPath.row] intValue];
        TIMenuMode *mode =  [[HLTiMenuPlistManager shareManager] heliao_mainModeArr][menuTag];
        HLTiUIMenuViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:heliao_TiUIMenuViewCollectionViewCellId forIndexPath:indexPath];
        if (mode.selected)
        {
             self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
             [self heliao_didSelectParentMenuCell:self.heliao_selectedIndexPath];
        }
        [cell setHeliao_menuMode:mode];
        
        return cell;
        
    }else if (collectionView.tag==20){
        
        TIMenuMode *mode = [[HLTiMenuPlistManager shareManager] heliao_mainModeArr][indexPath.row];
        switch (mode.menuTag) {
            case 0:
            case 1:
            case 6:
            case 12:
            case 13:
            {
                HLTiUIMenuOneViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                WeakSelf;
                [cell setHeliao_clickOnCellBlock:^(NSInteger index) {
                    weakSelf.heliao_subindex = index;
                    [weakSelf heliao_setSliderTypeAndValue];
                    if (mode.menuTag==12) {
                        int thousand = (int)index/1000 *1000;//千
                        //设置美颜参数
                        [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:thousand] forKey:thousand withIndex:index];
                            //保存选中的美妆
                        [HLTiSetSDKParameters heliao_setBeautyMakeupIndex:(int)index forKey:thousand];
                    }
                }];
                
                [cell setHeliao_makeupShowDisappearBlock:^(BOOL Hidden) {
                    if (Hidden) {
                        [weakSelf.heliao_sliderRelatedView heliao_setSliderHidden:YES];
                    }
                }];
                [cell setHeliao_mode:mode];
                return cell;
            }
                break;

            case 4:
            case 5:
            case 10:
            case 15:
            {
                HLTiUIMenuTwoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                WeakSelf;
                [cell setHeliao_clickOnCellBlock:^(NSInteger index) {
                    weakSelf.heliao_subindex = index;
                    [weakSelf heliao_setSliderTypeAndValue];
                }];
                [cell setHeliao_mode:mode];
               return cell;
            }
                break;
                
            case 2:
            case 3:
            case 7:
            case 8:
            case 9:
            case 11:
            case 14:
            case 16:
            {
                HLTiUIMenuThreeViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                [cell setHeliao_mode:mode];
                return cell;
            }
                break;
                
            default:
            {
                UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",heliao_TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                cell.backgroundColor = [UIColor orangeColor];
                return cell;
            }
                break;
        }
         
    }
        return nil;
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==10)
    {
        if(indexPath.row == self.heliao_selectedIndexPath.row) return;
        [self heliao_didSelectParentMenuCell:indexPath];
    }
}

- (void)heliao_didSelectParentMenuCell:(NSIndexPath *)indexPath{
    
    int menuTag = [self.heliao_classifyArr[indexPath.row] intValue];
    self.heliao_mainindex = menuTag;
    switch (menuTag) {
        case 0:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_beautyModeArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            break;
        case 1:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            break;
        case 4:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_filterModeArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            heliao_isRefreshFilter = true;
            heliao_isRefreshOneKey = false;
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuTwo_isRefresh" object:@(true)];
            break;
        case 10:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                }
            }
            //强制开启美颜、美型
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isOpen" object:@(true)];
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            [self.heliao_subMenuView reloadData];
            heliao_isRefreshOneKey = true;
            heliao_isRefreshFilter = false;
            break;
        case 11:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_interactionsArr) {
                if (mod.selected) {
                    [[HLTiUIManager shareManager] heliao_setInteractionHintL:mod.hint];
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
            break;
        case 12:
           //显示重置按钮
           self.heliao_resetBtn.hidden = NO;
           [self heliao_setSliderTypeAndValue];
           [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
           break;
       case 13: //脸型
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                    
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            break;
       case 15://美发
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_hairdressModArr) {
                if (mod.selected) {
                    self.heliao_subindex = mod.menuTag;
                }
            }
            //隐藏重置按钮
            self.heliao_resetBtn.hidden = YES;
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            [self heliao_setSliderTypeAndValue];
            break;
        case 16:
            for (TIMenuMode *mod in [HLTiMenuPlistManager shareManager].heliao_gesturesModArr) {
                if (mod.selected) {
                    [[HLTiUIManager shareManager] heliao_setInteractionHintL:mod.hint];
                }
            }
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
            break;
        default:
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
            break;
    }
    int selectedMenuTag = [self.heliao_classifyArr[self.heliao_selectedIndexPath.row] intValue];
    if (selectedMenuTag != menuTag) {

        [HLTiMenuPlistManager shareManager].heliao_mainModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:menuTag WithPath:@"TiMenu.json"];
        [HLTiMenuPlistManager shareManager].heliao_mainModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:selectedMenuTag WithPath:@"TiMenu.json"];
        if(self.heliao_selectedIndexPath)
        {
            [self.heliao_menuView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
        }else{
            [self.heliao_menuView reloadItemsAtIndexPaths:@[indexPath]];
        }
        self.heliao_selectedIndexPath = indexPath;
    }
    
    NSIndexPath * submenuIndex = [NSIndexPath indexPathForRow:menuTag inSection:0];
    [self.heliao_subMenuView scrollToItemAtIndexPath:submenuIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
}

//设置滑动条参数
- (void)heliao_setSliderTypeAndValue{
    TiUISliderType sliderType = TI_UI_SLIDER_TYPE_ONE;
    TiUIDataCategoryKey categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;
    
    if (self.heliao_mainindex==0) {
        NSInteger key = self.heliao_subindex;
        if (!is_resetBeauty) {

            TIMenuMode *mod = [HLTiMenuPlistManager shareManager].heliao_beautyModeArr[self.heliao_subindex];
            
            key = mod.menuTag;
        }
        is_resetBeauty = false;
        switch (key) {
            case 0:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;// 美白
                break;
            case 1:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                categoryKey = TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER;// 磨皮
                break;
            case 2:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                categoryKey = TI_UIDCK_SKIN_TENDERNESS_SLIDER;// 粉嫩
                break;
            case 3:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                categoryKey = TI_UIDCK_SKIN_SKINBRIGGT_SLIDER;// 清晰
                break;
            case 4:
                sliderType = TI_UI_SLIDER_TYPE_TWO;
                categoryKey = TI_UIDCK_SKIN_BRIGHTNESS_SLIDER;// 亮度
                break;
            case 5:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                categoryKey = TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER;// 精准美肤
                break;
            default:
                break;
        }
    }else if (self.heliao_mainindex==1){
        categoryKey = (self.heliao_mainindex+1)*100 + self.heliao_subindex;
        switch (self.heliao_subindex) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 6:
            case 13:
            case 17:
            case 22:
                sliderType = TI_UI_SLIDER_TYPE_ONE;
                break;
            case 5:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            case 12:
            case 14:
            case 15:
            case 16:
            case 18:
            case 19:
            case 20:
            case 21:
                sliderType = TI_UI_SLIDER_TYPE_TWO;
                break;
            default:
                break;
        }
    }else if (self.heliao_mainindex==4){
        
        sliderType = TI_UI_SLIDER_TYPE_ONE;
        categoryKey = (self.heliao_mainindex-1)*100 + self.heliao_subindex;
        if (self.heliao_subindex != 0) {
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
        }else{
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
        }
        
    }else if (self.heliao_mainindex == 9){
        
        if (heliao_is_greenEdit == 1) {
            sliderType = TI_UI_SLIDER_TYPE_TWO;
        }else{
            sliderType = TI_UI_SLIDER_TYPE_ONE;
        }
        categoryKey = 700 + heliao_is_greenEdit;
        [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
        
    }else if (self.heliao_mainindex==10){
        
        categoryKey = TI_UIDCK_ONEKEY_SLIDER;//一键美颜
        
    }else if (self.heliao_mainindex == 12){
        
        int thousand = (int)self.heliao_subindex/1000 *1000;//千
        categoryKey = thousand;//  对应key
        sliderType = TI_UI_SLIDER_TYPE_ONE;
        if (heliao_Default_is_Null) {
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
        }else{
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
        }
        
    }else if (self.heliao_mainindex==13){
        
        categoryKey = TI_UIDCK_FACESHAPE_SLIDER;//脸型
        
    }else if (self.heliao_mainindex==15){
        
        sliderType = TI_UI_SLIDER_TYPE_ONE;
        categoryKey = TI_UIDCK_HAIRDRESS_SLIDER;//美发
        if (self.heliao_subindex != 0) {
            [self.heliao_sliderRelatedView heliao_setSliderHidden:NO];
        }else{
            [self.heliao_sliderRelatedView heliao_setSliderHidden:YES];
        }
        
    }

    [self.heliao_sliderRelatedView.heliao_sliderView heliao_setSliderType:sliderType WithValue:[HLTiSetSDKParameters heliao_getFloatValueForKey:categoryKey]];

    
}

//返回 显示分类view
- (void)heliao_showClassifyView{
    self.heliao_backBtn.hidden = false;
    self.heliao_menuView.hidden = YES;
    self.heliao_subMenuView.hidden = YES;
    [self.heliao_classifyView heliao_showView];
}

- (void)heliao_hiddenClassifyView{
    [self.heliao_classifyView heliao_hiddenView];
}

- (void)dealloc{
    [HLTiMenuPlistManager heliao_releaseShareManager];
    [HLTiDownloadZipManager releaseShareManager];
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)heliao_upload {
    NSLog(@"Get User Succrss");
}
@end
