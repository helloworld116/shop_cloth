//
//  IndexViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IndexViewController.h"
#import "SVProgressHUD.h"
#import "NSDictionary+JSONCategories.h"
#import "AsyncImageView.h"
#import "InfomationViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "AlbumListViewController.h"

#define kImageMaxCount 3

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize imageContainer = _imageContainer;
@synthesize news = _news;
@synthesize indexContainer = _indexContainer;
@synthesize hotNews = _hotNews;
@synthesize shopAlbums = _shopAlbums;
@synthesize cycleScrollView = _cycleScrollView;
@synthesize topContainer = _topContainer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.hotNews==nil) {
        //1显示状态
        [SVProgressHUD showWithStatus:@"正在载入..."];
        //2从系统中获取一个并行队列
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //3在后台线程创建图像选择器
        dispatch_async(concurrentQueue, ^{        
            NSDictionary *data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfIndexNews];
            NSString *albumUrlString = [kUrlOfShopAlbum stringByAppendingFormat:@"%@%d",@"&currentPage=1&pageSize=",kImageMaxCount];
            NSDictionary *album = [NSDictionary dictionaryWithContentsOfJSONURLString:albumUrlString];
            //4让主线程显示图像选择器
            dispatch_async(dispatch_get_main_queue(), ^{
                self.shopAlbums = [album objectForKey:@"dataInfo"];
                NSMutableArray *dataInfo = [data objectForKey:@"dataInfo"];
                //如果没有首页新闻，显示关于我们的数据
                if ([dataInfo count] == 0) {
                    dispatch_queue_t concurrentQueue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    dispatch_async(concurrentQueue1, ^{
                        NSDictionary *data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfAboutUs];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            NSDictionary *homeNews = [data objectForKey:@"dataInfo"];
                            [self.news loadHTMLString:[homeNews objectForKey:@"memo"] baseURL:nil];
                        });
                    });
                }else {
                    self.hotNews = [[NSMutableArray alloc] init];
                    [self.hotNews addObjectsFromArray:dataInfo];
                    [self.news loadHTMLString:[[self.hotNews objectAtIndex:0] objectForKey:@"content"] baseURL:nil];
                }
                _cycleScrollView = [[XLCycleScrollView alloc] initWithFrame:self.imageContainer.bounds];
                _cycleScrollView.datasource = self;
                _cycleScrollView.delegate = self;
                [self.imageContainer addSubview:_cycleScrollView];
                
                self.news.delegate = self;
                UIScrollView * webScorllView = (UIScrollView *)[[self.news subviews] objectAtIndex:0];
                [webScorllView setBounces:NO];
                [webScorllView setShowsVerticalScrollIndicator:NO];
                self.indexContainer.bounces=NO;
                [SVProgressHUD dismiss];
            });
        });
    }
}

- (void)viewDidUnload
{
    [self setImageContainer:nil];
    [self setNews:nil];
    [self setIndexContainer:nil];
    [self setTopContainer:nil];
    [self setShopAlbums:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark- CycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return [self.shopAlbums count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    NSDictionary *album = [self.shopAlbums objectAtIndex:index];
    //小图：thumb_url,中图:img_url,大图:img_original
    NSString* name = [album objectForKey:@"img_url"];
    CGRect imageRect = self.imageContainer.bounds;
    AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame:imageRect];
    [imageView loadImage:name];
    self.cycleScrollView.labelMsg.text = [album objectForKey:@"img_desc"];
    return imageView;
}

#pragma mark- CycleScrollViewDelegate
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    AlbumListViewController *listViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"albumListViewController"];
    long long timestamp = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString* notifyName = [NSString stringWithFormat:@"albumList_%d_%qi",index,timestamp];
    listViewController.notifyName=notifyName;
    listViewController.title = @"相册列表";
    listViewController.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:listViewController animated:YES];
}

#pragma mark- UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight = webView.scrollView.contentSize.height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight+90;
    self.news.frame = newFrame;
    self.indexContainer.contentSize = CGSizeMake(self.indexContainer.contentSize.width, self.indexContainer.contentSize.height+webViewHeight+49+90);//
    
    CGRect moreRect = CGRectMake(0, self.indexContainer.contentSize.height+10, self.indexContainer.frame.size.width, 30);
    UIButton* hiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    hiddenBtn.frame = moreRect;
    [hiddenBtn addTarget:self action:@selector(moreInfomation) forControlEvents:(UIControlEventTouchUpInside)];
    UILabel* lable = [[UILabel alloc] initWithFrame:moreRect];
    lable.textAlignment = UITextAlignmentCenter;
    lable.textColor = [UIColor whiteColor];
    lable.text = @"更多资讯>>";
    lable.backgroundColor = [UIColor blackColor];
    lable.alpha = 0.4;
    [self.indexContainer addSubview:hiddenBtn];
    [self.indexContainer addSubview:lable];
    self.indexContainer.contentSize = CGSizeMake(self.indexContainer.contentSize.width, self.indexContainer.contentSize.height+60);//
    
}

-(void)moreInfomation{
    InfomationViewController *infomationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"infomationViewController"];
    infomationViewController.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:infomationViewController animated:YES];
}
@end
