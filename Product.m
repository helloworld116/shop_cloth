//
//  Product.m
//  ShopCloth
//
//  Created by apple on 12-11-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Product.h"

@implementation Product
@synthesize title=_title;
@synthesize price=_price;
@synthesize description=_description;
@synthesize pic=_pic;

-(void)dealloc{
    self.title=nil;
    self.price=nil;
    self.description=nil;
    self.pic=nil;
}

-(id) initWithTitle:(NSString *)title price:(NSString *)price descrpiton:(NSString *)descption pic:(UIImage *)pic{
    if (self==[super init]) {
        self.title = title;
        self.price = price;
        self.description=descption;
        self.pic=pic;
    }
    return self;
}
@end
