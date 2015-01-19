//
//  InfoFlowViewController.h
//  DMNativeAdDemo
//
 

#import <UIKit/UIKit.h>

@interface InfoFlowViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *listTable;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
