//
//  Dog.h
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import <Realm/Realm.h>

@interface Dog : RLMObject

@property (nonatomic) NSInteger identifier;
@property (readonly) RLMLinkingObjects *owners;

@end

RLM_ARRAY_TYPE(Dog)
