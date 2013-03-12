//
//  Goods.h
//  ShopCloth
//
//  Created by apple on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
@property(retain,nonatomic) NSString* goods_id;
@property(retain,nonatomic) NSString* goods_img;
@property(retain,nonatomic) NSString* goods_thumb;
@property(retain,nonatomic) NSString* goods_name;
@property(retain,nonatomic) NSString* shop_price;
@property(retain,nonatomic) NSString* promote_price;

-(id)initWithId:(NSString*) goods_id thumb:(NSString*) thumb;
@end
