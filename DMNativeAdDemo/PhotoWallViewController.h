//
//  PhotoWallViewController.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>

@interface PhotoWallViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *listTable;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
