//
//  Goods.m
//  ShopCloth
//
//  Created by apple on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Goods.h"

@implementation Goods
@synthesize goods_id=_goods_id;
@synthesize goods_img=_goods_img;
@synthesize goods_thumb=_goods_thumb;
@synthesize goods_name=_goods_name;
@synthesize shop_price=_shop_price;
@synthesize promote_price=_promote_price;

-(id)initWithId:(NSString *)goods_id thumb:(NSString *)thumb{
    self = [super init];
    if (self) {
        self.goods_id = goods_id;
        self.goods_thumb = thumb;
    }
    return self;
}
@end
