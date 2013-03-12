//
//  CategoryCell.h
//  ShopCloth
//
//  Created by apple on 12-12-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
@class CategoryCellView;
@class CategoryCell;

////DataSource and Delegate
@protocol CategoryCellViewDatasource <NSObject>
@required
- (NSInteger)numberOfColumnsInCategoryView:(CategoryCellView*)categoryCellView;
- (NSInteger)categoryCellView:(CategoryCellView *)categoryCellView numberOfRowsInColumn:(NSInteger)column;
- (CategoryCell *)flowView:(CategoryCellView *)categoryCellView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@protocol CategoryCellViewDelegate <NSObject>
@required
- (CGFloat)categoryCellView:(CategoryCellView *)categoryCellView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (void)categoryCellView:(CategoryCellView *)categoryCellView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface CategoryCellView : UIView
@property (strong, nonatomic) IBOutlet AsyncImageView *categoryImg;
@property (strong, nonatomic) IBOutlet UILabel *categoryName;
@property (retain,nonatomic) id<CategoryCellViewDelegate> categoryCellDelegate;
@end

@interface CategoryCell : UIView
@property (retain,nonatomic) NSIndexPath* indexPath;
@end