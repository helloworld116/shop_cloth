//
//  GoodsDetailsViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodsDetailsViewController.h"

@interface GoodsDetailsViewController ()

@end

@implementation GoodsDetailsViewController
@synthesize webview=_webview;
@synthesize goodsDetail=_goodsDetail;

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
    [self.webview loadHTMLString:self.goodsDetail baseURL:nil];
    [(UIScrollView *)[[self.webview subviews] objectAtIndex:0] setBounces:NO];
}

- (void)viewDidUnload
{
    [self setWebview:nil];
    self.goodsDetail=nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
}

@end
