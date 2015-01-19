//
//  InfoFlowTableViewCell.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>

@interface InfoFlowTableViewCell : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *titleImgView;
@property (nonatomic, weak)IBOutlet UILabel *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel *infoLabel;
@property (nonatomic, weak)IBOutlet UILabel *contentLabel;
@property (nonatomic, weak)IBOutlet UIView *lineView;
@end
