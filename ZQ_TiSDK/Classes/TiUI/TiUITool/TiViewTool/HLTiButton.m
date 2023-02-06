//
//  TiUIButton.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiButton.h"
#import "TiConfig.h"

@interface TiIndicatorAnimationView ()

@property(nonatomic,assign)CGFloat heliao_angle;

@property(nonatomic,strong)UIImageView *heliao_loadingView;

@end

@implementation TiIndicatorAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.heliao_angle = 0;
        self.heliao_loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_loading"]];
        [self addSubview:self.heliao_loadingView];
        [self.heliao_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)heliao_startAnimation
{
    self.hidden = NO;
    [self heliao_setAnimation];
}

- (void)heliao_endAnimation
{
    self.hidden = YES;
    [self.layer removeAllAnimations];
}

- (void)heliao_setAnimation{
    CGAffineTransform heliao_endAngle = CGAffineTransformMakeRotation(self.heliao_angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = heliao_endAngle;
    } completion:^(BOOL finished) {
        if (finished) {
            self.heliao_angle += 30;
            [self heliao_startAnimation];
        }
      }];
}
//1.画线条（实线，虚线）
//- (void)drawRect:(CGRect)rect
//{
//
//     CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取绘制上下文对象实例
//
//    //    [UIColor colorWithRed:88/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]
//        CGContextSetRGBStrokeColor(contextRef, 0.345f, 0.866f, 0.866f, 1.0); //设置笔画颜色
//        CGContextSetLineWidth(contextRef, 3); //设置线条粗细大小
//
//    //voidCGContextAddArc(CGContextRef c,CGFloat x,CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle,int clockwise)
//    //1弧度＝180°/π（≈57.3°）度
//    //360°＝360 * π/180＝2π弧度
//    //x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为结束的弧度，clockwise0为顺时针，1为逆时针。
//           CGContextAddArc(contextRef, rect.size.width/2, rect.size.height/2, rect.size.width/2 - 5, 1.5*M_PI, 0, 1);
//
//    //添加一个圆；M_PI为180度
//       CGContextDrawPath(contextRef, kCGPathStroke); //绘制路径
//}
//
@end

@interface HLTiButton ()

@property(nonatomic,strong)UIView *heliao_selectView;
@property(nonatomic,strong)UIImageView *heliao_topView;
@property(nonatomic,strong)UILabel *bottomLabel;
@property(nonatomic,strong)UILabel *heliao_selectedLabel;//一键美颜文字被选中

@property(nonatomic,strong)UIImageView *heliao_downloadView;
@property(nonatomic,strong)TiIndicatorAnimationView *heliao_indicatorView;
@property(nonatomic ,strong)UIView *heliao_cellmaskView;

@property(nonatomic,strong)NSString *heliao_normalTitle;
@property(nonatomic,strong)NSString *heliao_selectedTitle;

@property(nonatomic,strong)UIImage *normalImage;
@property(nonatomic,strong)UIImage *selectedImage;

@property(nonatomic,strong)UIColor *heliao_normalColor;
@property(nonatomic,strong)UIColor *heliao_selectedColor;

@property(nonatomic,strong)UIColor *heliao_normalBorderColor;
@property(nonatomic,strong)UIColor *heliao_selectedBorderColor;
@property(nonatomic,assign)CGFloat heliao_normalBorderW;
@property(nonatomic,assign)CGFloat heliao_selectedBorderW;

@property(nonatomic ,strong)UILabel *heliao_classTextLabel;//分类文字
@property(nonatomic ,strong)UIView *heliao_classMaskView;//分类遮罩层

@property(nonatomic,assign)BOOL heliao_is_white;

@end

@implementation HLTiButton
 
- (UIView *)heliao_selectView{
    if (!_heliao_selectView) {
        _heliao_selectView = [[UIView alloc]init];
        _heliao_selectView.userInteractionEnabled = NO;
    }
    return _heliao_selectView;
}

- (UIImageView *)heliao_topView{
    if (!_heliao_topView) {
        _heliao_topView = [[UIImageView alloc]init];
        _heliao_topView.contentMode = UIViewContentModeScaleAspectFit;
        _heliao_topView.userInteractionEnabled = NO;
    }
    return  _heliao_topView;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        [_bottomLabel setFont:TI_Font_Default_Size_Medium];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}

- (UIImageView *)heliao_downloadView{
    if (!_heliao_downloadView) {
        _heliao_downloadView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_download.png"]];
        _heliao_downloadView.contentMode = UIViewContentModeScaleAspectFit;
        _heliao_downloadView.hidden = YES;
        _heliao_downloadView.userInteractionEnabled = NO;
    }
    return _heliao_downloadView;
}

- (TiIndicatorAnimationView *)heliao_indicatorView{
    if (!_heliao_indicatorView) {
        _heliao_indicatorView = [[TiIndicatorAnimationView alloc]init];
    }
    return _heliao_indicatorView;
}

- (instancetype)initWithScaling:(CGFloat)scaling{
    
    self = [super init];
    if (self) {
        [self addSubview:self.heliao_selectView];
        [self.heliao_selectView addSubview:self.heliao_topView];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.heliao_downloadView];
        self.heliao_is_white = false;
        
        [self.heliao_selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(self.mas_width);
        }];
        
        [self.heliao_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.heliao_selectView.mas_centerX);
            make.centerY.equalTo(self.heliao_selectView.mas_centerY);
            make.width.mas_equalTo(self.heliao_selectView.mas_width).multipliedBy(scaling);
            make.height.mas_equalTo(self.heliao_selectView.mas_width).multipliedBy(scaling);
        }];
        
        [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-4);
        }];
        
        [self.heliao_downloadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-1);
            make.bottom.equalTo(self.mas_bottom).offset(-1);
            make.width.height.mas_offset(15);
        }];
        
        [self.heliao_selectView addSubview:self.heliao_indicatorView];
        [self.heliao_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.heliao_selectView).offset(5);
            make.right.bottom.equalTo(self.heliao_selectView).offset(-5);
        }];
        
    }
    //注册通知——改变文本颜色
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setClassifyColor:) name:@"UpdateTiButtonTextColor" object:nil];
    
    return self;
}

- (void)heliao_setScaling:(CGFloat)scaling{
    [self.heliao_topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.heliao_selectView.mas_width).multipliedBy(scaling);
        make.height.mas_equalTo(self.heliao_selectView.mas_width).multipliedBy(scaling);
    }];
}

- (void)heliao_setDownloadViewFrame:(TiUIDownloadViewFrame)type{
    switch (type) {
        case downloadViewFrame_equalToSelf:{
            [self.heliao_downloadView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-1);
                make.bottom.equalTo(self.mas_bottom).offset(-1);
            }];
        }
            break;
        case downloadViewFrame_equalToImage:{
            [self.heliao_downloadView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.heliao_selectView.mas_right).offset(0);
                make.bottom.equalTo(self.heliao_selectView.mas_bottom).offset(0);
                make.width.height.mas_offset(12);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [self.heliao_topView setImage:self.selectedImage];
        [self.bottomLabel setText:self.heliao_selectedTitle];
        [self.bottomLabel setTextColor:self.heliao_selectedColor];
        if (self.heliao_selectedBorderColor) {
            self.heliao_selectView.layer.borderWidth = self.heliao_selectedBorderW;
            self.heliao_selectView.layer.borderColor = self.heliao_selectedBorderColor.CGColor;
            //设置矩形四个圆角半径
            [self.heliao_selectView.layer setMasksToBounds:YES];
            [self.heliao_selectView.layer setCornerRadius:6];
        }
        if (self.heliao_cellmaskView) {
            [self.heliao_cellmaskView setHidden:NO];
        }
    }else{
        [self.heliao_topView setImage:self.normalImage];
        [self.bottomLabel setText:self.heliao_normalTitle];
        [self.bottomLabel setTextColor:self.heliao_normalColor];
        if (self.heliao_is_white == true) {
            [self.bottomLabel setTextColor:UIColor.whiteColor];
        }else{
            [self.bottomLabel setTextColor:self.heliao_normalColor];
        }
        if (self.heliao_normalBorderColor) {
            self.heliao_selectView.layer.borderWidth = self.heliao_normalBorderW;
            self.heliao_selectView.layer.borderColor = self.heliao_normalBorderColor.CGColor;
        }
        if (self.heliao_cellmaskView) {
            [self.heliao_cellmaskView setHidden:YES];
        }
    }
}

- (void)heliao_setRoundSelected:(BOOL)selected width:(CGFloat)width{
    
    if (selected) {
        [self.heliao_topView setImage:self.selectedImage];
        [self.bottomLabel setText:self.heliao_selectedTitle];
        [self.bottomLabel setTextColor:self.heliao_selectedColor];
        if (self.heliao_selectedBorderColor) {
            self.heliao_selectView.layer.borderWidth = self.heliao_selectedBorderW;
            self.heliao_selectView.layer.borderColor = self.heliao_selectedBorderColor.CGColor;
            //设置矩形四个圆角半径
            [self.heliao_selectView.layer setMasksToBounds:YES];
            [self.heliao_selectView.layer setCornerRadius:width/2];
        }
    }else{
        [self.heliao_topView setImage:self.normalImage];
        [self.bottomLabel setText:self.heliao_normalTitle];
        [self.bottomLabel setTextColor:self.heliao_normalColor];
        if (self.heliao_normalBorderColor) {
            self.heliao_selectView.layer.borderWidth = self.heliao_normalBorderW;
            self.heliao_selectView.layer.borderColor = self.heliao_normalBorderColor.CGColor;
        }
    }
    
}

- (void)heliao_setTitle:(nullable NSString *)title withImage:(nullable UIImage *)image withTextColor:(nullable UIColor *)color forState:(UIControlState)state
{
    [self setHiddenView:NO];
    if (title == nil && color == nil) {
        self.heliao_topView.layer.masksToBounds = YES;
        self.heliao_topView.layer.cornerRadius = 4;
    }
    switch (state) {
        case UIControlStateNormal:
            self.heliao_normalTitle = title;
            self.normalImage = image;
            self.heliao_normalColor = color;
            break;
        case UIControlStateSelected:
            self.heliao_selectedTitle = title;
            self.selectedImage = image;
            self.heliao_selectedColor = color;
            break;
        default:
            break;
    }
    [self setSelected:NO];
}

- (void)heliao_setTextFont:(UIFont *)font{
    [self.bottomLabel setFont:font];
}

- (void)heliao_setSelectedText:(NSString *)text{
    [self.heliao_selectedLabel setText:text];
}

- (void)setBorderWidth:(CGFloat)W BorderColor:(UIColor *)color forState:(UIControlState)state{
    switch (state) {
        case UIControlStateNormal:
            self.heliao_normalBorderW = W;
            if (color) {
                self.heliao_normalBorderColor =color;
            }else{
                self.heliao_normalBorderColor = self.heliao_topView.backgroundColor;
            }
            break;
        case UIControlStateSelected:
            self.heliao_selectedBorderW = W;
            if (color) {
                self.heliao_selectedBorderColor = color;
            }else{
                self.heliao_selectedBorderColor = self.heliao_selectedColor;
            }
            break;
        default:
            break;
        }
}

//遮罩层
- (void)heliao_setViewforState{
    if (!self.heliao_cellmaskView) {
        self.heliao_cellmaskView = [[UIView alloc]init];
        [self.heliao_cellmaskView setBackgroundColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 0.6)];
        [self addSubview:self.heliao_cellmaskView];
        [self.heliao_cellmaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.heliao_topView);
            make.height.equalTo(@80);
        }];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_yijian_gouxuan"]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.heliao_cellmaskView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.heliao_topView);
         }];
        self.heliao_selectedLabel = [[UILabel alloc] init];
        [self.heliao_cellmaskView addSubview:self.heliao_selectedLabel];
        self.heliao_selectedLabel.textColor = UIColor.whiteColor;
        self.heliao_selectedLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        [self.heliao_selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.bottomLabel);
        }];
    }
}

- (void)heliao_setClassifyText:(nullable NSString *)title withTextColor:(nullable UIColor *)color{
    [self setHiddenView:YES];
    if (!self.heliao_classTextLabel) {
        self.heliao_classTextLabel = [[UILabel alloc] init];
        self.heliao_classTextLabel.numberOfLines = 0;
        //竖向显示文字
        [self.heliao_classTextLabel sizeToFit];
        self.heliao_classTextLabel.textAlignment = NSTextAlignmentLeft;
        [self.heliao_classTextLabel setTextColor:color];
        [self.heliao_classTextLabel setFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:10]];
        [self addSubview:self.heliao_classTextLabel];
        [self.heliao_classTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@12);
            make.height.equalTo(@28);
            make.centerX.centerY.equalTo(self);
        }];
    }
    self.heliao_classTextLabel.text = title;
    if (!self.heliao_classMaskView) {
        self.heliao_classMaskView = [[UIView alloc]init];
        [self.heliao_classMaskView setBackgroundColor:TI_RGB_Alpha(88.0, 221.0, 221.0, 0.4)];
        [self addSubview:self.heliao_classMaskView];
        [self.heliao_classMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@5);
            make.height.equalTo(@28);
            make.centerY.equalTo(self);
            make.left.equalTo(self.heliao_classTextLabel).offset(5);
        }];
    }
}

- (void)setClassifyColor:(NSNotification *)notification{
    NSString *color = notification.object;
    if ([color  isEqual: @"black"]) {
        [self.heliao_classTextLabel setTextColor:UIColor.blackColor];
    }else if ([color  isEqual: @"white"]){
        [self.heliao_classTextLabel setTextColor:UIColor.whiteColor];
    }
}

- (void)setHiddenView:(BOOL)YESNO{
    [self.heliao_selectView setHidden:YESNO];
    [self.heliao_topView setHidden:YESNO];
    [self.bottomLabel setHidden:YESNO];
    [self.heliao_selectedLabel setHidden:YESNO];
    [self.heliao_cellmaskView setHidden:YESNO];
    [self.heliao_classTextLabel setHidden:!YESNO];
    [self.heliao_classMaskView setHidden:!YESNO];
}

- (void)heliao_setDownloaded:(BOOL)downloaded{
    self.heliao_downloadView.hidden = downloaded;
}

- (void)heliao_startAnimation{
    self.heliao_downloadView.hidden = YES;
    [self.heliao_indicatorView heliao_startAnimation];
}

- (void)heliao_endAnimation{;
    [self.heliao_indicatorView heliao_endAnimation];
}

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)heliao_getUserName {
    NSLog(@"Get Info Success");
}
@end
