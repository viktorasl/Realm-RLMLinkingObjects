//
//  Person.h
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import <Realm/Realm.h>
#import "Dog.h"

@interface Person : RLMObject

@property NSInteger identifier;
@property NSInteger dogwalkersGroupId;
@property NSString *name;
@property RLMArray<Dog *><Dog> *dogs;

@end
