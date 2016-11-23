//
//  Owner.m
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import "Owner.h"

@implementation Owner

+(Owner *)createFromMap:(NSDictionary *)dicc{
    Owner*owner=[[Owner alloc] init];
    if (![[dicc[@"login"] class] isSubclassOfClass:[NSNull class]]) {
        owner.name=dicc[@"login"];
    }else{
        owner.name=@"";
    }
    if (![[dicc[@"login"] class] isSubclassOfClass:[NSNull class]]) {
        owner.userImage=dicc[@"avatar_url"];
    }else{
        owner.userImage=@"";
    }
    return owner;
}

@end
