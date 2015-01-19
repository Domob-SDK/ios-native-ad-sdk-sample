//
//  PhotoFlowViewController.h
//  DMNativeAdDemo
//

   

#import <UIKit/UIKit.h>

@interface PhotoFlowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *listTable;
@property (strong, nonatomic) NSMutableArray *dataArray;


@end
