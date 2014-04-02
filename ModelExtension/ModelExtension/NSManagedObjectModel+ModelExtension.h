//
//  NSManagedObjectModel+ModelExtension.h
//  ModelExtension
//
//  Created by Tobias Kräntzer on 16.02.14.
//  Copyright (c) 2014 Tobias Kräntzer. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectModel (ModelExtension)

- (NSManagedObjectModel *)modelByExtendingWithModels:(NSArray *)models;

@end
