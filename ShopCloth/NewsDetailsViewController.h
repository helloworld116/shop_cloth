//
//  NewsDetailsViewController.h
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "News.h"

@interface NewsDetailsViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *container;
@property (strong, nonatomic) IBOutlet UILabel *newsTitle;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UIWebView *content;
@property (nonatomic,retain) NSString* newsId; 
@end
