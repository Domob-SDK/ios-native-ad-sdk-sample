//
//  ViewController.m
//  DMNativeAdDemo
//
//
  

#import "ViewController.h"
#import "PictureTextViewController.h"
#import "InfoFlowViewController.h"
#import "PhotoWallViewController.h"
#import "PhotoFlowViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0f],NSFontAttributeName, nil]];//改变导航栏的字体和颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;

}

//图文列表
- (IBAction)PictureTextAction:(id)sender {
    PictureTextViewController *pController = [[PictureTextViewController alloc] init];
    [self.navigationController pushViewController:pController animated:YES];
    
}

//信息流
- (IBAction)TableFeedsAction:(id)sender {
    InfoFlowViewController *iController = [[InfoFlowViewController alloc] init];
    [self.navigationController pushViewController:iController animated:YES];

}

//瀑布流图片墙1
- (IBAction)WaterfallsFlow:(id)sender {
    PhotoWallViewController *wController = [[PhotoWallViewController alloc] init];
    [self.navigationController pushViewController:wController animated:YES];

}
//瀑布流图片墙2
- (IBAction)WaterfallsFlowAnother:(id)sender {
    PhotoFlowViewController *wController = [[PhotoFlowViewController alloc] init];
    [self.navigationController pushViewController:wController animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
