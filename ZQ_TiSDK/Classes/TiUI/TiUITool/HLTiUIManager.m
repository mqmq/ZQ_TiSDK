//
//  HLTiUIManager.m
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIManager.h"

bool isswitch_makeup = false;
bool isswitch_greenEdit = false;

@interface HLTiUIManager ()

//添加的视图窗口
@property(nonatomic, strong) UIView *heliao_toView;

//互动贴纸提示语
@property(nonatomic, strong) UILabel *heliao_interactionHint;

@end

static HLTiUIManager *heliao_shareManager = NULL;
static dispatch_once_t heliao_token;

@implementation HLTiUIManager
// MARK: --单例初始化方法--
+ (HLTiUIManager *)shareManager {
    dispatch_once(&heliao_token, ^{
        heliao_shareManager = [[HLTiUIManager alloc] init];
    });
    return heliao_shareManager;
}

+ (void)heliao_releaseShareManager{
    heliao_token = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    heliao_shareManager = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.heliao_showsDefaultUI = NO;
    }
    return self;
}

// MARK: --懒加载--
- (UIWindow *)heliao_superWindow{
    if (!_heliao_superWindow) {
        _heliao_superWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _heliao_superWindow.windowLevel = UIWindowLevelAlert;
        _heliao_superWindow.userInteractionEnabled = YES;
        [_heliao_superWindow makeKeyAndVisible];
        _heliao_superWindow.hidden = YES;//初始隐藏
    }
    return _heliao_superWindow;
}

- (HLTiUIDefaultButtonView *)heliao_defaultButton{
    
    if (!_heliao_defaultButton) {
        _heliao_defaultButton = [[HLTiUIDefaultButtonView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TiUIViewBoxTotalHeight, SCREEN_WIDTH, TiUIViewBoxTotalHeight)];
        WeakSelf;

        [_heliao_defaultButton setHeliao_onClickBlock:^(NSInteger tag) {

            switch (tag) {
                case 0:
                case 3:
                    //显示美颜UI
                    [weakSelf heliao_showMainMenuView];
                    break;
                case 1:
                    //拍照
                    [weakSelf.delegate heliao_didClickCameraCaptureButton];
                    break;
                case 2:
                    //切换摄像头
                    [weakSelf.delegate heliao_didClickSwitchCameraButton];
                    break;
                default:
                    break;
                    
            }
            
        }];
        
    }
    return _heliao_defaultButton;
    
}

- (UIView *)heliao_exitTapView{
    if (!_heliao_exitTapView) {
        _heliao_exitTapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TiUIViewBoxTotalHeight)];
        _heliao_exitTapView.hidden = YES;
        _heliao_exitTapView.userInteractionEnabled = YES;
        [_heliao_exitTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(heliao_onExitTap:)]];
    }
    return _heliao_exitTapView;
}

- (HLTiUIMainMenuView *)heliao_tiUIViewBoxView{
    if (!_heliao_tiUIViewBoxView) {
        _heliao_tiUIViewBoxView = [[HLTiUIMainMenuView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, TiUIViewBoxTotalHeight)];
    }
    return _heliao_tiUIViewBoxView;
}

- (UILabel *)heliao_interactionHint{
    if (!_heliao_interactionHint) {
        _heliao_interactionHint = [[UILabel alloc]init];
        _heliao_interactionHint.textColor = [UIColor whiteColor];
        _heliao_interactionHint.font = [UIFont systemFontOfSize:14];
        _heliao_interactionHint.textAlignment =  NSTextAlignmentCenter;
        _heliao_interactionHint.contentMode = UIViewContentModeCenter;
        [_heliao_interactionHint sizeToFit];
    }
    return _heliao_interactionHint;
}

- (void)heliao_setInteractionHintL:(NSString *)hint{
    
    if ([hint isEqualToString:@""]||[hint isEqualToString:@"空"]) {
        [_heliao_interactionHint removeFromSuperview];
        _heliao_interactionHint = nil;
    }else{
        if (!_heliao_interactionHint) {
            if (self.heliao_toView) {
               [self.heliao_toView addSubview:self.heliao_interactionHint];
               [self.heliao_interactionHint mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.centerX.equalTo(self.heliao_toView);
                   make.centerY.equalTo(self.heliao_toView.mas_centerY).multipliedBy(1.3);
               }];
                
            }
        }
        _heliao_interactionHint.text = hint;
    }

}

// MARK: --弹出功能页UI--

- (void)heliao_showMainMenuView{
    [self heliao_hiddenAllViews:NO];
    self.heliao_tiUIViewBoxView.heliao_menuView.hidden = YES;
    self.heliao_tiUIViewBoxView.heliao_subMenuView.hidden = YES;

    [UIView animateWithDuration:0.3 animations:^{
        self.heliao_tiUIViewBoxView.frame = CGRectMake(0,SCREEN_HEIGHT- TiUIViewBoxTotalHeight, SCREEN_WIDTH , TiUIViewBoxTotalHeight);
    }];
}

// MARK: --退出手势相关--
- (void)heliao_onExitTap:(UITapGestureRecognizer *)recognizer {
    if (isswitch_greenEdit) {
        //发送通知——切换第三套手势（绿幕编辑）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TiUIMenuThreeViewCell_isThirdGesture" object:@(true)];
    }else if (isswitch_makeup) {
        //发送通知——切换第二套手势（美妆）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMakeUp_isTwoGesture" object:@(true)];
    }else{
        //判断是否出现重置功能遮罩层
        if (heliao_is_reset == false) {


            [self.heliao_tiUIViewBoxView.heliao_backView setHidden:true];
            if (!self.heliao_tiUIViewBoxView.heliao_back2Btn.hidden) {
                [self.heliao_tiUIViewBoxView.heliao_back2Btn setHidden:true];
                [self.heliao_tiUIViewBoxView.heliao_lineView setHidden:true];
            }
            if (!self.heliao_tiUIViewBoxView.heliao_resetBtn.hidden) {
                self.heliao_tiUIViewBoxView.heliao_resetBtn.hidden = YES;
            }
            if (self.heliao_tiUIViewBoxView.heliao_isClassifyShow) {

               if ([self.delegate respondsToSelector:@selector(heliao_didClickOnExitTap)]) {
                   [self.delegate heliao_didClickOnExitTap];
               }
                [self heliao_popAllViews];
            }else{

                [self.heliao_tiUIViewBoxView heliao_showClassifyView];
            }

        }
        
    }
    
}

- (void)heliao_popAllViews {
    [UIView animateWithDuration:0.3 animations:^{
         self.heliao_tiUIViewBoxView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, TiUIViewBoxTotalHeight);
    } completion:^(BOOL finished) {
        
        [self heliao_hiddenAllViews:YES];
    }];
}

- (void)heliao_hiddenAllViews:(BOOL)YESNO{
    
    self.heliao_tiUIViewBoxView.hidden = YESNO;
    self.heliao_exitTapView.hidden = YESNO;
    if (_heliao_defaultButton) {
        _heliao_defaultButton.hidden = !YESNO;
    }
    if (_heliao_superWindow) {
        _heliao_superWindow.hidden = YESNO;
    }
}

// MARK: --loadToWindow 相关代码--
- (void)heliao_loadToWindowDelegate:(id<TiUIManagerDelegate>)delegate{
  
    self.delegate = delegate;
    self.heliao_toView = self.heliao_superWindow;
    
    if (self.heliao_showsDefaultUI) {
        
        [self.heliao_superWindow addSubview:self.heliao_defaultButton];
        
    }
    
    [self.heliao_superWindow addSubview:self.heliao_exitTapView];
    [self.heliao_superWindow addSubview:self.heliao_tiUIViewBoxView];
    
}

- (void)heliao_loadToView:(UIView* )view forDelegate:(id<TiUIManagerDelegate>)delegate{
    
    self.delegate = delegate;
    
    self.heliao_toView = view;
    if (self.heliao_showsDefaultUI) {
        
        [view addSubview:self.heliao_defaultButton];
        
    }
    
    [view addSubview:self.heliao_exitTapView];
    [view addSubview:self.heliao_tiUIViewBoxView];
    
}

- (UIView*)heliao_returnLoadToViewDelegate:(id<TiUIManagerDelegate>)delegate{
    self.delegate = delegate;
    UIView *view = [UIView new];
    view.frame = [UIScreen mainScreen].bounds;
    if (self.heliao_showsDefaultUI) {
        
        [view addSubview:self.heliao_defaultButton];
        
    }
    
    [view addSubview:self.heliao_exitTapView];
    [view addSubview:self.heliao_tiUIViewBoxView];
    return view;
}

// MARK: --destroy释放 相关代码--
- (void)destroy{
    
    _heliao_interactionHint.text = @"";
    [_heliao_interactionHint removeFromSuperview];
    _heliao_interactionHint = nil;
    
    [_heliao_defaultButton removeFromSuperview];
    _heliao_defaultButton = nil;
    
    [_heliao_exitTapView removeFromSuperview];
    _heliao_exitTapView = nil;
  
    [_heliao_tiUIViewBoxView removeFromSuperview];
    _heliao_tiUIViewBoxView = nil;
    
    [_heliao_superWindow removeFromSuperview];
    _heliao_superWindow = nil;
    
    [HLTiUIManager heliao_releaseShareManager];
    
}


- (void)heliao_checkDefualtSetting {
    NSLog(@"Continue");
}
@end
