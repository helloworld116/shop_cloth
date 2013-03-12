//
//  NewsDetailsViewController.m
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsDetailsViewController.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"

@interface NewsDetailsViewController ()

@end

@implementation NewsDetailsViewController
@synthesize container = _container;
@synthesize newsTitle = _newsTitle;
@synthesize time = _time;
@synthesize source = _source;
@synthesize content = _content;
@synthesize newsId=_newsId;

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
    //1显示状态
    [SVProgressHUD showWithStatus:@"正在载入..."];
    //2从系统中获取一个并行队列
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //3在后台线程创建图像选择器
    dispatch_async(concurrentQueue, ^{        
        NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfNewsDetail];
        //4让主线程显示图像选择器
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary* news = [data objectForKey:@"dataInfo"];
            self.title = [news objectForKey:@"title"];
            self.newsTitle.text = [news objectForKey:@"title"];
            CGSize titleSize = [self.newsTitle.text sizeWithFont:self.newsTitle.font constrainedToSize:self.view.bounds.size lineBreakMode:UILineBreakModeWordWrap];
            CGRect titleRect = self.newsTitle.frame;
            titleRect.size.height = titleSize.height;
            self.newsTitle.frame = titleRect;
            
            self.time.text = [news objectForKey:@"add_time"];
            self.source.text = [news objectForKey:@""];
            [self.content loadHTMLString:[news objectForKey:@"content"] baseURL:nil];
            self.content.delegate = self;
            [(UIScrollView *)[[self.content subviews] objectAtIndex:0] setBounces:NO]; 
            [(UIScrollView *)[[self.content subviews] objectAtIndex:0] setShowsVerticalScrollIndicator:NO];
            [(UIScrollView *)[[self.content subviews] objectAtIndex:0] setUserInteractionEnabled:NO];
            self.container.bounces=NO;
            //设置背景颜色
//            self.container.backgroundColor = [UIColor underPageBackgroundColor];
//            self.content.backgroundColor = [UIColor underPageBackgroundColor];
            self.hidesBottomBarWhenPushed=YES;
            [SVProgressHUD dismiss];
        });
    });
}


- (void)viewDidUnload
{
    [self setNewsTitle:nil];
    [self setTime:nil];
    [self setSource:nil];
    [self setContent:nil];
    [self setContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight=[webView.scrollView contentSize].height;
    CGRect newFrame = webView.frame;
    newFrame.size.height = webViewHeight;
    self.content.frame = newFrame;
    self.container.contentSize = CGSizeMake(self.container.contentSize.width, webViewHeight+70);
}
@end
