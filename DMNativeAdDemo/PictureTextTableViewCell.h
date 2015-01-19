//
//  PictureTextTableViewCell.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>

#import "DMNativeAd.h"

@interface PictureTextTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *titleImgView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) IBOutlet UILabel *parametersLabel;
@property (nonatomic, strong) IBOutlet UIView *lineView;
@property (nonatomic, assign) BOOL isNativeAd;
@property (nonatomic, strong) DMNativeAd *nativeitem;
@end
