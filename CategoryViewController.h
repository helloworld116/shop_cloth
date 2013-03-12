//
//  CategoryViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterflowView.h"

@interface CategoryViewController : UIViewController<WaterflowViewDelegate,WaterflowViewDatasource>
@property (nonatomic,retain) NSMutableArray *imageUrls;
@property (nonatomic,retain) NSMutableArray *categories;
@property (nonatomic,retain) WaterflowView *waterFlowView;
@property (strong, nonatomic) IBOutlet UIView *container;

@end
