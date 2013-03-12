//
//  InfomationViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsViewController.h"

@interface InfomationViewController : UIViewController<UIScrollViewDelegate>
- (IBAction)showNews:(id)sender;
- (IBAction)showCase:(id)sender;
- (IBAction)showActivity:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgOfSelected;
@property (strong, nonatomic) IBOutlet UIScrollView *container;
@property (strong, nonatomic) IBOutlet UILabel *lblOfNews;
@property (strong, nonatomic) IBOutlet UILabel *lblOfCase;
@property (strong, nonatomic) IBOutlet UILabel *lblOfAcitivity;
@property (retain, nonatomic) UILabel *currentSelected;

@property (retain,nonatomic) NewsViewController *newsViewController;
@property (retain,nonatomic) NewsViewController *caseViewController;
@property (retain,nonatomic) NewsViewController *activityViewController;
@end
