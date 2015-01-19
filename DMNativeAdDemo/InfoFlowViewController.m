//
//  InfoFlowViewController.m
//  DMNativeAdDemo
//


#import "InfoFlowViewController.h"
#import "UIColor+TKCategory.h"
#import "InfoFlowTableViewCell.h"
#import "InfoFlowHeaderView.h"
#import "DMNativeAd.h"
#import "XMLParsing.h"
#import "Constant.h"
#import "UIImageView+WebCache.h"
#import "RefreshControl.h"
#import "ModelItem.h"

#define StandardScreenSize CGSizeMake(320.f, 568.f)
#define ScreenSize [UIScreen mainScreen].bounds.size
#define DynamicValue(x) (x) * ScreenSize.width / StandardScreenSize.width

@interface InfoFlowViewController ()<XMLParsingDelegate,DMNativeAdDelegate,RefreshControlDelegate>

@property (nonatomic, strong) XMLParsing *parsing;

@property (nonatomic, strong) DMNativeAd *nativeAd;

@property (nonatomic, assign) int num;

@property (nonatomic,strong)RefreshControl * refreshControl;

@property (nonatomic, strong) NSMutableArray *tmpArray;

@end

@implementation InfoFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"信息流";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"#00baff"]];
    
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
    
    //数据处理
    [self.parsing getXML];
    
    
    self.num = 0;
    
    _refreshControl=[[RefreshControl alloc] initWithScrollView:self.listTable delegate:self];
    _refreshControl.topEnabled=YES;
    _refreshControl.bottomEnabled=YES;
    
    
    
}
//加载Native广告
- (void)createNativeAd
{
    UIViewController *controller = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    self.nativeAd = [[DMNativeAd alloc] initWithPublisherId:PUBLIHSER_ID
                                                placementId:INFOFLOW_PLACEMENT_ID
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
    
    if ([self.dataArray count] == 0) {
        return 0;
    }
    ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
    if (item.isNativeAd) {
        return 280.0;
    }else{
        NSString *text = item.descriptionItem;
        NSDictionary *attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.f],NSFontAttributeName, nil];
        CGSize labelSize = [text boundingRectWithSize:CGSizeMake(ScreenSize.width - 26, MAXFLOAT)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributeDic
                                              context:nil].size;
        return 67.f + labelSize.height + 10.f;

    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    static NSString *adIdentifier = @"adIdentifier";
    
    if ([self.dataArray count] != 0 && [self.dataArray count] >= [indexPath row]) {
        
        ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
        
        if (item.isNativeAd) {
            
            InfoFlowHeaderView *cellAd = [tableView dequeueReusableCellWithIdentifier:adIdentifier];
            
            if (cellAd == nil) {
                
                cellAd = [[[NSBundle mainBundle] loadNibNamed:@"InfoFlowHeaderView" owner:nil options:nil] objectAtIndex:0];
                
                UINib *nib = [UINib nibWithNibName:@"InfoFlowHeaderView" bundle:[NSBundle mainBundle]];
                [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:cellIdentifier];
            }
            //设置广告
            [cellAd.titleImgView sd_setImageWithURL:[NSURL URLWithString:item.nativeData.nativeModel.adIcon.adUrl]];
            [cellAd.titleLabel setText:item.nativeData.nativeModel.adTitle];
            [cellAd.contentLabel setText:item.nativeData.nativeModel.adBrief];
            [cellAd.contentImgView sd_setImageWithURL:[NSURL URLWithString:item.nativeData.nativeModel.adMedia.adUrl]];
#warning DMNativeAd的展现报告需要在展现时发送
            //DMNativeAd的展现报告
            [item.nativeData trackImpression];
            
            return cellAd;
        }else{
            //正常的内容cell
            InfoFlowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                
                cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoFlowTableViewCell" owner:nil options:nil] objectAtIndex:0];
                
                UINib *nib = [UINib nibWithNibName:@"InfoFlowTableViewCell" bundle:[NSBundle mainBundle]];
                [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:cellIdentifier];
            }
            
            ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
            cell.titleLabel.text = item.titleItem;
            cell.infoLabel.text = item.linkItem;
            cell.contentLabel.text = item.descriptionItem;
            
            if ([indexPath row] == 3+5*self.num) {
                
                [self createNativeAd];
            }
            
            
            return cell;
        }

}
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ModelItem *item = [self.dataArray objectAtIndex:[indexPath row]];
    if (item.isNativeAd) {
        DMNativeAd *tmpAd = item.nativeData;
#warning DMNativeAd的点击事件处理
        //DMNativeAd的点击事件
        [tmpAd processClickAction];
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
/*
-(void)reloadData
{
    
    for (int i=0; i<20; i++)
    {
        [self.dataArray addObject:@""];
    }
    
    [self.listTable reloadData];
    
    
    if (self.refreshControl.refreshingDirection==RefreshingDirectionTop)
    {
        [self.refreshControl finishRefreshingDirection:RefreshDirectionTop];
    }
    else if (self.refreshControl.refreshingDirection==RefreshingDirectionBottom)
    {
        [self.refreshControl finishRefreshingDirection:RefreshDirectionBottom];
        
    }
    
    
}
 */

@end
