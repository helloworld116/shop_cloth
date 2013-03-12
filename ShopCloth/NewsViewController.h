//
//  NewsViewController.h
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreCell.h"

@interface NewsViewController : UITableViewController
@property (nonatomic,retain) NSMutableArray* news;
@property (nonatomic,assign) NSUInteger currentPage;
@property (nonatomic,retain) NSString *url;

@property (nonatomic,retain) LoadMoreCell* loadMoreCell;
@end
