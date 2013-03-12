//
//  GoodsDetailsViewController.h
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsDetailsViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@property (strong, nonatomic) NSString *goodsDetail;
@end
