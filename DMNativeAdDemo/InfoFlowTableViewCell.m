//
//  InfoFlowTableViewCell.m
//  DMNativeAdDemo
//
 

#import "InfoFlowTableViewCell.h"
#import "UIColor+TKCategory.h"

@implementation InfoFlowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSeparatorStyleNone;

    self.titleLabel.textColor = [UIColor blackColor];
    self.infoLabel.textColor = [UIColor colorWithHexString:@"#555555"];
    self.contentLabel.textColor = [UIColor blackColor];
    
    self.lineView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
