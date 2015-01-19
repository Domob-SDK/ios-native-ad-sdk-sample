//
//  PhotoWallTableViewCell.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>
#import "DMNativeAd.h"

@interface PhotoWallTableViewCell : UITableViewCell{
    
    __weak IBOutlet UIImageView *leftImgView;
    __weak IBOutlet UIImageView *middleImgView;
    __weak IBOutlet UIImageView *rightImgView;
    
}

@property (nonatomic, strong)DMNativeAd *model1;
@property (nonatomic, strong)DMNativeAd *model2;
@property (nonatomic, strong)DMNativeAd *model3;

- (void)updatePhotoWallModel1:(id)model1
                       model2:(id)model2
                       model3:(id)model3
                          row:(NSInteger)rowIndex;

@end
