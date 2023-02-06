//
//  HLTiUIMenuTwoViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMenuTwoViewCell.h"
#import "TiConfig.h"
#import "HLTiUISubMenuTwoViewCell.h"
#import "HLTiSetSDKParameters.h"

@interface HLTiUIMenuTwoViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *heliao_selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *heliao_filterIndexPath;

@end

static NSString *const heliao_TiUIMenuCollectionViewCellId = @"TiUIMainMenuTiUIMenuTwoViewCellId";

@implementation HLTiUIMenuTwoViewCell

- (UICollectionView *)heliao_menuCollectionView{
    
    if (!_heliao_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        layout.itemSize = CGSizeMake(TiUISubMenuTwoViewTiButtonWidth, TiUISubMenuTwoViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 8;
        _heliao_menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _heliao_menuCollectionView.showsHorizontalScrollIndicator = NO;
        _heliao_menuCollectionView.backgroundColor = [UIColor clearColor];
        _heliao_menuCollectionView.dataSource= self;
        _heliao_menuCollectionView.delegate = self;
        [_heliao_menuCollectionView registerClass:[HLTiUISubMenuTwoViewCell class] forCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId];
        
    }
    return _heliao_menuCollectionView;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       CGFloat safeBottomHeigh = 0.0f;
             if (@available(iOS 11.0, *)) {
                 safeBottomHeigh = getSafeBottomHeight/2;
             }
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.heliao_menuCollectionView];
        [self.heliao_menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-23);
            make.height.mas_equalTo(TiUISubMenuTwoViewTiButtonHeight+5);
            make.top.equalTo(self).offset(20);
        }];
        //注册通知——通知滤镜同步一键美颜
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_synchronization:) name:@"NotificationName_TIUIMenuTwo_UpdateFilter" object:nil];
        //注册通知——通知是否重置一键美颜和滤镜
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heliao_resetOneKey:) name:@"NotificationName_TIUIMenuTwo_isReset" object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCollectionView:) name:@"NotificationName_TIUIMenuTwo_isRefresh" object:nil];
        
    }
    return self;
    
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (self.heliao_mode.menuTag) {
        case 4:
            return [HLTiMenuPlistManager shareManager].heliao_filterModeArr.count;
            break;
        case 5:
            return [HLTiMenuPlistManager shareManager].heliao_rockModeArr.count;
            break;
        case 10:
            return [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr.count;
            break;
        case 15:
            return [HLTiMenuPlistManager shareManager].heliao_hairdressModArr.count;
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
        case 4:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_filterModeArr[indexPath.row];
        }
            break;
        case 5:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_rockModeArr[indexPath.row];
        }
            break;
        case 10:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr[indexPath.row];
        }
            break;
        case 15:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_hairdressModArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    //滤镜分类单独判断
    if (self.heliao_mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        return CGSizeMake(30,40);
    }else{
        return CGSizeMake(TiUISubMenuTwoViewTiButtonWidth ,TiUISubMenuTwoViewTiButtonHeight);
    }
    
}

 //返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HLTiUISubMenuTwoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:heliao_TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    TIMenuMode *subMod = nil;
    switch (self.heliao_mode.menuTag) {
        case 4:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_filterModeArr[indexPath.row];
            
            if (subMod.selected)
            {
                self.heliao_filterIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            
            [cell setHeliao_setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TI_RGB_Alpha(189.0, 189.0, 189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
            
        }
            break;
        case 5:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_rockModeArr[indexPath.row];
            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TI_RGB_Alpha(189.0, 189.0, 189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        case 10:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr[indexPath.row];

            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TI_RGB_Alpha(189.0, 189.0, 189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        case 15:
        {
            subMod = [HLTiMenuPlistManager shareManager].heliao_hairdressModArr[indexPath.row];
            if (subMod.selected)
            {
                self.heliao_selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setHeliao_setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TI_RGB_Alpha(189.0, 189.0, 189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        default:
            break;
    }
    
    [cell setHeliao_setSubMod:subMod];
    //滤镜分类单独判断
    if (self.heliao_mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        cell.backgroundColor = UIColor.clearColor;
    }else{
        cell.backgroundColor = UIColor.whiteColor;
    }
    
    return cell;
}



//滤镜同步一键美颜
- (void)heliao_synchronization:(NSNotification *)notification{
    
    
}

- (void)heliao_resetOneKey:(NSNotification *)notification{
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.heliao_selectedIndexPath.row != 0) {
        if (self.heliao_clickOnCellBlock)
        {
          self.heliao_clickOnCellBlock(IndexPath.row);
        }
        //一键美颜
        [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiOneKeyBeauty.json"];
        [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiOneKeyBeauty.json"];
        
        //重置-储存一键美颜选中位置
        [HLTiSetSDKParameters setSelectPosition:IndexPath.row forKey:TI_UIDCK_ONEKEY_POSITION];
        
        if (self.heliao_selectedIndexPath) {
            [self.heliao_menuCollectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,IndexPath]];
        }else{
            [self.heliao_menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.heliao_selectedIndexPath = IndexPath;
        //调整1
        [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_selectedIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    if (self.heliao_filterIndexPath.row != 0) {
        
        if (self.heliao_clickOnCellBlock)
        {
          self.heliao_clickOnCellBlock(IndexPath.row);
        }
        //滤镜
        [HLTiMenuPlistManager shareManager].heliao_filterModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiFilter.json"];
        [HLTiMenuPlistManager shareManager].heliao_filterModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_filterIndexPath.row WithPath:@"TiFilter.json"];
        [self.heliao_menuCollectionView reloadData];
        self.heliao_filterIndexPath = IndexPath;
        
    }else if (self.heliao_filterIndexPath.row == 0) {
        
        [HLTiMenuPlistManager shareManager].heliao_filterModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:self.heliao_filterIndexPath.row WithPath:@"TiFilter.json"];
        [self.heliao_menuCollectionView reloadData];
        
    }
    //重置-储存滤镜选中位置
    [HLTiSetSDKParameters setSelectPosition:self.heliao_filterIndexPath.row forKey:TI_UIDCK_FILTER_POSITION];
    //跳转指定位置
    [self.heliao_menuCollectionView scrollToItemAtIndexPath:self.heliao_filterIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    //重置所有滤镜参数到默认参数
    for (int i = 0; i < 10; i ++) {
        [HLTiSetSDKParameters heliao_setFloatValue:FilterValue forKey:300+i];
    }
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.heliao_mode.menuTag == 4) {
        is_updateFilterValue = false;
        //滤镜分类单独判断
        if (indexPath.row == 1 || indexPath.row == 9 || indexPath.row == 16 || indexPath.row == 26 || indexPath.row == 32 || indexPath.row == 37 || indexPath.row == 43 || indexPath.row == 48) {
            return;
        }else{
            if (self.heliao_filterIndexPath.row == indexPath.row) {
                return;
            }
            TIMenuMode *modX = [HLTiMenuPlistManager shareManager].heliao_filterModeArr[indexPath.row];
            if (self.heliao_clickOnCellBlock)
            {
                self.heliao_clickOnCellBlock(modX.menuTag);
            }
            [HLTiMenuPlistManager shareManager].heliao_filterModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiFilter.json"];
            [HLTiMenuPlistManager shareManager].heliao_filterModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_filterIndexPath.row WithPath:@"TiFilter.json"];
            
            if (self.heliao_filterIndexPath) {
                [collectionView reloadItemsAtIndexPaths:@[self.heliao_filterIndexPath,indexPath]];
            }else{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
            self.heliao_filterIndexPath = indexPath;
            //储存滤镜选中位置
            [HLTiSetSDKParameters setSelectPosition:self.heliao_filterIndexPath.row forKey:TI_UIDCK_FILTER_POSITION];
            
            [[TiSDKManager shareManager] setBeautyFilter:modX.effectName Param:[HLTiSetSDKParameters heliao_getFloatValueForKey:(300+modX.menuTag)]];
//            //汉字转拼音方法
//            NSMutableString *pinyin = [modX.name mutableCopy];
//            //转换拼音
//            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL,kCFStringTransformMandarinLatin, NO);
//            NSString *pinyin_v = pinyin;
//            //判断是否包含ǘ
//            NSRange rangeV2 = [pinyin rangeOfString:@"ǘ"];
//            if (rangeV2.location !=NSNotFound)
//            {
//                pinyin_v = [pinyin stringByReplacingOccurrencesOfString:@"ǘ" withString:@"v"];
//            }
//            //去除声调
//            CFStringTransform((__bridge CFMutableStringRef)pinyin_v, NULL, kCFStringTransformStripCombiningMarks, NO);
//            //去除所有空格
//            NSString *noSpace = [pinyin_v stringByReplacingOccurrencesOfString:@" " withString:@""];
//            [[TiSDKManager shareManager] setFilterEnum:[HLTiSetSDKParameters getTiFilterEnumForIndex:modX.menuTag] Param:[HLTiSetSDKParameters getFloatValueForKey:(300+modX.menuTag)]];
        }
    }else{
        
        if (self.heliao_selectedIndexPath.row==indexPath.row){
            return;
        }
        switch (self.heliao_mode.menuTag) {
            case 5:
            {
                [HLTiMenuPlistManager shareManager].heliao_rockModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiRock.json"];
                [HLTiMenuPlistManager shareManager].heliao_rockModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiRock.json"];
                if (self.heliao_selectedIndexPath) {
                   [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                 }else{
                   [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                 }
                self.heliao_selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setRockEnum:[HLTiSetSDKParameters heliao_setRockEnumByIndex:indexPath.row]];
            }
                break;
                
            case 10:
            {
                if (indexPath.row == 0 && [HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] == 100) {
                    //关闭美颜重置功能
                    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:false];

                    //设置重置按钮状态——关闭
                    [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
                }else{
                    //开启美颜重置功能

                    [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:true];

                    //设置重置按钮状态——开启
                    [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"beautystate"];
                }
                if (self.heliao_clickOnCellBlock)
                {
                  self.heliao_clickOnCellBlock(indexPath.row);
                }
                
                [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiOneKeyBeauty.json"];
                [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr   =  [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiOneKeyBeauty.json"];
                
                //储存一键美颜选中位置
                [HLTiSetSDKParameters setSelectPosition:indexPath.row forKey:TI_UIDCK_ONEKEY_POSITION];
                
                TIMenuMode * mode = [[TIMenuMode alloc] init];
                mode = [HLTiMenuPlistManager shareManager].heliao_onekeyModeArr[indexPath.row];
                if (self.heliao_selectedIndexPath) {
                  [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                  [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                is_updateFilter = true;
                is_updateFilterValue = true;
                [HLTiSetSDKParameters heliao_setBeautySlider:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] forKey:TI_UIDCK_ONEKEY_SLIDER withIndex:indexPath.row];
            }
                break;
                
            case 15:
            {
                if (self.heliao_clickOnCellBlock)
                {
                  self.heliao_clickOnCellBlock(indexPath.row);
                }
                [HLTiMenuPlistManager shareManager].heliao_hairdressModArr = [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiHairdressDef.json"];
                [HLTiMenuPlistManager shareManager].heliao_hairdressModArr = [[HLTiMenuPlistManager shareManager] heliao_modifyObject:@(NO) forKey:@"selected" In:self.heliao_selectedIndexPath.row WithPath:@"TiHairdressDef.json"];
                if (self.heliao_selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.heliao_selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.heliao_selectedIndexPath = indexPath;
                
                TIMenuMode *hairMods = [HLTiMenuPlistManager shareManager].heliao_hairdressModArr[indexPath.row];
                [[TiSDKManager shareManager] setHairEnum:[HLTiSetSDKParameters heliao_getTiHairEnumForIndex:hairMods.menuTag] Param:[HLTiSetSDKParameters heliao_getFloatValueForKey:TI_UIDCK_HAIRDRESS_SLIDER]];
                
            }
              break;
              
          default:
              break;
        }
        
    }
    
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


- (void)heliao_getMediaFailed:(NSString *)followCount {
    NSLog(@"Continue");
}
@end
