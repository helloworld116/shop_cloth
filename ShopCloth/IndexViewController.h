//
//  IndexViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLCycleScrollView.h"
#import "News.h"

@interface IndexViewController : UIViewController<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate,UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *imageContainer;
@property (strong, nonatomic) IBOutlet UIWebView *news;
@property (strong, nonatomic) IBOutlet UIScrollView *indexContainer;

@property (strong,nonatomic) XLCycleScrollView* cycleScrollView;
@property (strong, nonatomic) IBOutlet UIView *topContainer;

@property (retain,nonatomic) NSMutableArray* hotNews;
@property (retain,nonatomic) NSMutableArray* shopAlbums;
@end
