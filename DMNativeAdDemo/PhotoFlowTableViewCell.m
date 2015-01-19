//
//  PhotoFlowTableViewCell.m
//  DMNativeAdDemo
//

   

#import "PhotoFlowTableViewCell.h"
#import "UIColor+TKCategory.h"
#import "UIImageView+WebCache.h"

@implementation PhotoFlowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    leftView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];
    
    middleView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];

    rightView.backgroundColor = [UIColor colorWithHexString:@"#ececec"];

    
}

- (void)updatePhotoWallModel1:(id)model1
                       model2:(id)model2
                       model3:(id)model3
                          row:(NSInteger)rowIndex{
    
    self.model1 = model1;
    self.model2 = model2;
    self.model3 = model3;
    
    [self resetModel1:leftView model:model1 tag:rowIndex*3 + 0];
    [self resetModel1:middleView model:model2 tag:rowIndex*3 + 1];
    [self resetModel1:rightView model:model3 tag: rowIndex*3 + 2];
    
}

- (void)resetModel1:(UIImageView *)selectView model:(id)model tag:(NSInteger) tag{
    
    if ([model isKindOfClass:[DMNativeAd class]]) {
        
        DMNativeAd *tmp = (DMNativeAd *)model;
        [leftView sd_setImageWithURL:[NSURL URLWithString:tmp.nativeModel.adIcon.adUrl]];
        [leftLabel setText:tmp.nativeModel.adTitle];
        [leftBtn setTitle:tmp.nativeModel.adActionText forState:UIControlStateNormal];
        leftBtn.tag = tag;
        [leftBtn addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
#warning DMNativeAd的展现报告需要在展现时发送
        //发送展现报告
        [tmp trackImpression];
        
    }else{
    if (![self isEmpty:model]) {
        
        selectView.hidden = NO;
    }else{
        
        selectView.hidden = YES;
    }
    }
}
- (void)resetModel2:(UIImageView *)selectView model:(id)model tag:(NSInteger) tag{
    
    if ([model isKindOfClass:[DMNativeAd class]]) {
        
        DMNativeAd *tmp = (DMNativeAd *)model;
        [middleView sd_setImageWithURL:[NSURL URLWithString:tmp.nativeModel.adIcon.adUrl]];
        [middleLabel setText:tmp.nativeModel.adTitle];
        [middleBtn setTitle:tmp.nativeModel.adActionText forState:UIControlStateNormal];
        middleBtn.tag = tag;
        [middleBtn addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
#warning DMNativeAd的展现报告需要在展现时发送
        //发送展现报告
        [tmp trackImpression];
        
    }else{
        if (![self isEmpty:model]) {
            
            selectView.hidden = NO;
        }else{
            
            selectView.hidden = YES;
        }
    }
}

- (void)resetModel3:(UIImageView *)selectView model:(id)model tag:(NSInteger) tag{
    
    if ([model isKindOfClass:[DMNativeAd class]]) {
        
        DMNativeAd *tmp = (DMNativeAd *)model;
        [rightView sd_setImageWithURL:[NSURL URLWithString:tmp.nativeModel.adIcon.adUrl]];
        [rightLabel setText:tmp.nativeModel.adTitle];
        [rightBtn setTitle:tmp.nativeModel.adActionText forState:UIControlStateNormal];
        rightBtn.tag = tag;
        [rightBtn addTarget:self action:@selector(modelAction:) forControlEvents:UIControlEventTouchUpInside];
#warning DMNativeAd的展现报告需要在展现时发送
        //发送展现报告
        [tmp trackImpression];
        
    }else{
        if (![self isEmpty:model]) {
            
            selectView.hidden = NO;
        }else{
            
            selectView.hidden = YES;
        }
    }
}


- (void)modelAction:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(cellDidClick:)]) {
        [self.delegate cellDidClick:btn.tag];
    }

}

#pragma mark -
#pragma mark 判断字符串是否为空
- (BOOL)isEmpty:(NSString *)str{
    
    if (str == nil || [@"" isEqualToString:str] || [@"null" isEqualToString:str]) {
        return YES;
    }
    return NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
