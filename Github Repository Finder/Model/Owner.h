//
//  Owner.h
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Owner : NSObject

@property (strong,nonatomic) NSString*name;
@property (strong,nonatomic) NSString*userImage;

+(Owner*)createFromMap:(NSDictionary*)dicc;

@end
