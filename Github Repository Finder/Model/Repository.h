//
//  Repository.h
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Repository : NSObject

@property (strong,nonatomic) NSString*name;
@property (strong,nonatomic) NSString*desc;
@property (strong,nonatomic) NSString*url;
@property (strong,nonatomic) NSString*fullname;
@property (strong,nonatomic) Owner*owner;

+(Repository*)createFromMap:(NSDictionary*)dicc;

@end
