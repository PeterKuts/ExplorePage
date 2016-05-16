//
//  PCRoot.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "PCRoot.h"
#import "PCActivity.h"

#import "NSDictionary+TypeCheck.h"

@interface PCRoot()

@property (nonatomic, assign, readwrite) NSInteger totalItems;
@property (nonatomic, strong, readwrite) NSArray<PCActivity*> *activities;

@end

@implementation PCRoot

- (instancetype)init {
    return [self initWithModelDictionary:nil];
}

- (instancetype)initWithModelDictionary:(NSDictionary*)modelDictionary {
    if (self = [super init]) {
        NSDictionary *data = [modelDictionary dictionaryForKey:@"data"];
        self.totalItems = [[data numberForKey:@"totalItems"] integerValue];
        self.activities = [PCActivity activitiesWithModelArray:[data arrayForKey:@"items"]];
    }
    return self;
}

@end
