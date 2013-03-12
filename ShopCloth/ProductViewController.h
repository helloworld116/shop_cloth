//
//  ProductViewController.h
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListViewController.h"
#import "BrandTableViewController.h"
#import "CategoryViewController.h"

@interface ProductViewController : UIViewController<UIScrollViewDelegate>
{
    int count;
}
- (IBAction)bestSell:(id)sender;
- (IBAction)newProduct:(id)sender;
- (IBAction)recommend:(id)sender;
- (IBAction)category:(id)sender;
- (IBAction)brands:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblNew;
@property (strong, nonatomic) IBOutlet UILabel *lblBestSell;
@property (strong, nonatomic) IBOutlet UILabel *lblRecommend;
@property (strong, nonatomic) IBOutlet UILabel *lblCategory;
@property (strong, nonatomic) IBOutlet UILabel *lblBrand;
@property (strong, nonatomic) IBOutlet UIButton *btnNewProduct;
@property (strong, nonatomic) IBOutlet UIButton *btnBestSell;
@property (strong, nonatomic) IBOutlet UIButton *btnRecommend;
@property (strong, nonatomic) IBOutlet UIButton *btnCategory;
@property (strong, nonatomic) IBOutlet UIButton *btnBrand;
@property (strong, nonatomic) IBOutlet UIImageView *selectLine;
@property (strong, nonatomic) IBOutlet UIScrollView *container;

@property (strong,nonatomic) UILabel *currentSelectLable;

@property (nonatomic,retain) GoodsListViewController *goodsOfNewViewController;
@property (nonatomic,retain) GoodsListViewController *goodsOfHotViewController;
@property (nonatomic,retain) GoodsListViewController *goodsOfRecommendViewController;
@property (nonatomic,retain) CategoryViewController *categoryViewController;
@property (nonatomic,retain) BrandTableViewController *brandViewController;
@end
