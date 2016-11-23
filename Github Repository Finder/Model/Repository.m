//
//  Repository.m
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import "Repository.h"

@implementation Repository

+(Repository*)createFromMap:(NSDictionary*)dicc{
    Repository *rep=[[Repository alloc] init];
    if (![[dicc[@"name"] class] isSubclassOfClass:[NSNull class]]) {
        rep.name=dicc[@"name"];
    }else{
        rep.name=@"";
    }
    if (![[dicc[@"description"] class] isSubclassOfClass:[NSNull class]]) {
        rep.desc=dicc[@"description"];
    }else{
        rep.desc=@"";
    }
    if (![[dicc[@"html_url"] class] isSubclassOfClass:[NSNull class]]) {
        rep.url=dicc[@"html_url"];
    }else{
        rep.url=@"";
    }
    if (![[dicc[@"full_name"] class] isSubclassOfClass:[NSNull class]]) {
        rep.fullname=dicc[@"full_name"];
    }else{
        rep.fullname=@"";
    }
    NSDictionary* ownerDicc=dicc[@"owner"];
    if (ownerDicc!=nil) {
        rep.owner=[Owner createFromMap:ownerDicc];
    }
    
    return rep;
}

@end
