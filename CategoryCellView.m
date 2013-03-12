//
//  CategoryCell.m
//  ShopCloth
//
//  Created by apple on 12-12-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CategoryCellView.h"

@implementation CategoryCellView
@synthesize categoryImg;
@synthesize categoryName;
@synthesize categoryCellDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect imgRect = CGRectMake(15, 0, self.bounds.size.width-15*2, self.bounds.size.height-40);
        self.categoryImg = [[AsyncImageView alloc] initWithFrame:imgRect]; 
        [self addSubview:self.categoryImg];
        
        CGRect labelRect = CGRectMake(15, imgRect.size.height+1, self.bounds.size.width-15*2, 30);
        self.categoryName = [[UILabel alloc] initWithFrame:labelRect];
        self.categoryName.textAlignment = UITextAlignmentCenter;
//        self.categoryName.backgroundColor = [UIColor redColor];
        
//        CGRect btnRect = self.frame;
//        UIButton* hiddenBtn = [[UIButton alloc] initWithFrame:btnRect];
//        [hiddenBtn addTarget:self action:@selector(onCategoryCellClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:hiddenBtn];
        
        [self addSubview:self.categoryName];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (void)cellSelected:(NSNotification *)notification
//{
//    if ([self.categoryCellDelegate respondsToSelector:@selector(categoryCell:didSelectRowAtIndexPath:)])
//    {
//        [self.categoryCellDelegate categoryCellView:self didSelectRowAtIndexPath:((CategoryCellView*)notification.object).indexPath];
//    }
//}
//

@end

@implementation CategoryCell
@synthesize indexPath=_indexPath;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CellSelected"
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:self.indexPath forKey:@"IndexPath"]];
    
}

@end
