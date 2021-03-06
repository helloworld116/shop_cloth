//
//  AlbumListViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterflowView.h"

@interface AlbumListViewController : UIViewController<WaterflowViewDelegate,WaterflowViewDatasource>
@property (strong, nonatomic) IBOutlet UIView *container;
@property (nonatomic,retain) NSMutableArray *imageUrls;
@property (nonatomic,retain) NSMutableArray *goodsIds;
@property (nonatomic,retain) WaterflowView *waterFlowView;
@property (nonatomic,retain) NSString *notifyName;

@property (nonatomic,assign) NSInteger currentPage;


@end
