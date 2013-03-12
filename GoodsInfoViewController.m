//
//  GoodsInfoViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodsInfoViewController.h"
#import "AsyncImageView.h"

@interface GoodsInfoViewController ()
@end

@implementation GoodsInfoViewController
@synthesize lblGoodsName=_lblGoodsName;
@synthesize lblGoodsId=_lblGoodsId;
@synthesize lblGoodsBrand=_lblGoodsBrand;
@synthesize lblGoodsClickedCount=_lblGoodsClickedCount;
@synthesize lblShelvesTime=_lblShelvesTime;
@synthesize lblWebPrice=_lblWebPrice;
@synthesize lblShopPrice=_lblShopPrice;
@synthesize lblMarketPrice=_lblMarketPrice;
@synthesize imgContainer = _imgContainer;
@synthesize imgsOfGoods=_imgsOfGoods;
@synthesize cycleScrollView=_cycleScrollView;
@synthesize imgServer=_imgServer;
@synthesize goodsInfoData=_goodsInfoData;

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
    self.lblGoodsName.text=[self.goodsInfoData objectForKey:@"goods_name"];
    self.lblGoodsId.text=[self.goodsInfoData objectForKey:@"goods_sn"];
    self.lblWebPrice.text=[NSString stringWithFormat:@"￥%@",[self.goodsInfoData objectForKey:@"promote_price"]];
    self.lblGoodsBrand.text=[self.goodsInfoData objectForKey:@"goods_brand"];
    self.lblShopPrice.text=[NSString stringWithFormat:@"￥%@",[self.goodsInfoData objectForKey:@"shop_price"]];
    self.lblGoodsClickedCount.text=[self.goodsInfoData objectForKey:@"click_count"];
    self.lblMarketPrice.text=[NSString stringWithFormat:@"￥%@",[self.goodsInfoData objectForKey:@"market_price"]];
    self.lblShelvesTime.text=[self.goodsInfoData objectForKey:@"add_time"];
    
    //添加商品默认图片到相册
    //小图：goods_thumb,中图:goods_img,大图:original_img
    [self.imgsOfGoods insertObject:[self.goodsInfoData objectForKey:@"original_img"] atIndex:0];
    self.cycleScrollView = [[XLCycleScrollView alloc] initWithFrame:self.imgContainer.bounds];
    self.cycleScrollView.datasource = self;
    self.cycleScrollView.delegate = self;
    [self.imgContainer addSubview:_cycleScrollView];

}

- (void)viewDidUnload
{

    [self setLblGoodsName:nil];
    [self setLblGoodsId:nil];
    [self setLblGoodsBrand:nil];
    [self setLblGoodsClickedCount:nil];
    [self setLblShelvesTime:nil];
    [self setLblWebPrice:nil];
    [self setLblShopPrice:nil];
    [self setLblMarketPrice:nil];
    self.imgServer=nil;
    self.goodsInfoData=nil;
    [self setImgContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
}

#pragma mark- CycleScrollViewDatasource
- (NSInteger)numberOfPages
{
    return [self.imgsOfGoods count];
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    NSString *imgUrl = nil;
    if (index==0) {//来自商品默认图片
        imgUrl = [self.imgsOfGoods objectAtIndex:index];
    }else {
        //小图thumb_url,大图img_original,中图img_url(来自商品相册)
        NSDictionary *album = [self.imgsOfGoods objectAtIndex:index];
        NSString *name = [album objectForKey:@"img_original"];
        imgUrl = [NSString stringWithFormat:@"%@%@",self.imgServer,name];
        self.cycleScrollView.labelMsg.text = [album objectForKey:@"img_desc"];
    }
    CGRect imageRect = self.imgContainer.bounds;
    AsyncImageView* imageView = [[AsyncImageView alloc] initWithFrame:imageRect];
    [imageView loadImage:imgUrl];
    return imageView;
}

#pragma mark- CycleScrollViewDelegate
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{

}

- (void)cycleScrollViewPageEnable
{
    if ([self.imgsOfGoods count]<2) {
        self.cycleScrollView.scrollView.contentSize = CGSizeMake(self.cycleScrollView.frame.size.width, self.cycleScrollView.bounds.size.height);
    }
}
@end
