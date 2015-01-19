//
//  PicAndTextTableViewCell.h
//  DMNativeAdDemo
//
//  Created by tongle on 15/1/5.
   

#import <UIKit/UIKit.h>

@interface PicAndTextTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *descriptionInfo;
@property (strong, nonatomic) IBOutlet UILabel *dateString;

@end
