//
//  AlbumViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,retain) NSMutableArray *imgUrls;//保存所有的图片url
@property (nonatomic,retain) NSMutableArray *isImgLoad;//标识指定位置的图片是否已被加载

@end
