//
//  PhotoWallViewController.m
//  DMNativeAdDemo
//


#import "PhotoWallViewController.h"
#import "UIColor+TKCategory.h"
#import "PhotoWallTableViewCell.h"
#import "RefreshControl.h"
#import "DMNativeAd.h"
#import "Constant.h"

#define StandardScreenSize CGSizeMake(414.f, 738.f)
#define ScreenSize [UIScreen mainScreen].bounds.size
#define DynamicValue(x) (x) * ScreenSize.width / StandardScreenSize.width

@interface PhotoWallViewController ()<RefreshControlDelegate,DMNativeAdDelegate>

@property (nonatomic, strong) DMNativeAd *nativeAd;

@property (nonatomic, assign) int num; //规律排序

@property (nonatomic,strong)RefreshControl * refreshControl;

@end

@implementation PhotoWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"照片墙";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#0ec7d9"]];
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
    
    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    self.listTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    self.listTable.backgroundColor = [UIColor clearColor];
    self.listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTable];
    
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:self.listTable delegate:self];
    _refreshControl.topEnabled = YES;
    _refreshControl.bottomEnabled=YES;
    
    
}

//加载Native广告
- (void)createNativeAd
{
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    self.nativeAd = [[DMNativeAd alloc] initWithPublisherId:PUBLIHSER_ID
                                                placementId:PHOTOWALL_PLACEMENT_ID
                                         rootViewController:controller
                                                   delegate:self];
    
    [self.nativeAd loadAd];
    
}
#pragma mark -
#pragma mark UITableViewDelegate  DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count%3 == 0 ? self.dataArray.count/3 : self.dataArray.count/3 + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return DynamicValue(107.f) + 7.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    PhotoWallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhotoWallTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        UINib *nib = [UINib nibWithNibName:@"PhotoWallTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:cellIdentifier];
    }
    
    id model1 = [self.dataArray objectAtIndex: indexPath.row * 3 + 0];
    id model2 = self.dataArray.count > indexPath.row * 3 + 1 ? [self.dataArray objectAtIndex: indexPath.row * 3 + 1 ] : @"";
    id model3 = self.dataArray.count > indexPath.row * 3 + 2 ? [self.dataArray objectAtIndex: indexPath.row * 3 + 2 ] : @"";
    
    [cell updatePhotoWallModel1:model1 model2:model2 model3:model3 row:indexPath.row];
    
    if ([indexPath row] == 3+5*self.num) {
        
        [self createNativeAd];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark NativeAdDelegate
- (void)dmNativeAdSuccessToLoadAd:(DMNativeAdModel *)adDataModel
{
    
    [self.nativeAd setNativeModel:adDataModel];
    
    
    if ([self.dataArray count] > (3+5*self.num -1)) {
        [self.dataArray insertObject:self.nativeAd atIndex:(3+5*self.num)];
    }else{
        [self.dataArray addObject:self.nativeAd];
    }
    
    self.num++;
    
    
    [self.listTable reloadData];
    
    
}

- (void)dmNativeAdFailToLoadAdWithError:(NSError *)error
{
    //广告数据返回失败
    NSLog(@"<Native Ad error = %@>",error);
}

#pragma RefreshControlDelegate
- (void)refreshControl:(RefreshControl *)refreshControl didEngageRefreshDirection:(RefreshDirection)direction
{
    if (direction==RefreshDirectionTop){
        self.num = 0;
        self.dataArray = [[NSMutableArray alloc] initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
        [self.listTable reloadData];
        [self.refreshControl finishRefreshingDirection:RefreshDirectionTop];
    }
    else if (direction==RefreshDirectionBottom)
    {
        [self.dataArray addObjectsFromArray: self.dataArray];
        [self.listTable reloadData];
        [self.refreshControl finishRefreshingDirection:RefreshDirectionBottom];
    }
    
}


@end
