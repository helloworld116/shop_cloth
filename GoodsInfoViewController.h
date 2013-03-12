//
//  GoodsInfoViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"

@interface GoodsInfoViewController : UIViewController<UIScrollViewDelegate,XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsName;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsId;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsBrand;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsClickedCount;
@property (strong, nonatomic) IBOutlet UILabel *lblShelvesTime;
@property (strong, nonatomic) IBOutlet UILabel *lblWebPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblShopPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblMarketPrice;
@property (strong, nonatomic) IBOutlet UIView *imgContainer;
@property (strong, nonatomic) XLCycleScrollView *cycleScrollView;
@property (nonatomic,retain) NSString* imgServer;

@property (strong, nonatomic) NSDictionary *goodsInfoData;

@property (strong, nonatomic) NSMutableArray *imgsOfGoods;

@end
