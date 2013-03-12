//
//  Product.h
//  ShopCloth
//
//  Created by apple on 12-11-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* price;
@property (nonatomic,retain) NSString* description;
@property (nonatomic,retain) UIImage* pic;

-(id) initWithTitle:(NSString*) title price:(NSString*) price descrpiton:(NSString*) descption pic:(UIImage*) pic;
@end
