//
//  ViewController.m
//  Realm-RLMLinkingObjects
//
//  Created by Viktoras Laukevičius on 11/07/16.
//  Copyright © 2016 Viktoras Laukevičius. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
#import "Person.h"

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
    
    Person *p1 = [[Person alloc] initWithValue:@{
                                                @"identifier": @(1),
                                                @"name": @"John Stockton",
                                                @"dogwalkersGroupId": @(1),
                                                @"dogs": @[
                                                    @{@"identifier": @(1)}
                                                ]
    }];
    
    Person *p2 = [[Person alloc] initWithValue:@{
                                                 @"identifier": @(2),
                                                 @"name": @"Karl Malone",
                                                 @"dogwalkersGroupId": @(2),
                                                 @"dogs": @[
                                                         @{@"identifier": @(2)}
                                                         ]
                                                 }];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:@[p1, p2]];
    }];
    
    NSAssert([Dog allObjects].count == 2, @"Dogs count expected to be equal to 1");
    NSAssert([Person allObjects].count == 2, @"People count expected to be equal to 1");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
