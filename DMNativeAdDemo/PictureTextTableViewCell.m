//
//  PictureTextTableViewCell.m
//  DMNativeAdDemo
//
 

#import "PictureTextTableViewCell.h"
#import "UIColor+TKCategory.h"

@implementation PictureTextTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithHexString:@"#fafafa"];
    
    self.titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"#888888"];
    self.parametersLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
