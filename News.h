//
//  News.h
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* content;
@property (nonatomic,retain) NSString* time;
@property (nonatomic,retain) NSString* source;
@property (nonatomic,retain) UIImage* image;

-(id) initWithTitle:(NSString*) title content:(NSString*) content time:(NSString*) time source:(NSString*) source;
@end
