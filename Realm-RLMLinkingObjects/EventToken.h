//
//  EventToken.h
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import <Realm/Realm.h>

@interface EventToken : RLMObject

@property (nonatomic) NSInteger identifier;
@property (readonly) RLMLinkingObjects *fooEvents;
@property (readonly) RLMLinkingObjects *barEvents;

@end
