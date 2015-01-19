//
//  PhotoWallTableViewCell.m
//  DMNativeAdDemo
//
 

#import "PhotoWallTableViewCell.h"
#import "UIImageView+WebCache.h"


@implementation PhotoWallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddleTapOne:)];
    leftImgView.userInteractionEnabled = YES;
    [leftImgView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddleTapTwo:)];
    middleImgView.userInteractionEnabled = YES;
    [middleImgView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddleTapThree:)];
    rightImgView.userInteractionEnabled = YES;
    [rightImgView addGestureRecognizer:tap3];

}

- (void)hiddleTapOne:(UIGestureRecognizer *)tap{
    if ([self.model1 isKindOfClass:[DMNativeAd class]]) {
#warning DMNativeAd的点击事件
        //NativeAd的点击事件
        [(DMNativeAd *)self.model1 processClickAction];
    }
}
- (void)hiddleTapTwo:(UIGestureRecognizer *)tap{
    if ([self.model2 isKindOfClass:[DMNativeAd class]]) {
#warning DMNativeAd的点击事件
        //NativeAd的点击事件
        [(DMNativeAd *)self.model2 processClickAction];
    }
}
- (void)hiddleTapThree:(UIGestureRecognizer *)tap{
    if ([self.model3 isKindOfClass:[DMNativeAd class]]) {
#warning DMNativeAd的点击事件
        //NativeAd的点击事件
        [(DMNativeAd *)self.model3 processClickAction];
    }
}

- (void)updatePhotoWallModel1:(id)model1
                       model2:(id)model2
                       model3:(id)model3
                          row:(NSInteger)rowIndex{
    
    self.model1 = model1;
    self.model2 = model2;
    self.model3 = model3;
    
    [self resetImgView:leftImgView model:model1 tag:1000 + rowIndex*3 + 0];
    [self resetImgView:middleImgView model:model2 tag:1000 + rowIndex*3 + 1];
    [self resetImgView:rightImgView model:model3 tag:1000 + rowIndex*3 + 2];

}

- (void)resetImgView:(UIImageView *)imgView model:(id)model tag:(NSInteger)tag {
    
    if ([model isKindOfClass:[DMNativeAd class]]) {

        DMNativeAd *tmp = (DMNativeAd *)model;
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:tmp.nativeModel.adMedia.adUrl]];
#warning DMNativeAd的展现报告需要在展现时发送
        //DMNativeAd的展现报告
        [tmp trackImpression];
        
    }else{
        if (![self isEmpty:model]) {
            
            imgView.hidden = NO;
            
        }else{
            
            imgView.hidden = YES;
        }

    }
       imgView.tag = tag;
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

}

@end
