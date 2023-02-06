//
//  HLTiUISubMenuOneViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMenuOneViewCell.h"
#import "HLTiButton.h"
#import "HLTiUISubMenuOneViewCell.h"
#import "HLTiUIMakeUpView.h"
#import "HLTiSetSDKParameters.h"

@interface HLTiUIMenuOneViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)HLTiButton *heliao_totalSwitch;
@property(nonatomic,strong)UIView *heliao_lineView;

@property(nonatomic,strong) NSIndexPath *heliao_selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *heliao_FaceshapeIndexPath;

@property(nonatomic,strong)HLTiUIMakeUpView *heliao_meizhuangView;

@end

static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMainMenuCollectionViewnOneCellId";

@implementation HLTiUIMenuOneViewCell
 
- (HLTiButton *)heliao_totalSwitch{
    if (!_heliao_totalSwitch) {
        _heliao_totalSwitch = [[HLTiButton alloc]initWithScaling:0.9];
        [_heliao_totalSwitch addTarget:self action:@selector(heliao_totalSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_totalSwitch;
}

- (UIView *)heliao_lineView{
    if (!_heliao_lineView) {
        _heliao_lineView = [[UIView alloc]init];
        _heliao_lineView.backgroundColor = TI_Color_Default_Text_Black;
    }
    return _heliao_lineView;
}

- (UICollectionView *)heliao_menuCollectionView{
    if (!_heliao_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置最小行间距
        layout.minimumLineSpacing = 15;
        _heliao_menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _heliao_menuCollectionView.showsHorizontalScrollIndicator = NO;
        _heliao_menuCollectionView.backgroundColor = [UIColor clearColor];
        _heliao_menuCollectionView.dataSource= self;
        _heliao_menuCollectionView.delegate = self;
       
        [_heliao_menuCollectionView registerClass:[HLTiUISubMenuOneViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
    }
    return _heliao_menuCollectionView;
}

- (HLTiUIMakeUpView *)heliao_meizhuangView{
    if (!_heliao_meizhuangView) {
        _heliao_meizhuangView =[[HLTiUIMakeUpView alloc]init];
        WeakSelf;
        [_heliao_meizhuangView setHeliao_clickOnCellBlock:^(NSInteger index) {
            if (weakSelf.heliao_clickOnCellBlock)
               {
                    weakSelf.heliao_clickOnCellBlock(index);
               }
        }];
        
        [_heliao_meizhuangView setHeliao_makeupShowDisappearBlock:^(BOOL Hidden) {
            if (weakSelf.heliao_makeupShowDisappearBlock)
            {
                weakSelf.heliao_makeupShowDisappearBlock(Hidden);
            }
        }];
        
        [_heliao_meizhuangView setHeliao_backBlock:^(BOOL is_back) {
            if(is_back){
                
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_menuView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_subMenuView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
                
                [weakSelf.heliao_meizhuangView setHidden:true];
                [weakSelf.heliao_menuCollectionView setHidden:false];
                [weakSelf.heliao_menuCollectionView reloadData];
                [weakSelf.heliao_totalSwitch setHidden:false];
                [weakSelf.heliao_lineView setHidden:false];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_menuView setHidden:false];

                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_backBtn setHidden:false];
                //显示重置
                [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn.hidden = NO;
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_setMakeUpTitle:true withName:@""];
            }else{
                [weakSelf.heliao_menuCollectionView setHidden:true];
                [weakSelf.heliao_totalSwitch setHidden:true];
                [weakSelf.heliao_lineView setHidden:true];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_menuView setHidden:true];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_subMenuView setBackgroundColor:UIColor.clearColor];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_backBtn setHidden:true];
                
                [weakSelf.heliao_meizhuangView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_topView setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_topLabel setTextColor:[UIColor whiteColor]];
                [weakSelf.heliao_meizhuangView.heliao_defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_normal_white.png"] forState:UIControlStateNormal];
                if (heliao_Default_is_Null) {
                    [weakSelf.heliao_meizhuangView.heliao_defaultLabel setTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0)];

                }else{
                    [weakSelf.heliao_meizhuangView.heliao_defaultLabel setTextColor:UIColor.whiteColor];
                }
                [weakSelf.heliao_meizhuangView setHidden:false];
                //隐藏重置

                [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn.hidden = YES;

            }
        }];
        
    }
    return _heliao_meizhuangView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.heliao_totalSwitch];
        [self addSubview:self.heliao_lineView];
        
        [self addSubview:self.heliao_menuCollectionView];

        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        
        [self.heliao_totalSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(35);
            make.width.mas_equalTo(TiUISubMenuOneViewTiButtonWidth-12);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self.heliao_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_totalSwitch.mas_right).offset(20);
            make.width.mas_equalTo(0.25);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self.heliao_menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_lineView.mas_right).offset(25);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.heliao_meizhuangView];
        [self.heliao_meizhuangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        //注册通知——通知是否强制开启美颜美型
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalStatus:) name:@"NotificationName_TIUIMenuOne_isOpen" object:nil];
        //注册通知——通知是否重置脸型
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_resetFaceshape:) name:@"NotificationName_TIUIMenuOne_isReset" object:nil];
    }
    return self;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.heliao_mode.menuTag) {
        case 0:
            return [HLTiMenuPlistManager shareManager].heliao_beautyModeArr.count;
            break;
        case 1:
            return [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr.count;
            break;
        case 6:
            return [HLTiMenuPlistManager shareManager].heliao_distortionModeArr.count;
            break;
        case 12:
            return [HLTiMenuPlistManager shareManager].heliao_makeupModArr.count;
            break;
        case 13:
            return [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr.count;
            break;
        default:
            return 0;
            break;
    }
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIMenuMode *subMod = nil;
    switch (self.heliao_mode.menuTag) {
        case 0:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_beautyModeArr[indexPath.row];
        }
            break;
        case 1:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr[indexPath.row];
        }
            break;
        case 6:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_distortionModeArr[indexPath.row];
        }
            break;
        case 12:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_makeupModArr[indexPath.row];
        }
            break;
        case 13:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    //美型分类单独判断
    if (self.heliao_mode.menuTag == 1 && [subMod.normalThumb  isEqual: @""]) {
        return CGSizeMake(30,40);
    }else{
        return CGSizeMake(TiUISubMenuOneViewTiButtonWidth ,TiUISubMenuOneViewTiButtonHeight);
    }
    
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HLTiUISubMenuOneViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    switch (self.heliao_mode.menuTag) {
        case 0:
        {
            TIMenuMode * subMod = [[HLTiMenuPlistManager shareManager].heliao_beautyModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_subMod:subMod];
        }
            break;
        case 1:
        {
            TIMenuMode * subMod = [[HLTiMenuPlistManager shareManager].heliao_appearanceModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_subMod:subMod];
        }
            break;
        case 6:
        {
            //哈哈更新约束
            [self.heliao_totalSwitch setHidden:true];
            [self.heliao_lineView setHidden:true];
            [self.heliao_menuCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(40);
                make.right.equalTo(self).offset(-43);
            }];
            TIMenuMode * subMod = [[HLTiMenuPlistManager shareManager].heliao_distortionModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
                {
                    self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
                }
            subMod = [HLTiMenuPlistManager shareManager].heliao_distortionModeArr[indexPath.row];
            [cell setHeliao_subMod:subMod];
        }
            break;
        case 12:
        {

            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView heliao_setSliderHidden:YES];
            TIMenuMode * subMod = [[HLTiMenuPlistManager shareManager].heliao_makeupModArr objectAtIndex:indexPath.row];

            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = nil;
            }
            [cell setHeliao_subMod:subMod];
        }
            break;
        case 13:
        {
            //脸型时更新约束
            [self.heliao_totalSwitch setHidden:true];
            [self.heliao_lineView setHidden:true];
            [self.heliao_menuCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(40);
                make.right.equalTo(self).offset(-43);
            }];
            TIMenuMode * subMod = [[HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.heliao_FaceshapeIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_subMod:subMod];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
         
}

//判断默认按钮状态
- (BOOL)heliao_is_selected{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.heliao_meizhuangView.heliao_mode.menuTag == 1) {
        NSString *cheekRed_default = [defaults objectForKey:@"cheekRed_default"];
        if (![cheekRed_default  isEqual: @"腮红"]) {
            return true;
        }else{
            return false;
        }
    }else if (self.heliao_meizhuangView.heliao_mode.menuTag == 2) {
        NSString *eyelash_default = [defaults objectForKey:@"eyelash_default"];
        if (![eyelash_default  isEqual: @"睫毛"]) {
            return true;
        }else{
            return false;
        }
    }else if (self.heliao_meizhuangView.heliao_mode.menuTag == 3) {
        NSString *eyebrows_default = [defaults objectForKey:@"eyebrows_default"];
        if (![eyebrows_default  isEqual: @"眉毛"]) {
            return true;
        }else{
            return false;
        }
    }else if (self.heliao_meizhuangView.heliao_mode.menuTag == 4) {
        NSString *eyeshadow_default = [defaults objectForKey:@"eyeshadow_default"];
        if (![eyeshadow_default  isEqual: @"眼影"]) {
            return true;
        }else{
            return false;
        }
    }else if (self.heliao_meizhuangView.heliao_mode.menuTag == 5) {
        NSString *eyeLine_default = [defaults objectForKey:@"eyeLine_default"];
        if (![eyeLine_default  isEqual: @"眼线"]) {
            return true;
        }else{
            return false;
        }
    }
    return true;
}

- (void)heliao_resetFaceshape:(NSNotification *)notification{

    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.heliao_FaceshapeIndexPath.row != 0) {
        if (self.heliao_clickOnCellBlock)
        {
          self.heliao_clickOnCellBlock(IndexPath.row);
        }

        [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiFaceShape.json"];
        [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_FaceshapeIndexPath.row WithPath:@"TiFaceShape.json"];
        if (self.heliao_FaceshapeIndexPath) {
            [self.heliao_menuCollectionView reloadItemsAtIndexPaths:@[self.heliao_FaceshapeIndexPath,IndexPath]];
        }else{
            [self.heliao_menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.heliao_FaceshapeIndexPath = IndexPath;
    }
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TIMenuMode *modX = [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr[indexPath.row];
    //美型分类单独判断
    if (self.heliao_mode.menuTag == 1 && (indexPath.row == 3 || indexPath.row == 9 || indexPath.row == 14 || indexPath.row == 17 || indexPath.row == 22)) {
        return;
    }else{
        if (self.heliao_mode.menuTag ==12) {
            isswitch_makeup = true;

            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_backView setHidden:true];
            [self.heliao_meizhuangView heliao_setHiddenAnimation:NO];
            self.heliao_meizhuangView.heliao_mode = [[HLTiMenuPlistManager shareManager].heliao_makeupModArr objectAtIndex:indexPath.row];

            
            if (self.heliao_makeupShowDisappearBlock) {
                self.heliao_makeupShowDisappearBlock(NO);
            }
            //设置默认按钮状态
            heliao_Default_is_Null = [self heliao_is_selected];
            //判断默认按钮状态
            if (heliao_Default_is_Null) {
                [self.heliao_meizhuangView.heliao_defaultBtn setSelected:true];
                [self.heliao_meizhuangView.heliao_defaultLabel setTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0)];
            }else{
                [self.heliao_meizhuangView.heliao_defaultBtn setSelected:false];
                [self.heliao_meizhuangView.heliao_defaultLabel setTextColor:UIColor.whiteColor];
            }
            //单独设置文字
            self.heliao_meizhuangView.heliao_backBlock(NO);
            //是否已重置
            if (heliao_makeup_is_reset == true) {
    //            [self.meizhuangView defaultselected:self.meizhuangView.defaultBtn];
                heliao_makeup_is_reset = false;
            }
            //是否显示滑动条

            if (heliao_Default_is_Null) {
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView heliao_setSliderHidden:YES];
            }else{
                [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView heliao_setSliderHidden:NO];
            }
            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_setMakeUpTitle:false withName:self.heliao_meizhuangView.heliao_mode.name];

            return;
        }
        if (self.heliao_clickOnCellBlock)
        {
            if (self.heliao_mode.menuTag != 1){
                self.heliao_clickOnCellBlock(indexPath.row);
            }else{
                self.heliao_clickOnCellBlock(modX.menuTag);
            }
        }
        if (self.heliao_mode.menuTag == 13) {
            if (indexPath.row == self.heliao_FaceshapeIndexPath.row)
            {
                return;
            }else{

                [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiFaceShape.json"];
                [HLTiMenuPlistManager shareManager].heliao_faceshapeModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_FaceshapeIndexPath.row WithPath:@"TiFaceShape.json"];
                if (self.heliao_FaceshapeIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_FaceshapeIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_FaceshapeIndexPath = indexPath;
                [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_FACESHAPE_SLIDER] forKey:TI_UIDCK_FACESHAPE_SLIDER withIndex:indexPath.row];

            }
            return;
        }else{
            if(indexPath.row == self.heliao_selectedIndexPath.row)
            {
                return;
            }
            switch (self.heliao_mode.menuTag) {
                case 0:
                {

                    [HLTiMenuPlistManager shareManager].heliao_beautyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiBeauty.json"];
                    [HLTiMenuPlistManager shareManager].heliao_beautyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiBeauty.json"];
                    if (self.heliao_selectedIndexPath) {
                        [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];

                    }else{
                        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                    }
                    self.heliao_selectedIndexPath = indexPath;
                    
                    TIMenuMode *mod = [HLTiMenuPlistManager shareManager].heliao_beautyModeArr[indexPath.row];
                    [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:(100 + mod.menuTag)] forKey:(100 + mod.menuTag) withIndex:indexPath.row];
                    
                }
                    break;
                case 1:
                {

                    [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiAppearance.json"];
                    [HLTiMenuPlistManager shareManager].heliao_appearanceModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiAppearance.json"];
                    if (self.heliao_selectedIndexPath) {
                        [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];

                    }else{
                        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                    }
                    self.heliao_selectedIndexPath = indexPath;
                }
                    break;
                case 6:
                {

                    [HLTiMenuPlistManager shareManager].heliao_distortionModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiDistortion.json"];
                    [HLTiMenuPlistManager shareManager].heliao_distortionModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiDistortion.json"];
                    if (self.heliao_selectedIndexPath) {
                        [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                    }else{
                        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                    }
                    self.heliao_selectedIndexPath = indexPath;
                    [[TiSDKManager shareManager] setDistortionEnum:[HLTiSetSDKParameters heliao_setDistortionEnumByIndex:indexPath.row]];

                }
                    break;
                default:
                    break;
            }
            
        }
        
    }
    
}

- (void)totalStatus:(NSNotification *)notification{
    
    NSNumber *successN = notification.object;
    BOOL success =  [successN boolValue];

    if (self.heliao_mode.menuTag == 0 || self.heliao_mode.menuTag == 1) {
        [HLTiMenuPlistManager shareManager].heliao_mainModeArr  = [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(success) forKey:@"totalSwitch" In:self.heliao_mode.menuTag WithPath:@"TiMenu.json"];
        TIMenuMode *newMod = [HLTiMenuPlistManager shareManager].heliao_mainModeArr[self.heliao_mode.menuTag];
        _heliao_mode = newMod;
        [self.heliao_totalSwitch setSelected:newMod.totalSwitch];

        [[TiSDKManager shareManager] setBeautyEnable:success];
        [[TiSDKManager shareManager] setFaceTrimEnable:success];
    }
    
}

- (void)dealloc{
    //移除通知
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)heliao_totalSwitch:(HLTiButton *)sender{
    

  [HLTiMenuPlistManager shareManager].heliao_mainModeArr  = [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(!self.heliao_mode.totalSwitch) forKey:@"totalSwitch" In:self.heliao_mode.menuTag WithPath:@"TiMenu.json"];
    TIMenuMode *newMod = [HLTiMenuPlistManager shareManager].heliao_mainModeArr[self.heliao_mode.menuTag];
    _heliao_mode = newMod;
    [self.heliao_totalSwitch setSelected:newMod.totalSwitch];

    
    if (newMod.menuTag ==0)
    {
        [[TiSDKManager shareManager] setBeautyEnable:newMod.totalSwitch];
    }
    else if(newMod.menuTag==1)
    {
        [[TiSDKManager shareManager] setFaceTrimEnable:newMod.totalSwitch];
    }
    else if(newMod.menuTag==12)
    {
        [[TiSDKManager shareManager] setMakeupEnable:newMod.totalSwitch];
    }
    
}

- (void)setHeliao_mode:(TIMenuMode *)mode{
    if (mode) {

       _heliao_mode = mode;
        [self.heliao_totalSwitch heliao_setTitle:[NSString stringWithFormat:@"%@:关",mode.name] withImage:[UIImage imageNamed:@"btn_close"] withTextColor:TI_Color_Default_Text_Black forState:UIControlStateNormal];
        [self.heliao_totalSwitch heliao_setTitle:[NSString stringWithFormat:@"%@:开",mode.name] withImage:[UIImage imageNamed:@"btn_open"] withTextColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
        [self.heliao_totalSwitch setSelected:mode.totalSwitch];
        
        [self.heliao_menuCollectionView reloadData];
    }
    
}


- (void)heliao_getLoginState {
    NSLog(@"Get Info Success");
}
@end
