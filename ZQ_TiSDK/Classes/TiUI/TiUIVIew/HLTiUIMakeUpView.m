//
//  HLTiUIMakeUpView.m
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/1.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMakeUpView.h"
#import "TiConfig.h"
#import "HLTiUIMakeUpViewCell.h"
#import "HLTiDownloadZipManager.h"
#import "HLTiSetSDKParameters.h"

bool heliao_Default_is_Null = true;
bool heliao_makeup_is_reset = false;

static NSString *const heliao_TiUIMenuCollectionViewCellId = @"TiUIMeiZhuangViewCellId";
@interface HLTiUIMakeUpView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *heliao_selectedIndexPath;
@property(nonatomic,strong) NSDictionary *heliao_selectedStickerIndexDic;//非当前页面选中状态数组--暂用于贴纸功能
@property(nonatomic,strong) NSNumber *heliao_selectedID;//非当前页面选中状态的id

//添加退出手势的View
@property(nonatomic, strong) UIView *heliao_exitTapView;
@property(nonatomic, strong) UIWindow *heliao_window;

@end

@implementation HLTiUIMakeUpView

- (UIView *)heliao_exitTapView{
    if (!_heliao_exitTapView) {
        _heliao_exitTapView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH,SCREEN_HEIGHT - TiUIViewBoxTotalHeight )];
        _heliao_exitTapView.hidden = NO;
        _heliao_exitTapView.userInteractionEnabled = YES;
        [_heliao_exitTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heliao_onExitTap1:)]];
    }
    return _heliao_exitTapView;
}

- (UIWindow *)heliao_window{
    if (!_heliao_window) {
        _heliao_window = [self heliao_lastWindow];
    }
    return _heliao_window;
}

// MARK: --退出手势相关--
- (void)heliao_onExitTap1:(UITapGestureRecognizer *)recognizer {
    isswitch_makeup = false;
    [self heliao_setHiddenAnimation:YES];
}

- (UIButton *)heliao_backBtn{
    if (!_heliao_backBtn) {
        _heliao_backBtn = [[UIButton alloc]init];
        [_heliao_backBtn setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [_heliao_backBtn addTarget:self action:@selector(heliao_backParentMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_backBtn;
}

- (UIButton *)heliao_defaultBtn{
    if (!_heliao_defaultBtn) {
        _heliao_defaultBtn = [[UIButton alloc]init];
        [_heliao_defaultBtn addTarget:self action:@selector(heliao_defaultselected:) forControlEvents:UIControlEventTouchUpInside];
        [_heliao_defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_normal_white.png"] forState:UIControlStateNormal];
        [_heliao_defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_selected.png"] forState:UIControlStateSelected];
        //判断默认按钮状态
        if (heliao_Default_is_Null) {
            [_heliao_defaultBtn setSelected:true];
        }else{
            [_heliao_defaultBtn setSelected:false];
        }
    }
    return _heliao_defaultBtn;
}

- (UILabel *)heliao_defaultLabel{
    if (!_heliao_defaultLabel) {
        _heliao_defaultLabel = [[UILabel alloc]init];
        //判断默认按钮状态
        if (heliao_Default_is_Null) {
            [_heliao_defaultLabel setTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0)];
        }else{
            [_heliao_defaultLabel setTextColor:UIColor.whiteColor];
        }
        _heliao_defaultLabel.textAlignment = NSTextAlignmentCenter;
        _heliao_defaultLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _heliao_defaultLabel.text = @"无";
    }
    return _heliao_defaultLabel;
}

- (void)heliao_defaultselected:(UIButton *)button{
    [self.heliao_defaultBtn setSelected:true];
    [self.heliao_defaultLabel setTextColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0)];
    WeakSelf
    if (self.heliao_clickOnCellBlock)
    {
//                    拼接标示符 1 腮红、2睫毛、3眉毛、4眼影、5眼线
//                    例示 1000 -> 腮红.自然 1000 腮红柔和。2001 睫毛剑眉
        self.heliao_clickOnCellBlock(self.heliao_mode.menuTag * 1000 + 999);
    }
    
    switch (self.heliao_mode.menuTag) {
        case 1:{//腮红

            [HLTiMenuPlistManager shareManager].heliao_blusherModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiBlusher.json"];
            self.heliao_selectedIndexPath = nil;

            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"无" forKey:@"cheekRed_default"];
            [weakSelf.heliao_menuCollectionView reloadData];
        }
            break;
        case 2:{//睫毛

            [HLTiMenuPlistManager shareManager].heliao_eyelashModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyelash.json"];
            self.heliao_selectedIndexPath = nil;

            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"无" forKey:@"eyelash_default"];
            [weakSelf.heliao_menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeLash:@"" Param:0];

        }
            break;
        case 3:{//眉毛

            [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyebrows.json"];
            self.heliao_selectedIndexPath = nil;

            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"无" forKey:@"eyebrows_default"];
            [weakSelf.heliao_menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeBrow:@"" Param:0];
            
        }
            break;
        case 4:{//眼影

            [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyeshadow.json"];
            self.heliao_selectedIndexPath = nil;

            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"无" forKey:@"eyeshadow_default"];
            [weakSelf.heliao_menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeShadow:@"" Param:0];
            
        }
            break;
        case 5:{//眼线

            [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyeline.json"];
            self.heliao_selectedIndexPath = nil;

            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"无" forKey:@"eyeLine_default"];
            [weakSelf.heliao_menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeLine:@"" Param:0];
           
        }
            break;
        default:
            self.heliao_selectedID = 0;
            break;
    }

    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView heliao_setSliderHidden:YES];

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
        layout.itemSize = CGSizeMake(62, TiUISubMenuOneViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _heliao_menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _heliao_menuCollectionView.showsHorizontalScrollIndicator = NO;
        _heliao_menuCollectionView.dataSource= self;
        _heliao_menuCollectionView.delegate = self;
        [_heliao_menuCollectionView registerClass:[HLTiUIMakeUpViewCell class] forCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId];
        _heliao_menuCollectionView.backgroundColor = [UIColor clearColor];

    }
    return _heliao_menuCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6);
        self.alpha = 0;
        [self addSubview:self.heliao_backBtn];
        [self addSubview:self.heliao_lineView];
        [self addSubview:self.heliao_menuCollectionView];
        [self addSubview:self.heliao_defaultBtn];
        [self addSubview:self.heliao_defaultLabel];
        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        [self.heliao_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).with.offset(-safeBottomHeigh);
            make.left.equalTo(self.mas_right).offset(55);
            make.width.mas_equalTo(0.25);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
        }];
        [self.heliao_menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(78);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(60-TiUIMenuViewHeight);
        }];
        [self.heliao_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.heliao_menuCollectionView).offset(13);
            make.left.equalTo(self.mas_left).offset(30);
            make.width.height.equalTo(@24);
        }];
        [self.heliao_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.heliao_defaultBtn);
            make.top.equalTo(self.heliao_menuCollectionView).offset(52);
            make.width.equalTo(@24);
            make.height.equalTo(@12);
        }];
        [self.heliao_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.heliao_defaultBtn);
            make.top.equalTo(self.heliao_menuCollectionView).offset(106);
            make.width.height.equalTo(@18);
        }];
        
        //注册通知——通知当前是否启用第二套手势（美妆）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_isTwoGesture:) name:@"NotificationName_TIUIMakeUp_isTwoGesture" object:nil];
        
    }
    
    return self;
}

- (void)heliao_isTwoGesture:(NSNotification *)notification{
    
    NSNumber *isTwoN = notification.object;
    BOOL isTwo =  [isTwoN boolValue];
    if (isTwo) {
        [self heliao_setHiddenAnimation:YES];
    }
    
}

//获取到当前所在的视图
- (UIViewController *)heliao_presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

 - (UIWindow *)heliao_lastWindow
 {
     NSArray *windows = [UIApplication sharedApplication].windows;
     for(UIWindow *window in [windows reverseObjectEnumerator]) {
     if ([window isKindOfClass:[UIWindow class]] &&
     CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
     return window;
     }
     return [UIApplication sharedApplication].keyWindow;
 }

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.heliao_mode.menuTag) {
        case 1:
            return [HLTiMenuPlistManager shareManager].heliao_blusherModArr.count;
            break;
        case 2:
            return [HLTiMenuPlistManager shareManager].heliao_eyelashModArr.count;
            break;
        case 3:
            return [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr.count;
            break;
        case 4:
            return [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr.count;
            break;
        case 5:
            return [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr.count;
            break;
        default:
            return 0;
            break;
    }
    
}

 //返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HLTiUIMakeUpViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    
    [cell heliao_setCellTypeBorderIsShow:indexPath.row!=0];
    TIMenuMode * subMod = nil;
    switch (self.heliao_mode.menuTag) {
        case 1:{
            subMod = [[HLTiMenuPlistManager shareManager].heliao_blusherModArr objectAtIndex:indexPath.row];

            [cell setHeliao_subMod:subMod];
        }
            break;
        case 2:{
          subMod = [[HLTiMenuPlistManager shareManager].heliao_eyelashModArr objectAtIndex:indexPath.row];
                        
                   [cell setHeliao_subMod:subMod];
        }
            break;
        case 3:{
           subMod = [[HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr objectAtIndex:indexPath.row];
                           
                   [cell setHeliao_subMod:subMod];
        }
            break;
        case 4:{
          subMod = [[HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr objectAtIndex:indexPath.row];
                           
                   [cell setHeliao_subMod:subMod];
        }
            break;
        case 5:{
           subMod = [[HLTiMenuPlistManager shareManager].heliao_eyeLineModArr objectAtIndex:indexPath.row];
                           
                   [cell setHeliao_subMod:subMod];
        }
            break;
        default:
            break;
    }
  
    if (subMod.selected)
     {
        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        if (self.heliao_clickOnCellBlock)
        {
            //        拼接标示符 1 腮红  2睫毛。3眉毛
            //       例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
                NSUInteger tag = self.heliao_mode.menuTag * 1000 + self.heliao_selectedIndexPath.row;
             self.heliao_clickOnCellBlock(tag);
        }
    }
    
    return cell;
         
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //判断默认按钮状态
    if(self.heliao_selectedIndexPath.row==indexPath.row && self.heliao_selectedIndexPath!=nil && !self.heliao_defaultBtn.isSelected) {
        return;//选中同一个cell不做处理
    }
    heliao_Default_is_Null = false;
    heliao_makeup_is_reset = false;
    switch (self.heliao_mode.menuTag) {
        case 1:
        {
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"腮红" forKey:@"cheekRed_default"];
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_blusherModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
            {
                [self.heliao_defaultBtn setSelected:false];
                
                [self.heliao_defaultLabel setTextColor:[UIColor whiteColor]];
                

                if (self.heliao_selectedIndexPath!=nil) {
                    [HLTiMenuPlistManager shareManager].heliao_blusherModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiBlusher.json"];

                  }
                [HLTiMenuPlistManager shareManager].heliao_blusherModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiBlusher.json"];

                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (self.heliao_clickOnCellBlock)
                {
//                    拼接标示符 1 腮红、2睫毛、3眉毛、4眼影、5眼线
//                    例示 1000 -> 腮红.自然 1000 腮红柔和。2001 睫毛剑眉
                    NSUInteger tag = self.heliao_mode.menuTag * 1000 + indexPath.row;
                    self.heliao_clickOnCellBlock(tag);
                }
            }
            else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
            {
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_blusherModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiBlusher.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_blusher MenuMode:mode completeBlock:^(BOOL successful) {
                DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                if (successful) {
                // 开始下载
                    state = TI_DOWNLOAD_STATE_CCOMPLET;
                }else{
                    state = TI_DOWNLOAD_STATE_NOTBEGUN;
                }

                [HLTiMenuPlistManager shareManager].heliao_blusherModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiBlusher.json"];
                [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
        case 2:
        {
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"睫毛" forKey:@"eyelash_default"];
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_eyelashModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
            {
                [self.heliao_defaultBtn setSelected:false];
                [self.heliao_defaultLabel setTextColor:[UIColor whiteColor]];

                if (self.heliao_selectedIndexPath!=nil) {
                    [HLTiMenuPlistManager shareManager].heliao_eyelashModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyelash.json"];
                  }
                [HLTiMenuPlistManager shareManager].heliao_eyelashModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiEyelash.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];

                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (self.heliao_clickOnCellBlock)
                {
                    NSUInteger tag = self.heliao_mode.menuTag * 1000 + indexPath.row;
                    self.heliao_clickOnCellBlock(tag);
                }
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
            {
            // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_eyelashModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyelash.json"];
                                
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyelash MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                    // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }

                    [HLTiMenuPlistManager shareManager].heliao_eyelashModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyelash.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];

                }];
            }
        }
            break;
        case 3:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"眉毛" forKey:@"eyebrows_default"];
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
            {
                [self.heliao_defaultBtn setSelected:false];
                [self.heliao_defaultLabel setTextColor:[UIColor whiteColor]];
                

                if (self.heliao_selectedIndexPath!=nil) {
                    [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyebrows.json"];

                  }
                [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiEyebrows.json"];
                
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (self.heliao_clickOnCellBlock)
                {
                    NSUInteger tag = self.heliao_mode.menuTag * 1000 + indexPath.row;
                    self.heliao_clickOnCellBlock(tag);
                }
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
            {
            // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyebrows.json"];
                                    
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyebrow MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                    // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyebrows.json"];
                                        
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
        case 4:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"眼影" forKey:@"eyeshadow_default"];
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
            {
                [self.heliao_defaultBtn setSelected:false];
                [self.heliao_defaultLabel setTextColor:[UIColor whiteColor]];

                if (self.heliao_selectedIndexPath!=nil) {
                    [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyeshadow.json"];

                  }
                [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiEyeshadow.json"];
                
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (self.heliao_clickOnCellBlock)
                {
                    NSUInteger tag = self.heliao_mode.menuTag * 1000 + indexPath.row;
                    self.heliao_clickOnCellBlock(tag);
                }
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
            {
            // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyeshadow.json"];
                                    
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyeshadow MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                    // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyeshadow.json"];
                                        
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
        case 5:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:@"眼线" forKey:@"eyeLine_default"];
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET)
            {
                [self.heliao_defaultBtn setSelected:false];
                [self.heliao_defaultLabel setTextColor:[UIColor whiteColor]];


                if (self.heliao_selectedIndexPath!=nil) {
                    [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiEyeline.json"];
                  }
                [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiEyeline.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];

                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (self.heliao_clickOnCellBlock)
                {
                    NSUInteger tag = self.heliao_mode.menuTag * 1000 + indexPath.row;
                    self.heliao_clickOnCellBlock(tag);
                }
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN)
            {
            // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyeline.json"];
                                    
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyeline MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                    // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiEyeline.json"];
                                        
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)setHeliao_mode:(TIMenuMode *)mode{
    if (mode) {
        _heliao_mode = mode;
        self.heliao_selectedIndexPath = nil;
        
        switch (mode.menuTag) {
            case 1:{
                for (int i = 0; i<[HLTiMenuPlistManager shareManager].heliao_blusherModArr.count; i++) {
                    TIMenuMode * subMod = [HLTiMenuPlistManager shareManager].heliao_blusherModArr[i];
                    if (subMod.selected) {
                        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        
                        if (self.heliao_clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.heliao_mode.menuTag * 1000 + i;
                                self.heliao_clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 2:{
                for (int i = 0; i<[HLTiMenuPlistManager shareManager].heliao_eyelashModArr.count; i++) {
                    TIMenuMode * subMod = [HLTiMenuPlistManager shareManager].heliao_eyelashModArr[i];
                    if (subMod.selected) {
                        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.heliao_clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.heliao_mode.menuTag * 1000 + i;
                                self.heliao_clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 3:{
                for (int i = 0; i<[HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr.count; i++) {
                    TIMenuMode * subMod = [HLTiMenuPlistManager shareManager].heliao_eyebrowsModArr[i];
                    if (subMod.selected) {
                        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.heliao_clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.heliao_mode.menuTag * 1000 + i;
                                self.heliao_clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 4:{
                for (int i = 0; i<[HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr.count; i++) {
                    TIMenuMode * subMod = [HLTiMenuPlistManager shareManager].heliao_eyeshadowModArr[i];
                    if (subMod.selected) {
                        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.heliao_clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.heliao_mode.menuTag * 1000 + i;
                                self.heliao_clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 5:{
                for (int i = 0; i<[HLTiMenuPlistManager shareManager].heliao_eyeLineModArr.count; i++) {
                    TIMenuMode * subMod = [HLTiMenuPlistManager shareManager].heliao_eyeLineModArr[i];
                    if (subMod.selected) {
                                           self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                                           [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.heliao_clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.heliao_mode.menuTag * 1000 + i;
                                self.heliao_clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
        
    }
    
}

- (void)heliao_backParentMenu:(HLTiButton *)sender{
    [self heliao_setHiddenAnimation:YES];
}

- (void)heliao_setHiddenAnimation:(BOOL)hidden{

    [self.heliao_exitTapView setHidden:hidden];
    [self.heliao_exitTapView removeFromSuperview];
    BOOL isSubView = [self.heliao_exitTapView isDescendantOfView:self.heliao_window];
    if (!isSubView) {
        [self.heliao_window addSubview:self.heliao_exitTapView];
    }
    self.alpha = !hidden;
    if (hidden) {
        isswitch_makeup = false;

        [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_backView setHidden:false];
        if (self.heliao_backBlock)

        {
            self.heliao_backBlock(YES);
        }
    }
    if (hidden) {
        if (self.heliao_makeupShowDisappearBlock)
       {
           //隐藏滑动条
            self.heliao_makeupShowDisappearBlock(YES);
       }
    }
     [self.heliao_menuCollectionView reloadData];
}

- (void)dealloc{
    //移除通知
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)heliao_checkUserInfo {
    NSLog(@"Check your Network");
}
@end
