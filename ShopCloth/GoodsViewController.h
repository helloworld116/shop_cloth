//
//  GoodsViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *container;
@property (strong, nonatomic) IBOutlet UIImageView *imgOfSelected;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblGoodsDetail;
@property (strong, nonatomic) NSString *goodsId;
@property (strong, nonatomic) NSDictionary *goodsData;
@end
