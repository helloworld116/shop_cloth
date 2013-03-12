//
//  ProductViewController.m
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProductViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AsyncImageView.h"
#import "NSDictionary+JSONCategories.h"
#import "Goods.h"
#import "GoodsViewController.h"
#import "GoodsInfoViewController.h"

#define NUMBER_OF_COLUMNS 3
#define kSelectedLabelColor [UIColor colorWithRed:11/255.0 green:150/255.0 blue:102/255.0 alpha:1]

@interface ProductViewController ()

@end

@implementation ProductViewController
@synthesize lblNew = _lblNew;
@synthesize lblBestSell = _lblBestSell;
@synthesize lblRecommend = _lblRecommend;
@synthesize lblCategory = _lblCategory;
@synthesize lblBrand = _lblBrand;
@synthesize btnNewProduct = _btnNewProduct;
@synthesize btnBestSell = _btnBestSell;
@synthesize btnRecommend = _btnRecommend;
@synthesize btnCategory = _btnCategory;
@synthesize btnBrand = _btnBrand;
@synthesize selectLine = _selectLine;
@synthesize container = _container;
@synthesize currentSelectLable=_currentSelectLable;

@synthesize goodsOfNewViewController=_goodsOfNewViewController;
@synthesize goodsOfHotViewController=_goodsOfHotViewController;
@synthesize goodsOfRecommendViewController=_goodsOfRecommendViewController;
@synthesize categoryViewController=_categoryViewController;
@synthesize brandViewController=_brandViewController;

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
    //uiscrollview type
//    self.container.backgroundColor = [UIColor underPageBackgroundColor]; 
    self.container.delegate = self;
    self.container.contentSize = CGSizeMake(self.container.frame.size.width*5, self.container.frame.size.height);
    [self newProduct:nil];
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsetX = (int)scrollView.contentOffset.x;
    int width = (int)self.container.frame.size.width;
    int x = -1; 
    if (contentOffsetX%width==0) {
        x = contentOffsetX/width ;
        UIColor *labelTextColor = kSelectedLabelColor;
        [self clearLableTextColor];
        NSString *imageName = nil;
        switch (x) {
            case 0:
                imageName = @"product_select31";
                self.currentSelectLable = self.lblNew;
                self.lblNew.textColor = labelTextColor;
                if (self.goodsOfNewViewController==nil) {
                    [self newProduct:nil];
                }
                break;
            case 1:
                imageName = @"product_select32";
                self.currentSelectLable = self.lblBestSell;
                self.lblBestSell.textColor = labelTextColor;
                if (self.goodsOfHotViewController==nil) {
                    [self bestSell:nil];
                }
                break;
            case 2:
                imageName = @"product_select33";
                self.currentSelectLable = self.lblRecommend;
                self.lblRecommend.textColor = labelTextColor;
                if (self.goodsOfRecommendViewController==nil) {
                    [self recommend:nil];
                }
                break;
            case 3:
                imageName = @"product_select34";
                self.currentSelectLable = self.lblCategory;
                self.lblCategory.textColor = labelTextColor;
                if (self.categoryViewController==nil) {
                    [self category:nil];
                }
                break;
            case 4:
                imageName = @"product_select35";
                self.currentSelectLable = self.lblBrand;
                self.lblBrand.textColor = labelTextColor;
                if (self.brandViewController==nil) {
                    [self brands:nil];
                }
                break;
            default:
                imageName = @"product_select31";
                self.currentSelectLable = self.lblNew;
                self.lblNew.textColor = labelTextColor;
                if (self.goodsOfNewViewController==nil) {
                    [self newProduct:nil];
                }
                break; 
        }
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:100];
        self.selectLine.image = [UIImage imageNamed:imageName];
        [UIView commitAnimations];
    }
}

-(void)clearLableTextColor{
    self.currentSelectLable.textColor = [UIColor blackColor];
}

- (void)viewDidUnload
{
    self.container=nil;
    
    [self setBtnNewProduct:nil];
    [self setBtnBestSell:nil];
    [self setBtnRecommend:nil];
    [self setBtnCategory:nil];
    [self setBtnBrand:nil];
    [self setSelectLine:nil];
    
    self.goodsOfNewViewController=nil;
    self.goodsOfHotViewController=nil;
    self.goodsOfRecommendViewController=nil;
    self.categoryViewController=nil;
    self.brandViewController=nil;
    [self setLblNew:nil];
    [self setLblBestSell:nil];
    [self setLblRecommend:nil];
    [self setLblCategory:nil];
    [self setLblBrand:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)removeAllViews{
    for (UIView* view in [self.container subviews]) {
        [view removeFromSuperview];
    }
}

//-(void)animationChange:(id)clicked{
//    UIButton* button = (UIButton*)clicked;
//    if (button != nil && button.tag!=self.currentSelectBtn.tag) {
//        self.currentSelectBtn.enabled = YES;//重设之前按钮为可用
//        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
//        animation.duration = 0.5;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = kCATransitionPush;
//        if(button.tag>self.currentSelectBtn.tag){
//            animation.subtype = kCATransitionFromRight;   
//        }else {
//            animation.subtype = kCATransitionFromLeft;
//        }
//        [[self.view layer] addAnimation:animation forKey:@"animation"];
//        NSString *imgName = [NSString stringWithFormat:@"%@%d%@",@"product_select",button.tag,@".png"];
//        self.selectLine.image = [UIImage imageNamed:imgName];
//        self.currentSelectBtn = button;//重新设置当前选中按钮
//        button.enabled = NO;//禁用当前选中按钮 
//        [self removeAllViews];//移除容器内的所有控件
//    }
//}
#pragma mark- 新产品
- (IBAction)newProduct:(id)sender {
    self.container.contentOffset = CGPointMake(0, 0);
    if (self.goodsOfNewViewController==nil) {//防止点击按钮时再次加载数据
        self.lblNew.textColor = kSelectedLabelColor;
        self.currentSelectLable = self.lblNew;//默认选中第一个
        self.goodsOfNewViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"goodsListViewController"];
        self.goodsOfNewViewController.notifyName = @"new";
//        self.navigationController.navigationItem.leftBarButtonItem
        self.goodsOfNewViewController.url = kUrlOfNewGoods;
        self.goodsOfNewViewController.view.frame = CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.goodsOfNewViewController.view];
        [self.goodsOfNewViewController didMoveToParentViewController:self];
        [self addChildViewController:self.goodsOfNewViewController];
    }
}

#pragma mark- 热卖
- (IBAction)bestSell:(id)sender {
    self.container.contentOffset = CGPointMake(self.container.frame.size.width, 0);
    if (self.goodsOfHotViewController==nil) {
        self.goodsOfHotViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"goodsListViewController"];
        self.goodsOfHotViewController.notifyName = @"bestSell";
        self.goodsOfHotViewController.url = kUrlOfHotGoods;
        self.goodsOfHotViewController.view.frame = CGRectMake(self.container.frame.size.width, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.goodsOfHotViewController.view];
        [self.goodsOfHotViewController didMoveToParentViewController:self];
        [self addChildViewController:self.goodsOfHotViewController];
    }
}

#pragma mark- 推荐商品
- (IBAction)recommend:(id)sender {
    self.container.contentOffset = CGPointMake(self.container.frame.size.width*2, 0);
    if (self.goodsOfRecommendViewController==nil) {
        self.goodsOfRecommendViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"goodsListViewController"];
        self.goodsOfRecommendViewController.notifyName = @"recommend";
        self.goodsOfRecommendViewController.url = kUrlOfRecommendGoods;
        self.goodsOfRecommendViewController.view.frame = CGRectMake(self.container.frame.size.width*2, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.goodsOfRecommendViewController.view];
        [self.goodsOfRecommendViewController didMoveToParentViewController:self];
        [self addChildViewController:self.goodsOfRecommendViewController];
    }
}

#pragma mark- 分类
- (IBAction)category:(id)sender {
//    [self animationChange:sender];
//    if (self.viewCategory==nil) {
//        NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfCategories];
//        self.category = [data objectForKey:@"dataInfo"];
//        CGRect scrollRect = self.container.bounds;
//        self.viewCategory = [[UIView alloc] initWithFrame:scrollRect];
//        UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:scrollRect];
//        [scrollView setContentSize:CGSizeMake(320, 600)];
//        CGFloat x=0,y=0,height=120,width=160;
//        for (int i=0; i<[self.category count]; i++) {
//            NSDictionary *category = [self.category objectAtIndex:i];
//            if (i%2==0) {
//                x = 0;
//            }else {
//                x = self.container.bounds.size.width/2;
//            }
//            y = floor(i/2)*height+5;
//            CGRect cellRect = CGRectMake(x, y, width, height);
//            CategoryCellView* cell = [[CategoryCellView alloc] initWithFrame:cellRect];
//            [cell.categoryImg loadImage:[category objectForKey:@"template_file"] ];
//            cell.categoryName.text = [category objectForKey:@"name"];
//            [scrollView addSubview:cell];
//        }
//        [self.viewCategory addSubview:scrollView];
//    }
//    [self.container addSubview:self.viewCategory];
    
    self.container.contentOffset = CGPointMake(self.container.frame.size.width*3, 0);
    if (self.categoryViewController==nil) {
        self.categoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryViewController"];
        self.categoryViewController.view.frame = CGRectMake(self.container.frame.size.width*3, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.categoryViewController.view];
        [self.categoryViewController didMoveToParentViewController:self];
        [self addChildViewController:self.categoryViewController];
    }
}

#pragma mark- 品牌
- (IBAction)brands:(id)sender {
    self.container.contentOffset = CGPointMake(self.container.frame.size.width*4, 0);
    if (self.brandViewController==nil) {
        self.brandViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"brandTableViewController"];
        self.brandViewController.view.frame = CGRectMake(self.container.frame.size.width*4, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.brandViewController.view];
        [self.brandViewController didMoveToParentViewController:self];
        [self addChildViewController:self.brandViewController];
    }
}

@end
