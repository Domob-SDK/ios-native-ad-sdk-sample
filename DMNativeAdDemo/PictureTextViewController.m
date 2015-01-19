//
//  PictureTextViewController.m
//  DMNativeAdDemo
//
 

#import "PictureTextViewController.h"
#import "PictureTextTableViewCell.h"
#import "UIColor+TKCategory.h"
#import "XMLParsing.h"
#import "ModelItem.h"
#import "UIImageView+WebCache.h"
#import "Constant.h"
#import "RefreshControl.h"

@interface PictureTextViewController ()<XMLParsingDelegate,DMNativeAdDelegate,RefreshControlDelegate>

@property (nonatomic, strong) XMLParsing *parsing;

@property (nonatomic, strong) DMNativeAd *nativeAd;

@property (nonatomic, assign) int num;

@property (nonatomic,strong)RefreshControl * refreshControl;

@property (nonatomic, strong) NSMutableArray *tmpArray;

@end

@implementation PictureTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"图文列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#ff498c"]];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    CGRect frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height);
    
    self.listTable = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.listTable.delegate = self;
    self.listTable.dataSource = self;
    self.listTable.backgroundColor = [UIColor clearColor];
    self.listTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.listTable];

    self.parsing = [[XMLParsing alloc] init];
    self.parsing.delegate = self;
    
    self.num = 0;

    //数据处理
    [self.parsing getXML];
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:self.listTable delegate:self];
    _refreshControl.topEnabled=YES;
    _refreshControl.bottomEnabled=YES;
    
}


//加载Native广告
- (void)createNativeAd
{
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];

    self.nativeAd = [[DMNativeAd alloc] initWithPublisherId:PUBLIHSER_ID
                                            placementId:PICTURETEXT_PLACEMENT_ID
                                     rootViewController:controller
                                               delegate:self];
    
    [self.nativeAd loadAd];

}

#pragma mark -
#pragma mark UITableViewDelegate  DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 112.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    PictureTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PictureTextTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
        UINib *nib = [UINib nibWithNibName:@"PictureTextTableViewCell" bundle:[NSBundle mainBundle]];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:cellIdentifier];
    }
    
    if (self.dataArray.count != 0) {
        ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
        if (item.isNativeAd) {
            cell.isNativeAd = item.isNativeAd;
            cell.nativeitem = item.nativeData;
            cell.titleLabel.text = item.nativeData.nativeModel.adTitle;
            cell.infoLabel.text = item.nativeData.nativeModel.adBrief;
            [cell.titleImgView sd_setImageWithURL:[NSURL URLWithString:item.nativeData.nativeModel.adMedia.adUrl]];
            cell.parametersLabel.text = @"推广";
#warning DMNativeAd的展现报告需要在展现时发送
            //DMNativeAd的展现报告
            [item.nativeData trackImpression];
            
            
        }else{
            cell.titleLabel.text = item.titleItem;
            cell.infoLabel.text = item.descriptionItem;
            cell.parametersLabel.text = item.pubDate;
        }

    }
    
    if ([indexPath row] == 3+5*self.num) {
        
        [self createNativeAd];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
    
    if (item.isNativeAd) {
#warning DMNativeAd的点击事件
        //DMNativeAd的点击事件处理
        [item.nativeData processClickAction];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"点击"
                                                        message:@"您点击的是新闻"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) parsingSuccessfulWithArray:(NSArray *)array
{
    self.tmpArray = [[NSMutableArray alloc] initWithArray:array];
    self.dataArray = self.tmpArray;
    
    [self.refreshControl finishRefreshingDirection:RefreshDirectionTop];

    [self.listTable reloadData];
}

- (void) parsingError
{
    NSLog(@"parsingError");
}

#pragma mark -
#pragma mark NativeAdDelegate
- (void)dmNativeAdSuccessToLoadAd:(DMNativeAdModel *)adDataModel
{
  
    [self.nativeAd setNativeModel:adDataModel];
    
    ModelItem *item = [[ModelItem alloc] init];
    [item setNativeData:self.nativeAd];
    item.isNativeAd = YES;
    
    if ([self.dataArray count] > (3+5*self.num -1)) {
        [self.dataArray insertObject:item atIndex:(3+5*self.num)];
    }else{
        [self.dataArray addObject:item];
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
    if (direction==RefreshDirectionTop)
    {
        //数据处理 清空
        [self.dataArray removeAllObjects];
        self.num = 0;
        [self.parsing getXML];
        
    }
    else if (direction==RefreshDirectionBottom)
    {
        [self.dataArray addObjectsFromArray: self.tmpArray];
        [self.listTable reloadData];
        [self.refreshControl finishRefreshingDirection:RefreshDirectionBottom];
    }
    
}

@end
