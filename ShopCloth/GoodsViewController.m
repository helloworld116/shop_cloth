//
//  GoodsViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsInfoViewController.h"
#import "GoodsDetailsViewController.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"

#define kSelectedLabelColor [UIColor colorWithRed:11/255.0 green:150/255.0 blue:102/255.0 alpha:1]

@interface GoodsViewController ()
- (IBAction)goodsInfo:(id)sender;
- (IBAction)goodsDetail:(id)sender;

@end

@implementation GoodsViewController
@synthesize container=_container;
@synthesize imgOfSelected = _imgOfSelected;
@synthesize lblGoodsInfo = _lblGoodsInfo;
@synthesize lblGoodsDetail = _lblGoodsDetail;
@synthesize goodsId=_goodsId;
@synthesize goodsData=_goodsData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.goodsData==nil) {
        //1显示状态
        [SVProgressHUD showWithStatus:@"正在载入..."];
        //2从系统中获取一个并行队列
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //3在后台线程创建图像选择器
        dispatch_async(concurrentQueue, ^{        
            self.goodsData = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfGoodsDetail];
            NSDictionary *imgInfo = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfGoodsImgs];
            //4让主线程显示图像选择器
            dispatch_async(dispatch_get_main_queue(), ^{
                self.title = [[self.goodsData objectForKey:@"dataInfo"] objectForKey:@"goods_name"];
                self.container.delegate=self;
                self.lblGoodsInfo.textColor = kSelectedLabelColor;//默认选中
                GoodsInfoViewController *goodsInfoViewController = (GoodsInfoViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"goodsInfoViewController"];
                goodsInfoViewController.goodsInfoData = [self.goodsData objectForKey:@"dataInfo"];
                goodsInfoViewController.imgsOfGoods = [[NSMutableArray alloc] init];
                NSDictionary *imgDataInfo = [imgInfo objectForKey:@"dataInfo"];
                NSMutableArray *goodsImgs = [imgDataInfo objectForKey:@"pic"];
                [goodsInfoViewController.imgsOfGoods addObjectsFromArray:goodsImgs];
                goodsInfoViewController.imgServer = [imgDataInfo objectForKey:@"imgserver"];
                goodsInfoViewController.view.frame = CGRectMake(0, 5, goodsInfoViewController.view.frame.size.width, goodsInfoViewController.view.frame.size.height);
                self.container.contentSize = CGSizeMake(2*self.container.frame.size.width, 0);
                [self.container addSubview:goodsInfoViewController.view];
                [goodsInfoViewController didMoveToParentViewController:self];
                [self addChildViewController:goodsInfoViewController];
                
                GoodsDetailsViewController *goodsDetailViewContoller = (GoodsDetailsViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"goodsDetailsViewController"];
                goodsDetailViewContoller.goodsDetail = [[self.goodsData objectForKey:@"dataInfo"] objectForKey:@"goods_desc"];
                goodsDetailViewContoller.view.frame = CGRectMake(self.container.frame.size.width, 5, self.container.frame.size.width, self.container.frame.size.height);
                [self.container addSubview:goodsDetailViewContoller.view];
                [goodsDetailViewContoller didMoveToParentViewController:self];
                [self addChildViewController:goodsDetailViewContoller];
                [SVProgressHUD dismiss];
            });
        });
    }
}

- (void)viewDidUnload
{
    [self setContainer:nil];
    [self setGoodsId:nil];
    [self setImgOfSelected:nil];
    [self setLblGoodsInfo:nil];
    [self setLblGoodsDetail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)goodsInfo:(id)sender {
    self.container.contentOffset = CGPointMake(0, 0);
}

- (IBAction)goodsDetail:(id)sender {
    self.container.contentOffset = CGPointMake(320, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.container.contentOffset = scrollView.contentOffset;
    if (scrollView.contentOffset.x==0) {
        self.imgOfSelected.image = [UIImage imageNamed:@"product_info.png"];
        self.lblGoodsInfo.textColor = kSelectedLabelColor;
        self.lblGoodsDetail.textColor = [UIColor blackColor];
    }else if (scrollView.contentOffset.x==self.container.frame.size.width){
        self.imgOfSelected.image = [UIImage imageNamed:@"product_detail.png"];
        self.lblGoodsDetail.textColor = kSelectedLabelColor; 
        self.lblGoodsInfo.textColor = [UIColor blackColor];
    }
}
@end
