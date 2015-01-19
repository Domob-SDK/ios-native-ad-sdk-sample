//
//  PhotoFlowTableViewCell.h
//  DMNativeAdDemo
//

   

#import <UIKit/UIKit.h>
#import "DMNativeAd.h"

@protocol PhotoFlowTableViewCellDelegate <NSObject>

- (void)cellDidClick:(NSInteger)tag;

@end

@interface PhotoFlowTableViewCell : UITableViewCell{
    
    __weak IBOutlet UIImageView *leftView;
    IBOutlet UILabel *leftLabel;
    IBOutlet UIButton *leftBtn;
    
    
    __weak IBOutlet UIImageView *middleView;
    
    IBOutlet UILabel *middleLabel;
    IBOutlet UIButton *middleBtn;
    
    __weak IBOutlet UIImageView *rightView;
    IBOutlet UILabel *rightLabel;
    IBOutlet UIButton *rightBtn;
    
    
}

@property (nonatomic, weak) id<PhotoFlowTableViewCellDelegate>delegate;
@property (nonatomic, strong)DMNativeAd *model1;
@property (nonatomic, strong)DMNativeAd *model2;
@property (nonatomic, strong)DMNativeAd *model3;

- (void)updatePhotoWallModel1:(id)model1
                       model2:(id)model2
                       model3:(id)model3
                          row:(NSInteger)rowIndex;

@end
