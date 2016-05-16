//
//  NSDictionary+TypeCheck.m
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import "NSDictionary+TypeCheck.h"

@implementation NSDictionary (TypeCheck)

- (NSString*)stringForKey:(id)aKey {
    return [self objectForKey:aKey kindOf:[NSString class]];
}

- (NSNumber*)numberForKey:(id)aKey {
    return [self objectForKey:aKey kindOf:[NSNumber class]];
}

- (NSArray*)arrayForKey:(id)aKey {
    return [self objectForKey:aKey kindOf:[NSArray class]];
}

- (NSDictionary*)dictionaryForKey:(id)aKey {
    return [self objectForKey:aKey kindOf:[NSDictionary class]];
}

- (id)objectForKey:(id)aKey kindOf:(Class)type {
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:type]) {
        return obj;
    }
    return nil;
}

- (id)objectForKey:(id)aKey memberOf:(Class)type {
    id obj = [self objectForKey:aKey];
    if ([obj isMemberOfClass:type]) {
        return obj;
    }
    return nil;
}

@end
