//
//  NewsViewController.m
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDetailsViewController.h"
#import "News.h"
#import "NSDictionary+JSONCategories.h"

@interface NewsViewController ()
@end

@implementation NewsViewController
@synthesize news = _news;
@synthesize currentPage=_currentPage;
@synthesize loadMoreCell=_loadMoreCell;
@synthesize url=_url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSArray*) loadNewsWithPageSize:(NSUInteger)pageSize currentPage:(NSUInteger) currentPage{
    NSString* url = [self.url stringByAppendingFormat:@"%@%u%@%u",@"&pageSize=",pageSize,@"&currentPage=",currentPage];
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfJSONURLString:url];
    NSArray* news = [data objectForKey:@"dataInfo"];
    return news;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"资讯";
    self.news = [[NSMutableArray alloc] initWithArray:[self loadNewsWithPageSize:kDefaultPageSize currentPage:1]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.news=nil;
    self.loadMoreCell=nil;
    self.url=nil;
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int c = [self.news count];
    if (c>10) {//只有大于10条记录时才显示“加载更多”的那个cell
        c+=1;
    }
    return c;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==[self.news count]) {
        self.loadMoreCell = [[LoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"loadmore"];
        return self.loadMoreCell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell"];
        //    NSDate *object = [_objects objectAtIndex:indexPath.row];
        //    cell.textLabel.text = [object description];
        UILabel* title = (UILabel*)[cell viewWithTag:21];
        UILabel* time = (UILabel*)[cell viewWithTag:22];
        NSDictionary *news = [self.news objectAtIndex:indexPath.row];
        title.text = [news objectForKey:@"title"];
        time.text = [news objectForKey:@"add_time"];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.news count]) {
        [self performSelectorInBackground:@selector(loadMore) withObject:nil];
        //[loadMoreCell setHighlighted:NO];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }else {
        NewsDetailsViewController *detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newsDetailViewController"];
        detailViewController.title=@"";
        detailViewController.newsId = [[self.news objectAtIndex:indexPath.row] objectForKey:@"id"];
        detailViewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

-(void)loadMore {
    self.currentPage+=1;
    NSArray *otherNews = [self loadNewsWithPageSize:kDefaultPageSize currentPage:self.currentPage];
    [self performSelectorOnMainThread:@selector(appendTableWithData:) withObject:otherNews waitUntilDone:NO];
}

-(void) appendTableWithData:(NSArray*) otherNews{
    [self.news addObjectsFromArray:otherNews];
    
    [self.tableView insertRowsAtIndexPaths:self.news withRowAnimation:UITableViewRowAnimationFade];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


@end
