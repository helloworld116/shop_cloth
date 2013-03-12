//
//  CategoryViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "AsyncImageView.h"
#import "GoodsListViewController.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"
#define NUMBER_OF_COLUMNS 3

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize imageUrls=_imageUrls;
@synthesize categories=_categories;
@synthesize waterFlowView=_waterFlowView;
@synthesize container = _container;

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
    if (self.categories==nil) {
        //1显示状态
        [SVProgressHUD showWithStatus:@"正在载入..."];
        //2从系统中获取一个并行队列
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //3在后台线程创建图像选择器
        dispatch_async(concurrentQueue, ^{        
            NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfCategories];
//            NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfBrands];
            NSMutableArray *categories = [data objectForKey:@"dataInfo"];
            self.categories = [[NSMutableArray alloc] init];
            [self.categories addObjectsFromArray:categories];
            //4让主线程显示图像选择器
            dispatch_async(dispatch_get_main_queue(), ^{
                CGRect rect = self.container.bounds;
                self.waterFlowView = [WaterflowView alloc];
                self.waterFlowView.notifycationName = @"category";
                self.waterFlowView = [self.waterFlowView initWithFrame:rect];
                self.waterFlowView.loadingmore = NO; 
                self.waterFlowView.flowdatasource = self;
                self.waterFlowView.flowdelegate = self;
//                self.container.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [self.container addSubview:self.waterFlowView];
                [SVProgressHUD dismiss];
            });
        });
    }
}

- (void)viewDidUnload
{
    [self setContainer:nil];
    self.imageUrls=nil;
    self.categories=nil;
    self.waterFlowView=nil;
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
    int mode = [self.categories count]%NUMBER_OF_COLUMNS;
    int div = [self.categories count]/NUMBER_OF_COLUMNS;
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
    static NSString *CellIdentifier = @"category";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil)
	{
		cell  = [[WaterFlowCell alloc] initWithReuseIdentifier:CellIdentifier];
		
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.layer.borderColor = [[UIColor blackColor] CGColor];
		imageView.layer.borderWidth = 1;
        imageView.layer.cornerRadius = 4;
		imageView.tag = 1001;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        [cell addSubview:label];
        label.tag = 1002;
	}
	float height = [self flowView:nil heightForRowAtIndexPath:indexPath];
	AsyncImageView *imageView  = (AsyncImageView *)[cell viewWithTag:1001];
    CGFloat orginX=15,orginY=10,sizeWidth=self.view.frame.size.width / NUMBER_OF_COLUMNS-30;
	imageView.frame = CGRectMake(orginX, orginY, sizeWidth, (height-10)*3/5);
    NSDictionary *category = [self.categories objectAtIndex:((indexPath.row)*NUMBER_OF_COLUMNS + indexPath.section)];
    [imageView loadImage:[category objectForKey:@"template_file"]];
	
    UILabel *label = (UILabel*)[cell viewWithTag:1002];
    label.frame = CGRectMake(orginX, (height-10)*4/5+2, sizeWidth, (height-10)*1/5);
    label.textAlignment = UITextAlignmentCenter;
    label.text = [category objectForKey:@"name"];
    return cell;
}

#pragma mark- WaterflowDelegate

-(CGFloat)flowView:(WaterflowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 110.;
}

- (void)flowView:(WaterflowView *)flowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    GoodsListViewController *goodsListViewController = (GoodsListViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"goodsListViewController"];
    long long timestamp = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString* notifyName = [NSString stringWithFormat:@"categoryOfGoods_%d_%d_%qi",indexPath.row,indexPath.section,timestamp];
    goodsListViewController.notifyName=notifyName;
    NSDictionary *category = [self.categories objectAtIndex:((indexPath.row)*NUMBER_OF_COLUMNS + indexPath.section)];
    NSString *url = [kUrlOfGoodsByCategory stringByAppendingFormat:@"%@%@",@"&id=",[category objectForKey:@"id"] ];
    goodsListViewController.url = url;
    goodsListViewController.title = [category objectForKey:@"name"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:goodsListViewController animated:YES];
}

- (void)flowView:(WaterflowView *)_flowView willLoadData:(NSInteger)page
{
    [self.categories removeAllObjects];
    NSDictionary* dictionary = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfCategories];
    NSMutableArray *categories = [dictionary objectForKey:@"dataInfo"];
    [self.categories addObjectsFromArray:categories];
}
@end
