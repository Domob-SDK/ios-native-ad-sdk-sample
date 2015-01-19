//
//  InfoFlowHeaderView.m
//  DMNativeAdDemo
//
 

#import "InfoFlowHeaderView.h"
#import "UIColor+TKCategory.h"

@implementation InfoFlowHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.titleLabel.textColor = [UIColor blackColor];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    self.contentLabel.textColor = [UIColor blackColor];
    
    self.downloadBtn.layer.borderColor = [UIColor colorWithHexString:@"#dcdcdc"].CGColor;
    self.downloadBtn.layer.borderWidth = 1.f;
    self.downloadBtn.layer.cornerRadius = 2.f;
    [self.downloadBtn setTitleColor:[UIColor colorWithHexString:@"#00baff"] forState:UIControlStateNormal];
    
}


@end
