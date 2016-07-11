//
//  EventBarType.h
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import <Realm/Realm.h>
#import "EventToken.h"

@interface EventBarType : RLMObject

@property NSInteger identifier;
@property NSInteger barIntProperty;
@property EventToken *token;

@end
