//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Enrique Aliaga on 11/14/18.
//  Copyright © 2018 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

+ (instancetype)sharedStore;

@property (nonatomic, readonly) NSArray *allItems;

- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;
- (BOOL)saveChanges;
- (NSArray *)allAssetTypes;

@end
