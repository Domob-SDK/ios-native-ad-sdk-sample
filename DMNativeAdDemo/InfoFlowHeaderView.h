//
//  InfoFlowHeaderView.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>

@interface InfoFlowHeaderView : UITableViewCell

@property (nonatomic, weak)IBOutlet UIImageView *titleImgView;
@property (nonatomic, weak)IBOutlet UILabel *titleLabel;
@property (nonatomic, weak)IBOutlet UILabel *infoLabel;
@property (nonatomic, weak)IBOutlet UILabel *contentLabel;
@property (nonatomic, weak)IBOutlet UIImageView *contentImgView;
@property (nonatomic, weak)IBOutlet UIButton *downloadBtn;

@end
