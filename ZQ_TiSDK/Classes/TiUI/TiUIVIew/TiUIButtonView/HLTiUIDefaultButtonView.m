//
//  HLTiUIDefaultButtonView.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIDefaultButtonView.h"
#import "TiConfig.h"

@interface HLTiUIDefaultButtonView ()


@end

@implementation HLTiUIDefaultButtonView

// MARK: --懒加载--
-(UIButton *)heliao_mainSwitchButton{
    if (!_heliao_mainSwitchButton){
        _heliao_mainSwitchButton = [[UIButton alloc] init];
        [_heliao_mainSwitchButton setTag:0];
        [_heliao_mainSwitchButton setImage:[UIImage imageNamed:@"icon_gongneng_white.png"] forState:UIControlStateNormal];
        [_heliao_mainSwitchButton addTarget:self action:@selector(heliao_onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_mainSwitchButton;
}

-(UIButton *)heliao_cameraCaptureButton{
    if (!_heliao_cameraCaptureButton) {
        _heliao_cameraCaptureButton = [[UIButton alloc] init];
        [_heliao_cameraCaptureButton setTag:1];
        [_heliao_cameraCaptureButton setImage:[UIImage imageNamed:@"btn_paizhao.png"] forState:UIControlStateNormal];
        [_heliao_cameraCaptureButton setImage:[UIImage imageNamed:@"btn_paizhao.png"] forState:UIControlStateSelected];
              [_heliao_cameraCaptureButton addTarget:self action:@selector(heliao_onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_cameraCaptureButton;
}

-(UIButton *)heliao_switchCameraButton{
    if (!_heliao_switchCameraButton) {
        _heliao_switchCameraButton = [[UIButton alloc] init];
        [_heliao_switchCameraButton setTag:2];
        [_heliao_switchCameraButton setImage:[UIImage imageNamed:@"icon_fanzhuan_white.png"] forState:UIControlStateNormal];
        [_heliao_switchCameraButton addTarget:self action:@selector(heliao_onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _heliao_switchCameraButton;
}

-(UIButton *)heliao_TiDemoBtn{
    if (!_heliao_TiDemoBtn) {
        _heliao_TiDemoBtn = [[UIButton alloc] init];
        [_heliao_TiDemoBtn setTag:3];
        [_heliao_TiDemoBtn setImage:[UIImage imageNamed:@"btn_gongneng_rukou.png"] forState:UIControlStateNormal];
        [_heliao_TiDemoBtn addTarget:self action:@selector(heliao_onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_heliao_TiDemoBtn setHidden:YES];
        [_heliao_TiDemoBtn setEnabled:NO];
    }
    return _heliao_TiDemoBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self heliao_initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self heliao_initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self heliao_initView];
    }
    return self;
}

-(void)heliao_initView{
    [self addSubview:self.heliao_mainSwitchButton];
    [self addSubview:self.heliao_cameraCaptureButton];
    [self addSubview:self.heliao_switchCameraButton];
    [self addSubview:self.heliao_TiDemoBtn];
    
    [self.heliao_mainSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(DefaultButton_WIDTH/2.5);
        make.top.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(DefaultButton_WIDTH-DefaultButton_WIDTH/2);
    }];
    [self.heliao_cameraCaptureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY).with.offset(-30);
        make.width.height.mas_equalTo(DefaultButton_WIDTH);
    }];
    [self.heliao_switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-DefaultButton_WIDTH/2.5);
        make.top.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(DefaultButton_WIDTH-DefaultButton_WIDTH/2);
    }];
    [self.heliao_TiDemoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-14);
        make.bottom.equalTo(self).offset((44-SCREEN_HEIGHT)/2);
        make.width.height.equalTo(@44);
    }];
    [self heliao_setDemoLayout];
}

//演示demo 调用此方法
-(void)heliao_setDemoLayout{
    [self.heliao_mainSwitchButton setHidden:YES];
    [self.heliao_cameraCaptureButton setHidden:YES];
    [self.heliao_switchCameraButton setHidden:YES];
    [self.heliao_TiDemoBtn setHidden:NO];
    [self.heliao_TiDemoBtn setEnabled:YES];
}

-(void)heliao_onButtonClick:(UIButton *)button{
    if (self.heliao_onClickBlock) {
       self.heliao_onClickBlock(button.tag);
    }
     
}

//让超出父控件的方法触发响应事件
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    //避免遮挡底部UI
    if (view == self) {
        return nil;
    }
    if (!view) {
        //转换坐标系
        CGPoint newPointYes = [self.heliao_TiDemoBtn convertPoint:point fromView:self];
        //判断触摸点是否在button上
        if (CGRectContainsPoint(self.heliao_TiDemoBtn.bounds, newPointYes)) {
            //resetYesBtn就是我们想点击的控件，让这个控件作为可点击的view返回
            view = self.heliao_TiDemoBtn;
        }
    }
    return view;
}


- (void)heliao_getMediaFailed {
    NSLog(@"Get User Succrss");
}
@end
