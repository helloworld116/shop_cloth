//
//  BrandTableViewController.m
//  ShopCloth
//
//  Created by apple on 12-12-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BrandTableViewController.h"
#import "AsyncImageView.h"
#import "GoodsListViewController.h"
#import "NSDictionary+JSONCategories.h"
#import "SVProgressHUD.h"

@interface BrandTableViewController ()

@end

@implementation BrandTableViewController
@synthesize brands=_brands;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfBrands];
    self.brands = [data objectForKey:@"dataInfo"];
    
    //方式一，未能成功，uitableview需要研究下，有时间在研究
//    if (self.brands==nil) {
//        //1显示状态
//        [SVProgressHUD showWithStatus:@"正在载入..."];
//        //2从系统中获取一个并行队列
//        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        //3在后台线程创建图像选择器
//        dispatch_async(concurrentQueue, ^{        
//            NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfBrands];
//            NSMutableArray *brands = [data objectForKey:@"dataInfo"];
//            self.brands = [[NSMutableArray alloc] init];
//            [self.brands addObjectsFromArray:brands];
//            //4让主线程显示图像选择器
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [SVProgressHUD dismiss];
//            });
//        });
//    }
    
    //方式二，暂时也未能成功，有时间再试
//    [SVProgressHUD showWithStatus:@正在载入..."];
//    [self performSelector:@selector(loadData) withObject:self afterDelay:1.0f];
}

-(void)loadData{
    NSDictionary* data = [NSDictionary dictionaryWithContentsOfJSONURLString:kUrlOfBrands];
    self.brands = [data objectForKey:@"dataInfo"];
    [SVProgressHUD dismiss];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.brands count];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListViewController* goodsListViewController = (GoodsListViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"goodsListViewController"];
    long long timestamp = [[[NSDate alloc] init] timeIntervalSince1970];
    NSString* notifyName = [NSString stringWithFormat:@"brandOfGoods_%d_%d_%qi",indexPath.row,indexPath.section,timestamp];
    goodsListViewController.notifyName = notifyName;
    NSDictionary *brand = [self.brands objectAtIndex:indexPath.row];
    NSString *url = [kUrlOfGoodsByBrand stringByAppendingFormat:@"%@%@",@"&id=",[brand objectForKey:@"brand_id"]];
    goodsListViewController.url = url;
    goodsListViewController.title=[brand objectForKey:@"brand_name"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    [self.navigationController pushViewController:goodsListViewController animated:YES];
}


-(UITableViewCell*)tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* tableCell = [tableView dequeueReusableCellWithIdentifier:@"brandCell"];
    AsyncImageView *imgView = (AsyncImageView *)[tableCell.contentView viewWithTag:51];
    UILabel *label = (UILabel*)[tableCell.contentView viewWithTag:52];
    NSDictionary* brand = [self.brands objectAtIndex:indexPath.row];
    [imgView loadImage:[brand objectForKey:@"brand_logo"]];
    label.text = [brand objectForKey:@"brand_name"];
    return tableCell;
}
@end
