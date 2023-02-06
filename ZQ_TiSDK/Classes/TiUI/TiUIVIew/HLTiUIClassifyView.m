//
//  HLTiUIClassifyView.m
//  TiFancy
//
//  Created by iMacA1002 on 2020/4/26.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIClassifyView.h"
#import "TiConfig.h"
#import "HLTiButton.h"

#define MINIMUMLINESPACING  (SCREEN_WIDTH - 4*TiUISubMenuOneViewTiButtonWidth)/5

@interface HLTiUIClassifyView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UIPageControl *heliao_pageControl;

@end

@implementation HLTiUIClassifyView

static NSString *const TiUIClassifyViewCellId = @"TiUIClassifyViewCellId";

- (NSArray *)heliao_modArr{
    if (!_heliao_modArr) {
        _heliao_modArr= @[
            @{
                @"name":@"美颜",
                @"icon":@"icon_gongneng_meiyan.png",
                @"TIMenuClassify":@[@(10),@(0),@(13),@(1)]
            },
            @{
                @"name":@"滤镜",
                @"icon":@"icon_gongneng_lvjing.png",
                @"TIMenuClassify":@[@(4),@(5),@(6)]
            },
            @{
                @"name":@"萌颜",
                @"icon":@"icon_gongneng_mengyan.png",
                @"TIMenuClassify":@[@(2),@(11),@(8),@(3),@(7),@(9),@(14),@(16),@(17)]
            },
            @{
                @"name":@"美妆",
                @"icon":@"icon_gongneng_meizhuang.png",
                @"TIMenuClassify":@[@(12),@(15)]
            },
            
        ];
    }
    return _heliao_modArr;
}

- (void)heliao_setModType{

    if (!_heliao_iconArr) {
        _heliao_iconArr = [[NSMutableArray alloc] init];
    }
    if (_heliao_iconArr.count>0) {
        [_heliao_iconArr removeAllObjects];
    }
    [_heliao_iconArr addObject:@"icon_gongneng_meiyan"];
    [_heliao_iconArr addObject:@"icon_gongneng_lvjing"];
    [_heliao_iconArr addObject:@"icon_gongneng_mengyan"];
    [_heliao_iconArr addObject:@"icon_gongneng_meizhuang"];
    _heliao_titleColor = TI_RGB_Alpha(255.0, 255.0, 255.0, 1.0);

    [_heliao_classifyMenuView reloadData];

}

- (UICollectionView *)heliao_classifyMenuView{
     if (!_heliao_classifyMenuView) {
         UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
         layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
         layout.itemSize = CGSizeMake(TiUISubMenuOneViewTiButtonWidth, TiUISubMenuOneViewTiButtonHeight);

         _heliao_classifyMenuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
         _heliao_classifyMenuView.showsHorizontalScrollIndicator = NO;
         _heliao_classifyMenuView.backgroundColor=[UIColor clearColor];
         _heliao_classifyMenuView.pagingEnabled = YES;
         _heliao_classifyMenuView.dataSource= self;
         _heliao_classifyMenuView.delegate = self;
         [_heliao_classifyMenuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:TiUIClassifyViewCellId];
         
     }
     return _heliao_classifyMenuView;
 }

- (UIPageControl *)heliao_pageControl{
    if (!_heliao_pageControl) {
        _heliao_pageControl = [[UIPageControl alloc]init];
        // 设置页码
        _heliao_pageControl.numberOfPages = 2;
        _heliao_pageControl.currentPage = 0;
        _heliao_pageControl.currentPageIndicatorTintColor = TI_RGB_Alpha(88.0, 221.0, 221.0, 1.0);
        _heliao_pageControl.pageIndicatorTintColor = TI_RGB_Alpha(189.0, 189.0, 189.0, 1.0);
        [_heliao_pageControl setHidden:YES];
    }
    return _heliao_pageControl;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 0.6)];
        
        [self heliao_setModType];
        
        [self addSubview:self.heliao_classifyMenuView];
        [self.heliao_classifyMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.right.equalTo(self);
            make.height.mas_equalTo(75);
        }];
        
        [self addSubview:self.heliao_pageControl];
        [self.heliao_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.heliao_classifyMenuView.mas_bottom).with.offset(30);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.heliao_classifyMenuView.frame.size.width;
    int page = floor((self.heliao_classifyMenuView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.heliao_pageControl.currentPage = page;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heliao_modArr.count;
}
   
 //返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIClassifyViewCellId forIndexPath:indexPath];
    //移除重新添加
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSDictionary *dic = self.heliao_modArr[indexPath.row];
    
    HLTiButton *cellBtn = [[HLTiButton alloc]initWithScaling:0.9];
    cellBtn.userInteractionEnabled = NO;
    
    NSString *name = [dic valueForKey:@"name"];
    if ([name isEqualToString:@""]) {
          [cellBtn heliao_setTitle:[dic valueForKey:@"name"] withImage:nil withTextColor:TI_Color_Default_Text_Black forState:UIControlStateNormal];
    }else{

        [cellBtn heliao_setTitle:[dic valueForKey:@"name"] withImage:[UIImage imageNamed:_heliao_iconArr[indexPath.row]] withTextColor:_heliao_titleColor forState:UIControlStateNormal];

    }
  
    [cell.contentView addSubview:cellBtn];
    [cellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(cell.contentView);
        make.left.equalTo(cell.contentView.mas_left).offset(6);
        make.right.equalTo(cell.contentView.mas_right).offset(-6);
    }];
    return cell;
  
}

// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, MINIMUMLINESPACING, 0, MINIMUMLINESPACING);
}
 
// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return MINIMUMLINESPACING;
}
  

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *name = [self.heliao_modArr[indexPath.row] objectForKey:@"name"];
    if (![name isEqualToString:@""] && ![self heliao_updateMV:name]) {
        [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_menuView.hidden = NO;
        [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_subMenuView.hidden = NO;
        NSArray *arr = [self.heliao_modArr[indexPath.row] objectForKey:@"TIMenuClassify"];
         if (_heliao_clickOnTheClassificationBlock) {
             _heliao_clickOnTheClassificationBlock(arr);

         }
         [self heliao_hiddenView];
    }
}

- (BOOL)heliao_updateMV:(NSString *)key{
    if ([key isEqual:@"美颜"]) {
        //设置重置对象
        heliao_resetObject = @"美颜";
        //判断重置按钮状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *beautystate = [defaults objectForKey:@"beautystate"];
        if ([beautystate  isEqual: @"optional"]) {

            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:true];
        }else{
            //默认不可点击
            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:false];
        }
        //显示重置按钮
        [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn.hidden = NO;

    }else if ([key isEqual:@"美妆"]){
        //设置重置对象
        heliao_resetObject = @"美妆";
        //判断重置按钮状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *makeupstate = [defaults objectForKey:@"makeupstate"];
        if ([makeupstate  isEqual: @"optional"]) {

            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:true];
        }else{
            //默认不可点击
            [[HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn setEnabled:false];
        }
        //显示重置按钮
        [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn.hidden = NO;
    }else{
        //隐藏重置按钮
        [HLTiUIManager shareManager].heliao_tiUIViewBoxView.heliao_resetBtn.hidden = YES;

    }
    if ([key  isEqual: @"萌颜"]) {
        if (_heliao_CutefaceBlock) {
            _heliao_CutefaceBlock(@"萌颜");
        }
    }else{
        if (_heliao_CutefaceBlock) {
            _heliao_CutefaceBlock(@"其他");
        }
    }
    
    return false;
}

- (void)heliao_showView{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.frame;
        rect.origin.y = 0;
        [self setFrame:rect];
       self.alpha = 1;
    }];
    
    if (self.heliao_executeShowOrHiddenBlock) {
        self.heliao_executeShowOrHiddenBlock(YES);
    }

}

- (void)heliao_hiddenView{
    CGRect rect = self.frame;
    rect.origin.y = TiUIViewBoxTotalHeight;
    [self setFrame:rect];
    self.alpha = 0;
    if (self.heliao_executeShowOrHiddenBlock) {
        self.heliao_executeShowOrHiddenBlock(NO);
    }
}


- (void)heliao_getLoginState:(NSString *)isLogin {
    NSLog(@"Get User Succrss");
}
@end
