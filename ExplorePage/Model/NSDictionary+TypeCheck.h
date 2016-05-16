//
//  NSDictionary+TypeCheck.h
//  ExplorePage
//
//  Created by user on 5/16/16.
//  Copyright © 2016 peterkuts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TypeCheck)

- (NSString*)stringForKey:(id)aKey;
- (NSNumber*)numberForKey:(id)aKey;
- (NSArray*)arrayForKey:(id)aKey;
- (NSDictionary*)dictionaryForKey:(id)aKey;

- (id)objectForKey:(id)aKey kindOf:(Class)type;
- (id)objectForKey:(id)aKey memberOf:(Class)type;

@end
