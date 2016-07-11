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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RLMRealmConfiguration *defaultConfig = [RLMRealmConfiguration defaultConfiguration];
    defaultConfig.deleteRealmIfMigrationNeeded = YES;
    [RLMRealmConfiguration setDefaultConfiguration:defaultConfig];
    
#warning without this runtime error occures saying that Dog is not persistent in realm (probably because on Appointment.initWithValue scheme was not initialized)
    [RLMRealm defaultRealm];
    
    EventFooType *p1 = [[EventFooType alloc] initWithValue:@{
                                                @"identifier": @(1),
                                                @"fooIntProperty": @(1),
                                                @"token": @{@"identifier": @(1)}
                                                }];
    EventFooType *p3 = [[EventFooType alloc] initWithValue:@{
                                                @"identifier": @(2),
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
        [realm addOrUpdateObjectsFromArray:@[p1, p3]];
        [realm addOrUpdateObjectsFromArray:@[p2]];
    }];
    
    NSAssert([EventFooType allObjects].count == 2, nil);
    NSAssert([EventBarType allObjects].count == 1, nil);
    NSAssert([EventToken allObjects].count == 3, nil);
    
    RLMResults *fooEvents = [EventToken objectsWhere:@"ANY fooEvents.fooIntProperty = %@", @(1)];
    NSAssert(fooEvents.count == 1, nil);
    
    [fooEvents.realm transactionWithBlock:^{
        p1.fooIntProperty = 2;
    }];
    
    RLMResults *newlyQueriedFooEvents = [EventToken objectsWhere:@"ANY fooEvents.fooIntProperty = %@", @(1)];
    NSAssert(newlyQueriedFooEvents.count == 0, nil);
    
    NSAssert(fooEvents.count == 0, @"fooEvents RLMResults is expected to be updated after transaction");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
