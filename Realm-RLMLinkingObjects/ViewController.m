//
//  ViewController.m
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import "ViewController.h"
#import "EventFooType.h"
#import "EventBarType.h"

@interface EventToken(EventTokenAll)

@end

@implementation EventToken(EventTokenAll)

+ (RLMResults *)particularFooEventIntPropertyTokens {
    return [self objectsWhere:@"ANY fooEvents.fooIntProperty >= %@ AND ANY fooEvents.fooIntProperty <= %@", @(1), @(10)];
}

@end

@interface ViewController ()

@property (nonatomic) EventFooType *p1;
@property (nonatomic) RLMNotificationToken *fooTypeEventsNotificationToken;
@property (nonatomic) RLMResults *fooEvents;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RLMRealmConfiguration *defaultConfig = [RLMRealmConfiguration defaultConfiguration];
    defaultConfig.deleteRealmIfMigrationNeeded = YES;
    [RLMRealmConfiguration setDefaultConfiguration:defaultConfig];
    
#warning Q2: without explicitly calling this runtime error occures stating:\\
    *** Terminating app due to uncaught exception 'RLMException', reason: 'Object type 'EventToken' not persisted in Realm'
    [RLMRealm defaultRealm];
    
    self.p1 = [[EventFooType alloc] initWithValue:@{
                                                @"identifier": @(1),
                                                @"name": @"Some Event name",
                                                @"fooIntProperty": @(1),
                                                @"token": @{@"identifier": @(1)}
                                                }];
    EventFooType *p3 = [[EventFooType alloc] initWithValue:@{
                                                @"identifier": @(2),
                                                @"name": @"Some other Event name",
                                                @"fooIntProperty": @(2),
                                                @"token": @{@"identifier": @(2)}
                                                }];
    
    EventBarType *p2 = [[EventBarType alloc] initWithValue:@{
                                                 @"identifier": @(1),
                                                 @"barIntProperty": @(1),
                                                 @"token": @{@"identifier": @(3)}
                                                 }];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:@[self.p1, p3]];
        [realm addOrUpdateObjectsFromArray:@[p2]];
    }];
    
    NSAssert([EventFooType allObjects].count == 2, nil);
    NSAssert([EventBarType allObjects].count == 1, nil);
    NSAssert([EventToken allObjects].count == 3, nil);
    
    self.fooEvents = [EventToken particularFooEventIntPropertyTokens];
    NSAssert(self.fooEvents.count == 2, nil);
    
    self.fooTypeEventsNotificationToken = [self.fooEvents addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        NSLog(@"Notification block has been called");
    }];
}

- (IBAction)setP1FooIntPropertyTo12:(UIButton *)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        self.p1.fooIntProperty = 12;
    }];
}

- (IBAction)setP1FooIntPropertyTo8:(UIButton *)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        self.p1.fooIntProperty = 8;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
