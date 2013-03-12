//
//  PartnersViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PartnersViewController.h"
#import "QuartzCore/QuartzCore.h"
#import "AsyncImageView.h"
#import "NSDictionary+JSONCategories.h"

#define NUMBER_OF_COLUMNS 2

@interface PartnersViewController ()

@end

@implementation PartnersViewController
@synthesize container=_container;
@synthesize partners=_partners;
@synthesize imageUrls=_imageUrls;
@synthesize waterFlowView=_waterFlowView;

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
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfPartners];
    self.partners = [data objectForKey:@"dataInfo"];
    
    
    CGRect rect = self.container.bounds;
    self.waterFlowView = [WaterflowView alloc];
    self.waterFlowView.notifycationName = @"partners";
    self.waterFlowView = [self.waterFlowView initWithFrame:rect];
    self.waterFlowView.loadingmore = NO; 
    self.waterFlowView.flowdatasource = self;
    self.waterFlowView.flowdelegate = self;
    [self.container addSubview:self.waterFlowView];

}

- (void)viewDidUnload
{
    [self setContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark- WaterflowDataSource

- (NSInteger)numberOfColumnsInFlowView:(WaterflowView *)flowView
{
    return NUMBER_OF_COLUMNS;
}

- (NSInteger)flowView:(WaterflowView *)flowView numberOfRowsInColumn:(NSInteger)column
{
    int mode = [self.partners count]%NUMBER_OF_COLUMNS;
    int div = [self.partners count]/NUMBER_OF_COLUMNS;
    int result = 0;
    if (mode==0) {
        result = div; 
    }else if (column<mode) {
        result = div + 1;
    }else {
        result = div;
    }
    return result;
}

- (WaterFlowCell*)flowView:(WaterflowView *)flowView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"partners";
	WaterFlowCell *cell = [flowView_ dequeueReusableCellWithIdentifier:CellIdentifier];
	if(cell == nil)
	{
		cell  = [[WaterFlowCell alloc] initWithReuseIdentifier:CellIdentifier];
		
		AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectZero];
		[cell addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleToFill;
		imageView.layer.borderColor = [[UIColor blackColor] CGColor];
		imageView.layer.borderWidth = 1;
        imageView.layer.cornerRadius = 4;
		imageView.tag = 1001;
	}
	float height = [self flowView:nil heightForRowAtIndexPath:indexPath];
	AsyncImageView *imageView  = (AsyncImageView *)[cell viewWithTag:1001];
    CGFloat orginX=15,orginY=10,sizeWidth=self.view.frame.size.width / NUMBER_OF_COLUMNS-30;
	imageView.frame = CGRectMake(orginX, orginY, sizeWidth, (height-20));
    NSDictionary *partner = [self.partners objectAtIndex:((indexPath.row)*NUMBER_OF_COLUMNS + indexPath.section)];
    [imageView loadImage:[partner objectForKey:@"link_logo"]];
    return cell;
}

#pragma mark- WaterflowDelegate

-(CGFloat)flowView:(WaterflowView *)flowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 80.;
}

- (void)flowView:(WaterflowView *)flowView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
