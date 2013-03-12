//
//  AboutUsViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AboutUsViewController.h"
#import "NSDictionary+JSONCategories.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize webView;

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
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfAboutUs];
    NSDictionary *dataInfo = [data objectForKey:@"dataInfo"];
    [self.webView loadHTMLString:[dataInfo objectForKey:@"memo"] baseURL:nil];
    [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
