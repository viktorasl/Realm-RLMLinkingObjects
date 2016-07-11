//
//  EventToken.m
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import "EventToken.h"
#import "EventFooType.h"
#import "EventBarType.h"

@implementation EventToken

+ (NSString *)primaryKey {
    return @"identifier";
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
        @"fooEvents": [RLMPropertyDescriptor descriptorWithClass:EventFooType.class propertyName:@"token"],
        @"barEvents": [RLMPropertyDescriptor descriptorWithClass:EventBarType.class propertyName:@"token"]
    };
}

@end
