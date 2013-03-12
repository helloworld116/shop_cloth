//
//  AlbumViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AlbumViewController.h"
#import "AsyncImageView.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController
@synthesize scrollView=_scrollView;
@synthesize currentPage=_currentPage;
@synthesize imgUrls=_imgUrls;
@synthesize isImgLoad=_isImgLoad;

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
        NSString *url = [kUrlOfShopAlbum stringByAppendingFormat:@"%@%u%@%u",@"&pageSize=",1,@"&currentPage=",self.currentPage];
        NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:url];
        //4让主线程显示图像选择器
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data == nil) {
                [SVProgressHUD dismissWithError:@"图片加载失败"];
            }else {
                int totalNum = [[[data objectForKey:@"pageInfo"] objectForKey:@"totalNum"] intValue];
                int currentPage = [[[data objectForKey:@"pageInfo"] objectForKey:@"currentPage"] intValue];
                self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*totalNum, self.scrollView.frame.size.height);
                self.scrollView.contentOffset = CGPointMake((currentPage-1)*self.scrollView.frame.size.width, 0);
                self.scrollView.delegate = self;
                //设置位置
                NSString *imgUrl = [[[data objectForKey:@"dataInfo"] objectAtIndex:0] objectForKey:@"img_original"];
                CGRect imgRect = self.scrollView.frame;
                imgRect.origin.x = self.scrollView.frame.size.width*(currentPage-1);
                AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:imgRect];
                [imageView loadImage:imgUrl];
                [self.scrollView addSubview:imageView];
                
                //标识图片加载情况,用于判定翻页时是否需要重新加载图片
                self.isImgLoad = [NSMutableArray arrayWithCapacity:totalNum];
                self.imgUrls = [NSMutableArray arrayWithCapacity:totalNum];
                for (int i = 0; i<totalNum; i++) {
                    if (i==currentPage-1) {
                        [self.isImgLoad insertObject:@"YES" atIndex:i];
                        [self.imgUrls insertObject:imgUrl atIndex:i];
                    }else {
                        [self.isImgLoad insertObject:@"NO" atIndex:i];
                        [self.imgUrls insertObject:@"" atIndex:i];
                    }
                }
                [SVProgressHUD dismiss];
            }
        });
    });
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offsetX = (int)scrollView.contentOffset.x;
    int width = (int)self.scrollView.frame.size.width;
    int mode = offsetX%width;
    if (mode==0) {
        int div = offsetX/width;
        NSString *isload = [self.isImgLoad objectAtIndex:div];
        if ([isload isEqualToString:@"NO"]) {
            //1显示状态
            [SVProgressHUD showWithStatus:@"正在载入..."];
            //2从系统中获取一个并行队列
            dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //3在后台线程创建图像选择器
            dispatch_async(concurrentQueue, ^{        
                NSString *url = [kUrlOfShopAlbum stringByAppendingFormat:@"%@%u%@%u",@"&pageSize=",1,@"&currentPage=",(div+1)];
                NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:url];
                //4让主线程显示图像选择器
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (data == nil) {
                        [SVProgressHUD dismissWithError:@"图片加载失败"];
                    }else {
                        int currentPage = [[[data objectForKey:@"pageInfo"] objectForKey:@"currentPage"] intValue];
                        self.scrollView.contentOffset = CGPointMake((currentPage-1)*self.scrollView.frame.size.width, 0);
                        self.scrollView.delegate = self;
                        //设置位置
                        NSString *imgUrl = [[[data objectForKey:@"dataInfo"] objectAtIndex:0] objectForKey:@"img_original"];
                        CGRect imgRect = self.scrollView.frame;
                        imgRect.origin.x = self.scrollView.frame.size.width*(currentPage-1);
                        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:imgRect];
                        [imageView loadImage:imgUrl];
                        [self.scrollView addSubview:imageView];
                        
                        //标识图片加载情况,用于判定翻页时是否需要重新加载图片
                        [self.isImgLoad replaceObjectAtIndex:div withObject:@"YES"];
                        [SVProgressHUD dismiss];
                    }
                });
            });
        }
    }
}
@end
