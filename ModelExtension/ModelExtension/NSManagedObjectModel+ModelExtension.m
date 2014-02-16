//
//  NSManagedObjectModel+ModelExtension.m
//  ModelExtension
//
//  Created by Tobias Kräntzer on 16.02.14.
//  Copyright (c) 2014 Tobias Kräntzer. All rights reserved.
//

#import "NSManagedObjectModel+ModelExtension.h"

@implementation NSManagedObjectModel (ModelExtension)

- (NSManagedObjectModel *)modelByExtendingWithModels:(NSArray *)models
{
    NSManagedObjectModel *baseModel = [self copy];
    NSDictionary *baseEntities = [baseModel entitiesByName];
    
    [models enumerateObjectsUsingBlock:^(NSManagedObjectModel *_model, NSUInteger idx, BOOL *stop) {
        NSManagedObjectModel *model = [_model copy];
        NSMutableArray *entities = [[NSMutableArray alloc] init];
        for (NSEntityDescription *entity in model) {
            NSEntityDescription *superentity = [baseEntities objectForKey:entity.name];
            if (superentity) {
                NSAssert([entity.properties count] == 0, @"A Placeholder Entity ('%@') must not contain properties.", entity.name);
                NSArray *subentities = entity.subentities;
                [entity setSubentities:@[]];
                superentity.subentities = [superentity.subentities arrayByAddingObjectsFromArray:subentities];
            } else {
                [entities addObject:entity];
            }
        }
        [model setEntities:@[]];
        [baseModel setEntities:[[baseModel entities] arrayByAddingObjectsFromArray:entities]];
    }];
    
    return baseModel;
}

@end
