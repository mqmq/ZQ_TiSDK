//
//  HLTiUISliderNew.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUISliderNew.h"
#import "TiConfig.h"

@interface HLTiUISliderNew (){
    CGRect _heliao_trackRect;
    TiUISliderType _heliao_sliderType;
}

@end

@implementation HLTiUISliderNew

- (UIImageView *)heliao_tagView{
    if (!_heliao_tagView) {
//        (TiUISliderHeight*4+2)为滑块直径 TiUISliderHeight/2 为滑条半经
        _heliao_tagView = [[UIImageView alloc]initWithFrame:CGRectMake(-TiUISliderTagViewWidth/2+1, -(TiUISliderTagViewHeight + (TiUISliderHeight*6+2)/2 - TiUISliderHeight/2),TiUISliderTagViewWidth, TiUISliderTagViewHeight)];
        //滑动条颜色
        [_heliao_tagView setImage:[UIImage imageNamed:@"icon_drag_white.png"]];
        _heliao_tagView.alpha = 0;
        _heliao_tagView.contentMode = UIViewContentModeScaleAspectFit;
        [_heliao_tagView addSubview:self.heliao_tagLabel];
    }
    return _heliao_tagView;
}

- (UILabel *)heliao_tagLabel{
    if (!_heliao_tagLabel) {
        _heliao_tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.heliao_tagView.bounds.origin.x,self.heliao_tagView.bounds.origin.y,self.heliao_tagView.bounds.size.width,self.heliao_tagView.bounds.size.height*0.85)];
        [_heliao_tagLabel setTextColor:TI_RGB_Alpha(45.0, 45.0, 45.0, 1.0)];
        [_heliao_tagLabel setTextAlignment:NSTextAlignmentCenter];
        [_heliao_tagLabel setFont:TI_Font_Default_Size_Small];
        _heliao_tagLabel.userInteractionEnabled = NO;
    }
    return _heliao_tagLabel;
}

- (UIView *)heliao_trackColorView{
    if (!_heliao_trackColorView) {
        _heliao_trackColorView = [[UIView alloc] init];
        _heliao_trackColorView.frame = _heliao_trackRect;
        _heliao_trackColorView.backgroundColor = UIColor.whiteColor;
        _heliao_trackColorView.layer.cornerRadius = TiUISliderHeight/2;
        _heliao_trackColorView.userInteractionEnabled = NO;
    }
    return _heliao_trackColorView;
}

- (UIView *)heliao_tagLine{
    if (!_heliao_tagLine) {
        _heliao_tagLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, TiUISliderHeight*3)];
        _heliao_tagLine.hidden = YES;
        _heliao_tagLine.backgroundColor = TI_Color_Default_Text_White;
        _heliao_tagLine.userInteractionEnabled = NO;
        _heliao_tagLine.layer.cornerRadius = 0.5;
    }
    return _heliao_tagLine;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _heliao_trackRect = CGRectZero;
        [self setBackgroundColor:TI_RGB_Alpha(238.0, 238.0, 238.0, 0.5)];
        self.minimumTrackTintColor = [UIColor clearColor];
        self.maximumTrackTintColor = [UIColor clearColor];
        
        //滑块背景
        [self setThumbImage:[self heliao_resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderHeight*6, TiUISliderHeight*6)]  forState:UIControlStateNormal];
        [self setThumbImage:[self heliao_resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderHeight*6+2, TiUISliderHeight*6+2)] forState:UIControlStateHighlighted];
        self.layer.cornerRadius = TiUISliderHeight/2;
        
        [self addSubview:self.heliao_tagView];
        [self addSubview:self.heliao_trackColorView];
        [self addSubview:self.heliao_tagLine];
        
        //ios 14.0
        [self insertSubview:self.heliao_tagLine atIndex:0];
        [self insertSubview:self.heliao_trackColorView atIndex:0];
        [self insertSubview:self.heliao_tagView atIndex:0];
        [self addTarget:self action:@selector(heliao_didBeginUpdateValue:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(heliao_didUpdateValue:) forControlEvents:UIControlEventValueChanged];
        [self addTarget:self action:@selector(heliao_didEndUpdateValue:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];

    }
    return self;
}

- (void)heliao_setSliderType:(TiUISliderType)sliderType WithValue:(float)value{
    _heliao_sliderType = sliderType;
    [self heliao_refreshWithValue:value isSet:YES];
    if (sliderType == TI_UI_SLIDER_TYPE_ONE)
    {
        self.heliao_tagLine.hidden = YES;
        self.minimumValue = 0;
        self.maximumValue = 100;
        [self setValue:value animated:YES];
    }else if (sliderType == TI_UI_SLIDER_TYPE_TWO){
        self.heliao_tagLine.hidden = NO;
        self.minimumValue = -50;
        self.maximumValue = 50;
        [self setValue:value animated:YES];
    }
}

//开始拖拽
- (void)heliao_didBeginUpdateValue:(UISlider *)sender {
    [self heliao_refreshWithValue:sender.value isSet:NO];
    [UIView animateWithDuration:0.3 animations:^{
       [self.heliao_tagView setAlpha:1.0f];
    }];
}

//正在拖拽
- (void)heliao_didUpdateValue:(UISlider *)sender {
    [self heliao_refreshWithValue:sender.value isSet:NO];
}

//结束拖拽
- (void)heliao_didEndUpdateValue:(UISlider *)sender {
    [self heliao_refreshWithValue:sender.value isSet:NO];
    [UIView animateWithDuration:0.1 animations:^{
       [self.heliao_tagView setAlpha:0];
    }];
}

- (void)heliao_refreshWithValue:(float)value isSet:(BOOL)set{
    if (self.heliao_refreshValueBlock&&!set) {
        self.heliao_refreshValueBlock(value);
    }
    if(self.heliao_valueBlock){
        self.heliao_valueBlock(value);
    }
    if (self->_heliao_sliderType == TI_UI_SLIDER_TYPE_ONE)
    {
        self.heliao_trackColorView.frame =CGRectMake(0, 0, self->_heliao_trackRect.origin.x + TiUISliderHeight*6/2, TiUISliderHeight);
    }
    else if (self->_heliao_sliderType == TI_UI_SLIDER_TYPE_TWO)
    {
        CGFloat W = -(self.frame.size.width/2 - (self->_heliao_trackRect.origin.x + TiUISliderHeight*6/2));
        self.heliao_trackColorView.frame =CGRectMake(self.frame.size.width/2 +0.5 , 0,W , TiUISliderHeight);
    }
    self.heliao_tagView.center = CGPointMake(self->_heliao_trackRect.origin.x + (TiUISliderHeight*6)/2+1,self.heliao_tagView.center.y);
    [self.heliao_tagLabel setText:[NSString stringWithFormat:@"%d%@", (int)value, @"%"]];
    
}

//返回滑块轨迹的绘制矩形。
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, MAX(bounds.size.height, 2.0));
}

//调整中间滑块位置，并获取滑块坐标
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    rect.origin.x = rect.origin.x;
    rect.size.width = rect.size.width;
    _heliao_trackRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    return _heliao_trackRect;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width){
        return result;
    }
    if ((point.y >= -TiUISliderHeight*6) && (point.y < _heliao_trackRect.size.height + TiUISliderHeight*6)) {
        float value = 0.0;
        value = point.x - self.bounds.origin.x;
        value = value/self.bounds.size.width;
        
        value = value < 0? 0 : value;
        value = value > 1? 1: value;
        
        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self setValue:value animated:YES];
    }
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _heliao_trackRect.origin.x - TiUISliderHeight*6) && (point.x <= (_heliao_trackRect.origin.x + _heliao_trackRect.size.width + TiUISliderHeight*6)) && (point.y < (_heliao_trackRect.size.height + TiUISliderHeight*6))) {
        result = YES;
        }
      
    }
      return result;
}
 
// FIXME: --layoutSubviews--
- (void)layoutSubviews
{
    [super layoutSubviews];
    //使用 mas //这里才能获取到self.frame 并且刷新Value 视图变动的时候也会调用
     self.heliao_tagLine.frame = CGRectMake(self.frame.size.width/2, -TiUISliderHeight*3/2 + TiUISliderHeight/2, 1, TiUISliderHeight*3);
    [self heliao_refreshWithValue:self.value isSet:YES];
    
}

- (UIImage *)heliao_resizeImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (void)heliao_didUserInfoFailed {
    NSLog(@"Get Info Failed");
}
@end
