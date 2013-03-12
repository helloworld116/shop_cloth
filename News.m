//
//  News.m
//  ShopCloth
//
//  Created by apple on 12-11-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "News.h"

@implementation News
@synthesize title = _title;
@synthesize content = _content;
@synthesize time = _time;
@synthesize source = _source;
@synthesize image = _image;

-(id) initWithTitle:(NSString *)title content:(NSString *)content time:(NSString *)time source:(NSString *)source{
    if (self==[super init]) {
        self.title = title;
        self.content = content;
        self.source = source;
        self.time = time;
    }
    return self;
}

-(void)dealloc{
    self.title=nil;
    self.content=nil;
    self.time=nil;
    self.source=nil;
}
@end
