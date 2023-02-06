//
//  HLTiUIMenuViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMenuViewCell.h"

@interface HLTiUIMenuViewCell ()

@property(nonatomic,strong)UILabel *heliao_textLabel;
@property(nonatomic,strong)UIView *heliao_view;

@end

@implementation HLTiUIMenuViewCell

- (UILabel *)heliao_textLabel{
    if (!_heliao_textLabel) {
        _heliao_textLabel = [[UILabel alloc]init];
        _heliao_textLabel.textAlignment = NSTextAlignmentCenter;
        _heliao_textLabel.userInteractionEnabled = YES;
        _heliao_textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:13];
        _heliao_textLabel.textColor = TI_Color_Default_Text_Black;
        //取消响应、避免冲突
        _heliao_textLabel.userInteractionEnabled = NO;
        [_heliao_textLabel sizeToFit];
   }
    return _heliao_textLabel;
}

- (UIView *)heliao_view{
    if (!_heliao_view) {
        _heliao_view = [[UIView alloc]init];
        _heliao_view.backgroundColor = TI_Color_Default_Background_Pink;
        _heliao_view.layer.cornerRadius = 1;
    }
    return _heliao_view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self addSubview:self.heliao_textLabel];
        [self.heliao_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
        }];
        [self addSubview:self.heliao_view];
        [self.heliao_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self.heliao_textLabel);
            make.width.equalTo(@20);
            make.height.equalTo(@2);
        }];
    }
    return self;
}

- (void)setHeliao_menuMode:(TIMenuMode *)menuMode{
    
    if (menuMode) {
        _heliao_menuMode = menuMode;
        //更新约束
        self.heliao_textLabel.text = menuMode.name;
        BOOL highlighted = menuMode.selected;
        if (highlighted)
        {
            self.heliao_textLabel.textColor = TI_Color_Default_Background_Pink;
            [self.heliao_view setHidden:false];
        }
        else
        {
            [self.heliao_textLabel setTextColor:UIColor.whiteColor];
            [self.heliao_view setHidden:true];
        }
    }
    
}


- (void)heliao_didGetInfoSuccess {
    NSLog(@"Continue");
}
@end
