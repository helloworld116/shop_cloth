//
//  GoodsListViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodsListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "WaterflowView.h"
#import "AsyncImageView.h"
#import "GoodsViewController.h"
#import "Goods.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"
#define NUMBER_OF_COLUMNS 3

@interface GoodsListViewController ()

@end

@implementation GoodsListViewController
@synthesize container=_container;
@synthesize imageUrls=_imageUrls;
@synthesize goodsIds=_goodsIds;
@synthesize url=_url;
@synthesize waterFlowView=_waterFlowView;
@synthesize notifyName=_notifyName;
@synthesize currentPage=_currentPage;

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
	// Do any additional setup after loading the view.
    if (self.imageUrls==nil) {
        //1显示状态
        [SVProgressHUD showWithStatus:@"正在载入..."];
        //2从系统中获取一个并行队列
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //3在后台线程创建图像选择器
        dispatch_async(concurrentQueue, ^{        
            NSString *url = [self.url stringByAppendingFormat:@"%@%u%@%u",@"&pageSize=",kDefaultPageSize,@"&currentPage=",kDefaultCurrentPage];
            NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:url];
            
            //4让主线程显示图像选择器
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data == nil) {
                   [SVProgressHUD dismissWithError:@"加载数据失败"];
                }else {
                    NSDictionary* pageInfo = [data objectForKey:@"pageInfo"];
                    int currentPage = [[pageInfo objectForKey:@"currentPage"] intValue];
                    int totalPage = [[pageInfo objectForKey:@"totalPage"] intValue];
                    NSMutableArray *countArray = [data objectForKey:@"dataInfo"];
                    if ([countArray count]==0) {
                        NSArray *views = [self.container subviews];
                        for (UIView *view in views) {
                            [view removeFromSuperview];
                        }
                        CGRect msgRect = self.container.frame;
                        msgRect.origin.y = 10.f;
                        msgRect.size.height = 20.f;
                        UILabel *label = [[UILabel alloc] initWithFrame:msgRect];
                        label.textAlignment = UITextAlignmentCenter;
                        label.text = @"该栏目下暂时没有数据哦";
                        [self.container addSubview:label];
                    }else {
                        NSDictionary* dataInfo = [data objectForKey:@"dataInfo"];
                        NSMutableArray *goods_thumbs = [dataInfo mutableArrayValueForKey:@"goods_thumb"];
                        self.imageUrls = [[NSMutableArray alloc] init];
                        [self.imageUrls addObjectsFromArray:goods_thumbs];
                        NSMutableArray *goods_ids = [dataInfo mutableArrayValueForKey:@"goods_id"];
                        self.goodsIds = [[NSMutableArray alloc] init];
                        [self.goodsIds addObjectsFromArray:goods_ids];
                        CGRect rect = self.container.bounds;
                        self.waterFlowView = [WaterflowView alloc];
                        [self.waterFlowView notificationName:self.notifyName];
                        self.waterFlowView = [self.waterFlowView initWithFrame:rect];
                        if (currentPage==totalPage) {
                            self.waterFlowView.loadingmore = NO; 
                        }else {
                            self.waterFlowView.loadingmore = YES;
                        }
                        self.waterFlowView.flowdatasource = self;
                        self.waterFlowView.flowdelegate = self;
//                    self.container.backgroundColor = [UIColor underPageBackgroundColor];
                        [self.container addSubview:self.waterFlowView];
                    }
                    [SVProgressHUD dismiss];
                }
            });
        });
    }
}

- (void)viewDidUnload
{
    [self setContainer:nil];
    self.notifyName = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark- WaterflowDataSource

- (NSInteger)numberOfColumnsInFlowView:(WaterflowView *)flowView
{
    return NUMBER_OF_COLUMNS;
}

- (NSInteger)flowView:(WaterflowView *)flowView numberOfRowsInColumn:(NSInteger)column
{
    int mode = [self.imageUrls count]%NUMBER_OF_COLUMNS;
    int div = [self.imageUrls count]/NUMBER_OF_COLUMNS;
    int result = 0;
    if (mode==0) {
        result = div; 
    }else if (column<mode) {
        result = div + 1;
    }else {
        result = div;
    }
    return result;
}

- (WaterFlowCell*)flowView:(WaterflowView *)flowView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *CellIdentifier = @"Cell";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:self.notifyName];
	if(cell == nil)
	{
		cell  = [[WaterFlowCell alloc] initWithReuseIdentifier:self.notifyName];
		
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
		imageView.layer.borderWidth = 1;
		imageView.tag = 1001;
	}
	float height = [self flowView:nil heightForRowAtIndexPath:indexPath];
	AsyncImageView *imageView  = (AsyncImageView *)[cell viewWithTag:1001];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width / NUMBER_OF_COLUMNS, height);
    [imageView loadImage:[self.imageUrls objectAtIndex:((indexPath.row)*NUMBER_OF_COLUMNS + indexPath.section)]];
	return cell;
}

#pragma mark-
#pragma mark- WaterflowDelegate



-(CGFloat)flowView:(WaterflowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
	float height = 0;
	switch ((indexPath.row + indexPath.section )  % 5) {
		case 0:
			height = 127;
			break;
		case 1:
			height = 100;
			break;
		case 2:
			height = 87;
			break;
		case 3:
			height = 114;
			break;
		case 4:
			height = 140;
			break;
		case 5:
			height = 158;
			break;
		default:
			break;
	}
	
	//height += indexPath.row + indexPath.section;
	return height;
    
}

- (void)flowView:(WaterflowView *)flowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsViewController *goodsViewControl = (GoodsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"goodsViewController"];
    NSString* goodsId = [self.goodsIds objectAtIndex:(indexPath.row*NUMBER_OF_COLUMNS+indexPath.section)];
    goodsViewControl.goodsId = goodsId;
    goodsViewControl.hidesBottomBarWhenPushed = YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:goodsViewControl animated:YES];
}

- (void)flowView:(WaterflowView *)_flowView willLoadData:(NSInteger)page
{
    NSString *url = [self.url stringByAppendingFormat:@"%@%u%@%u",@"&pageSize=",kDefaultPageSize,@"&currentPage=",page];
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfJSONURLString:url];
    NSDictionary* pageInfo = [dictionary objectForKey:@"pageInfo"];
    int currentPage = [[pageInfo objectForKey:@"currentPage"] intValue];
    int totalPage = [[pageInfo objectForKey:@"totalPage"] intValue];
    if (currentPage==totalPage) {
        self.waterFlowView.loadingmore = NO;
    }else {
        self.waterFlowView.loadingmore = YES;
    }
    if (page==1) {//重新加载数据，必须先清除数据
        [self.imageUrls removeAllObjects];
        [self.goodsIds removeAllObjects];
    }
    NSDictionary* dataInfo = [dictionary objectForKey:@"dataInfo"];
    NSMutableArray* goods_thumbs = [dataInfo mutableArrayValueForKey:@"goods_thumb"];
    [self.imageUrls addObjectsFromArray:goods_thumbs];
    NSMutableArray *goods_ids = [dataInfo mutableArrayValueForKey:@"goods_id"];
    [self.goodsIds addObjectsFromArray:goods_ids];
}

@end
