//
//  HLTiUIMenuThreeViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMenuThreeViewCell.h"
#import "TiConfig.h"
#import "HLTiUISubMenuThreeViewCell.h"
#import "HLTiDownloadZipManager.h"
#import "HLTiUIGreenScreensView.h"
#import "HLTiSetSDKParameters.h"

@interface HLTiUIMenuThreeViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *heliao_selectedIndexPath;
@property(nonatomic,strong) HLTiUIGreenScreensView *heliao_editGreenScreensView;
@property(nonatomic,strong) UIButton *heliao_backGreenBtn;//返回绿幕菜单

@end

static NSString *const heliao_TiUIMenuCollectionViewCellId = @"TiUIMainMenuTiUIMenuThreeViewCellId";

@implementation HLTiUIMenuThreeViewCell

- (UICollectionView *)heliao_menuCollectionView{
    if (!_heliao_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(TiUISubMenuThreeViewTiButtonWidth, TiUISubMenuThreeViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 4;//最小行间距
        layout.minimumInteritemSpacing = 10;//同一列中间隔的cell最小间距
        _heliao_menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _heliao_menuCollectionView.showsVerticalScrollIndicator = NO;
        _heliao_menuCollectionView.backgroundColor = [UIColor clearColor];
        _heliao_menuCollectionView.dataSource= self;
        _heliao_menuCollectionView.delegate = self;
        
        [_heliao_menuCollectionView registerClass:[HLTiUISubMenuThreeViewCell class] forCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId];
        
    }
    return _heliao_menuCollectionView;
}

- (HLTiUIGreenScreensView *)heliao_editGreenScreensView{
    if (!_heliao_editGreenScreensView) {
        _heliao_editGreenScreensView = [[HLTiUIGreenScreensView alloc] init];
        _heliao_editGreenScreensView.backgroundColor = [UIColor clearColor];
        [_heliao_editGreenScreensView setHidden:YES];
    }
    return _heliao_editGreenScreensView;
}

- (UIButton *)heliao_backGreenBtn{
    if (!_heliao_backGreenBtn) {
        _heliao_backGreenBtn = [[UIButton alloc] init];
        [_heliao_backGreenBtn setImage:[UIImage imageNamed:@"icon_back_white.png"] forState:UIControlStateNormal];
        [_heliao_backGreenBtn addTarget:self action:@selector(heliao_backGreen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_backGreenBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.heliao_menuCollectionView];
        [self.heliao_menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(13.5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.left.equalTo(self.contentView.mas_left).offset(12.5);
            make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        }];
        
        [self.contentView addSubview:self.heliao_editGreenScreensView];
        [self.heliao_editGreenScreensView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(13.5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.left.equalTo(self.contentView.mas_left).offset(12.5);
            make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        }];
        
        [self.heliao_editGreenScreensView addSubview:self.heliao_backGreenBtn];
        [self.heliao_backGreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.heliao_editGreenScreensView).offset(19);
            make.bottom.equalTo(self.heliao_editGreenScreensView.mas_bottom).offset(-16);
            make.width.height.equalTo(@18);
        }];
        
        //注册通知——通知当前是否启用第三套手势（绿幕编辑）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_isThirdGesture:) name:@"NotificationName_TiUIMenuThreeViewCell_isThirdGesture" object:nil];
        
    }
    return self;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    switch (self.heliao_mode.menuTag) {
        case 2:
            return [HLTiMenuPlistManager shareManager].heliao_stickersModeArr.count;
            break;
        case 3:
            return [HLTiMenuPlistManager shareManager].heliao_giftModeArr.count;
            break;
        case 7:
            return [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr.count;
            break;
        case 8:
            return [HLTiMenuPlistManager shareManager].heliao_masksModeArr.count;
            break;
        case 9:
            return [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr.count;
            break;
        case 11:
            return [HLTiMenuPlistManager shareManager].heliao_interactionsArr.count;
            break;
        case 14:
            return [HLTiMenuPlistManager shareManager].heliao_portraitsModArr.count;
            break;
        case 16:
            return [HLTiMenuPlistManager shareManager].heliao_gesturesModArr.count;
            break;
        default:
            return 0;
            break;
    }
    
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   HLTiUISubMenuThreeViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    TIMenuMode *subMod = nil;
    switch (self.heliao_mode.menuTag) {
        case 2:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_stickersModeArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:2];
        }
            break;
        case 3:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_giftModeArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:3];
        }
            break;
        case 7:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:7];
        }
            break;
        case 8:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_masksModeArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:8];
        }
            break;
        case 9:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:9];
        }
            break;
        case 11:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_interactionsArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:11];
        }
            break;
        case 14:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_portraitsModArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:14];
        }
            break;
        case 16:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_gesturesModArr[indexPath.row];
            [cell heliao_setSubMod:subMod WithTag:16];
        }
            break;
        default:
            break;
    }
    if (subMod.selected)
    {
        self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    }
    return cell;
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.heliao_selectedIndexPath.row==indexPath.row) {
        return;//选中同一个cell不做处理
    }
    switch (self.heliao_mode.menuTag) {
        case 2:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_stickersModeArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_stickersModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiStickers.json"];
                [HLTiMenuPlistManager shareManager].heliao_stickersModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiStickers.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setStickerName:mode.name];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_stickersModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiStickers.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_TYPE_Sticker MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                        // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_stickersModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiStickers.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 3:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_giftModeArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_giftModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiGifts.json"];
                [HLTiMenuPlistManager shareManager].heliao_giftModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiGifts.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setGift:mode.name];
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_giftModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGifts.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Gift MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                        // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_giftModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGifts.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 7:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiWaterMarks.json"];
                [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiWaterMarks.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                if (indexPath.row)
                {
                    [[TiSDKManager shareManager] setWatermark:YES Left:(int)mode.x Top:(int)mode.y Ratio:(int)mode.ratio FileName:mode.name];
                }else{
                    [[TiSDKManager shareManager] setWatermark:NO Left:0 Top:0 Ratio:0 FileName:@"watermark.png"];
                }
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr  = [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiWaterMarks.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Watermark MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                        // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                        }else{
                            state = TI_DOWNLOAD_STATE_NOTBEGUN;
                        }
                        [HLTiMenuPlistManager shareManager].heliao_watermarksModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiWaterMarks.json"];
                        [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 8:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_masksModeArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_masksModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiMasks.json"];
                [HLTiMenuPlistManager shareManager].heliao_masksModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiMasks.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setMask:mode.name];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_masksModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiMasks.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                  WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Mask MenuMode:mode completeBlock:^(BOOL successful) {
                       DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                       if (successful) {
                           // 开始下载
                           state = TI_DOWNLOAD_STATE_CCOMPLET;
                       }else{
                           state = TI_DOWNLOAD_STATE_NOTBEGUN;
                       }
                    [HLTiMenuPlistManager shareManager].heliao_masksModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiMasks.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 9:
        {
            TIMenuMode *editMode = [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr[1];
            NSIndexPath *editPath = [NSIndexPath indexPathForRow:1 inSection:0];
            HLTiUISubMenuThreeViewCell *cell = (HLTiUISubMenuThreeViewCell *)[collectionView cellForItemAtIndexPath:editPath];
            if (indexPath.row == 1) {
                if ([cell heliao_isEdit]) {
                    [self.heliao_menuCollectionView setHidden:YES];

                    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_setEditTitle:true withName:self.heliao_mode.name];
                    [self.heliao_editGreenScreensView setHidden:NO];
                    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_setSliderTypeAndValue];

                    isswitch_greenEdit = true;
                }
                return;
            }
            if (indexPath.row == 0) {
                [cell heliao_setSubMod:editMode WithTag:9 isEnabled:NO];
            }else{
                [cell heliao_setSubMod:editMode WithTag:9 isEnabled:YES];
            }
            
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiGreenScreens.json"];
                [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiGreenScreens.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setGreenScreen:mode.name Similarity:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER] Smoothness:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER] Alpha:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGreenScreens.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Greenscreen MenuMode:mode completeBlock:^(BOOL successful) {
                   DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                if (successful) {
                    // 开始下载
                    state = TI_DOWNLOAD_STATE_CCOMPLET;
                }else{
                    state = TI_DOWNLOAD_STATE_NOTBEGUN;
                }
                    [HLTiMenuPlistManager shareManager].heliao_greenscreensModeArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGreenScreens.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
            
        }
            break;
        case 11:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_interactionsArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_interactionsArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiInteractions.json"];
                [HLTiMenuPlistManager shareManager].heliao_interactionsArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiInteractions.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setInteraction:mode.name];
                [[HLTiUIManager shareManager] heliao_setInteractionHintL:mode.hint];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_interactionsArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiInteractions.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Interactions MenuMode:mode completeBlock:^(BOOL successful) {
                       DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                       if (successful) {
                           // 开始下载
                           state = TI_DOWNLOAD_STATE_CCOMPLET;
                       }else{
                           state = TI_DOWNLOAD_STATE_NOTBEGUN;
                       }
                    [HLTiMenuPlistManager shareManager].heliao_interactionsArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiInteractions.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
            
        }
            break;
        case 14:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_portraitsModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_portraitsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPortraits.json"];
                [HLTiMenuPlistManager shareManager].heliao_portraitsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiPortraits.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setPortrait:mode.name];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_portraitsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiPortraits.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Portraits MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                        // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_portraitsModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiPortraits.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 16:
        {
            TIMenuMode *mode = [HLTiMenuPlistManager shareManager].heliao_gesturesModArr[indexPath.row];
            if (mode.downloaded==TI_DOWNLOAD_STATE_CCOMPLET){
                
                [HLTiMenuPlistManager shareManager].heliao_gesturesModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiGestures.json"];
                [HLTiMenuPlistManager shareManager].heliao_gesturesModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiGestures.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setGesture:mode.name];
                [[HLTiUIManager shareManager] heliao_setInteractionHintL:mode.hint];
                
            }else if (mode.downloaded==TI_DOWNLOAD_STATE_NOTBEGUN){
                
                // 开始下载
                [HLTiMenuPlistManager shareManager].heliao_gesturesModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(TI_DOWNLOAD_STATE_BEBEING) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGestures.json"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[HLTiDownloadZipManager shareManager] heliao_downloadSuccessedType:TI_DOWNLOAD_STATE_Gestures MenuMode:mode completeBlock:^(BOOL successful) {
                    DownloadedState state = TI_DOWNLOAD_STATE_BEBEING;
                    if (successful) {
                        // 开始下载
                        state = TI_DOWNLOAD_STATE_CCOMPLET;
                    }else{
                        state = TI_DOWNLOAD_STATE_NOTBEGUN;
                    }
                    [HLTiMenuPlistManager shareManager].heliao_gesturesModArr  =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(state) forKey:@"downloaded" In:indexPath.row WithPath:@"TiGestures.json"];
                    [weakSelf.heliao_menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        default:
            break;
    }
    
}

- (void)heliao_isThirdGesture:(NSNotification *)notification{
    
    NSNumber *isThirdN = notification.object;
    BOOL isThird =  [isThirdN boolValue];
    if (isThird) {
        [self heliao_backGreen];
    }
    
}

- (void)heliao_backGreen{
    [self.heliao_menuCollectionView setHidden:NO];

    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView heliao_setEditTitle:false withName:@""];
    [self.heliao_editGreenScreensView setHidden:YES];
    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_sliderRelatedView heliao_setSliderHidden:YES];

    isswitch_greenEdit = false;
}

- (void)setHeliao_mode:(TIMenuMode *)mode{
    if (mode) {
       _heliao_mode = mode;
      }
}

- (void)dealloc{
    //移除通知
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)heliao_getUsersMostLikedSuccess {
    NSLog(@"Continue");
}
@end
