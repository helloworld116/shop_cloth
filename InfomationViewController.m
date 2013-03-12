//
//  InfomationViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfomationViewController.h"
#import "NSDictionary+JSONCategories.h"
#define kSelectedLabelColor [UIColor colorWithRed:11/255.0 green:150/255.0 blue:102/255.0 alpha:1]

@interface InfomationViewController ()

@end

@implementation InfomationViewController
@synthesize imgOfSelected=_imgOfSelected;
@synthesize container=_container;
@synthesize lblOfNews = _lblOfNews;
@synthesize lblOfCase = _lblOfCase;
@synthesize lblOfAcitivity = _lblOfAcitivity;
@synthesize currentSelected=_currentSelected;
@synthesize newsViewController=_newsViewController;
@synthesize caseViewController=_caseViewController;
@synthesize activityViewController=_activityViewController;

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
    self.container.delegate = self;
    //暂时设置为2，去掉 活动
    self.container.contentSize = CGSizeMake(self.container.frame.size.width*2, self.container.frame.size.height);
    [self showNews:nil];
}

- (void)viewDidUnload
{
    [self setImgOfSelected:nil];
    [self setContainer:nil];
    self.currentSelected = nil;
    self.newsViewController=nil;
    self.caseViewController=nil;
    self.activityViewController=nil;
    [self setLblOfNews:nil];
    [self setLblOfCase:nil];
    [self setLblOfAcitivity:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int contentOffsetX = (int)scrollView.contentOffset.x;
    int width = (int)self.container.frame.size.width;
    int x = -1; 
    if (contentOffsetX%width==0) {
        x = contentOffsetX/width ;
        UIColor *textColor = kSelectedLabelColor;
        [self clearLableTextColor];
        NSString *imageName = nil;
        switch (x) {
            case 0:
//                imageName = @"infomation_select1";
                imageName = @"product_info";
                self.currentSelected = self.lblOfNews;
                self.lblOfNews.textColor = textColor;
                if (self.newsViewController==nil) {
                    [self showNews:nil];
                }
                break;
            case 1:
//                imageName = @"infomation_select2";
                imageName = @"product_detail";
                self.currentSelected = self.lblOfCase;
                self.lblOfCase.textColor = textColor;
                if (self.caseViewController==nil) {
                   [self showCase:nil];
                }
                break;
            case 2:
                imageName = @"infomation_select3";
                self.currentSelected = self.lblOfAcitivity;
                self.lblOfAcitivity.textColor = textColor;
                if (self.activityViewController==nil) {
                    [self showActivity:nil];
                }
                break;
            default:
                imageName = @"product_select31";
                self.currentSelected = self.lblOfNews;
                self.lblOfNews.textColor = textColor;
                if (self.newsViewController==nil) {
                    [self showNews:nil];
                }
                break; 
        }
        self.imgOfSelected.image = [UIImage imageNamed:imageName];
    }
}

-(void)clearLableTextColor{
    self.currentSelected.textColor = [UIColor blackColor];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showNews:(id)sender {
    self.container.contentOffset = CGPointMake(0, 0);
    if (self.newsViewController==nil) {
        self.lblOfNews.textColor = kSelectedLabelColor;
        self.currentSelected = self.lblOfNews;//默认选中第一个
        self.newsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsViewController"];
        self.newsViewController.url = kUrlOfNews;
        self.newsViewController.view.frame = CGRectMake(0*self.container.frame.size.width, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.newsViewController.view];
        [self.newsViewController didMoveToParentViewController:self];
        [self addChildViewController:self.newsViewController];
    }
}

- (IBAction)showCase:(id)sender {
    self.container.contentOffset = CGPointMake(self.container.frame.size.width, 0);
    if (self.caseViewController==nil) {
        self.caseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsViewController"];
        self.caseViewController.url = kUrlOfCase;
        self.caseViewController.tableView.frame = CGRectMake(self.container.frame.size.width, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.caseViewController.tableView];
        [self.caseViewController didMoveToParentViewController:self];
        [self addChildViewController:self.caseViewController];
    }
}

- (IBAction)showActivity:(id)sender {
    self.container.contentOffset = CGPointMake(self.container.frame.size.width*2, 0);
    if (self.activityViewController==nil) {
        self.activityViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsViewController"];
        self.activityViewController.url = kUrlOfActivity;
        self.activityViewController.view.frame = CGRectMake(2*self.container.frame.size.width, 0, self.container.frame.size.width, self.container.frame.size.height);
        [self.container addSubview:self.activityViewController.view];
        [self.activityViewController didMoveToParentViewController:self];
        [self addChildViewController:self.activityViewController];
    }
}
@end
