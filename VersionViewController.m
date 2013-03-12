//
//  VersionViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VersionViewController.h"
#import "NSDictionary+JSONCategories.h"

@interface VersionViewController ()

@end

@implementation VersionViewController
@synthesize lblVersionInfo;

//数据结构
//{"versionName":"ucshop_1.09292","apkUrl":"http:\/\/192.168.1.188\/app\/apk\/2012092913463612.apk","versionNo":"1.09292","describe":"\u6d4b\u8bd5\u7248\u672c"}

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
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlVersion];
    self.lblVersionInfo.text = [data objectForKey:@"versionName"];
}

- (void)viewDidUnload
{
    [self setLblVersionInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
