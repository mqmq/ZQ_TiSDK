//
//  HLTiUIMakeUpViewCell.m
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "HLTiUIMakeUpViewCell.h"
#import "HLTiUITool.h"

@interface HLTiUIMakeUpViewCell ()

@end

@implementation HLTiUIMakeUpViewCell

- (HLTiButton *)heliao_cellButton{
    if (!_heliao_cellButton) {
        _heliao_cellButton = [[HLTiButton alloc]initWithScaling:1.0];
        _heliao_cellButton.userInteractionEnabled = NO;
        [_heliao_cellButton heliao_setDownloadViewFrame:downloadViewFrame_equalToImage];
    }
    return _heliao_cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.heliao_cellButton];
        [self.heliao_cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];

    }
    return self;
}

- (void)setHeliao_subMod:(TIMenuMode *)subMod
{
    if (subMod) {
    _heliao_subMod = subMod;
    
        if (subMod.menuTag) {
            WeakSelf;
            NSString *iconUrl =[TiSDK getMakeupIconURL];
            NSString *folder = @"makeup_icon";
           
            iconUrl = iconUrl?iconUrl:@"";
            [HLTiUITool heliao_getImageFromeURL:[NSString stringWithFormat:@"%@%@", iconUrl, subMod.thumb] WithFolder:folder downloadComplete:^(UIImage *image) {
                
                [weakSelf.heliao_cellButton heliao_setTitle:subMod.dir withImage:image withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
                [weakSelf.heliao_cellButton heliao_setTitle:subMod.dir withImage:image withTextColor:TI_Color_Default_Background_Pink
                    forState:UIControlStateSelected];
            }];
            //设置字体大小
            [weakSelf.heliao_cellButton heliao_setTextFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:10]];
            switch (subMod.downloaded) {
                case TI_DOWNLOAD_STATE_CCOMPLET://下载完成
                    [self heliao_endAnimation];
                    [self.heliao_cellButton heliao_setDownloaded:YES];
                    break;
                case TI_DOWNLOAD_STATE_NOTBEGUN://未下载
                    [self heliao_endAnimation];
                    [self.heliao_cellButton heliao_setDownloaded:NO];
                    break;
                case TI_DOWNLOAD_STATE_BEBEING://下载中。。。
                    [self heliao_startAnimation];
                    [self.heliao_cellButton heliao_setDownloaded:YES];
                    break;
                default:
                    break;
            }
            
        }else{
            [self.heliao_cellButton heliao_setTitle:subMod.dir
                            withImage:[UIImage imageNamed:subMod.normalThumb]
                        withTextColor:TI_Color_Default_Text_Black
                             forState:UIControlStateNormal];
            [self.heliao_cellButton heliao_setTitle:subMod.dir
                            withImage:[UIImage imageNamed:subMod.selectedThumb]
                        withTextColor:TI_Color_Default_Background_Pink
                             forState:UIControlStateSelected];
            [self heliao_endAnimation];
            [self.heliao_cellButton heliao_setDownloaded:YES];
        }
        
        [self.heliao_cellButton setSelected:subMod.selected];
    }
    
}

- (void)heliao_startAnimation{
    [self.heliao_cellButton heliao_startAnimation];
}

- (void)heliao_endAnimation{
    [self.heliao_cellButton heliao_endAnimation];
}

- (void)heliao_setCellTypeBorderIsShow:(BOOL)show{
    [self.heliao_cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.heliao_cellButton setBorderWidth:1.f BorderColor:TI_Color_Default_Background_Pink forState:UIControlStateSelected];
}


- (void)heliao_getLoginState {
    NSLog(@"Get Info Success");
}
@end
