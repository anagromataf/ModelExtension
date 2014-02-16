//
//  ModelExtensionTests.m
//  ModelExtensionTests
//
//  Created by Tobias Kräntzer on 16.02.14.
//  Copyright (c) 2014 Tobias Kräntzer. All rights reserved.
//

#import "ModelExtension.h"

#import <XCTest/XCTest.h>

@interface ModelExtensionTests : XCTestCase
@property (nonatomic, strong) NSManagedObjectModel *baseModel;
@property (nonatomic, strong) NSManagedObjectModel *modelExtension;
@end

@implementation ModelExtensionTests

- (void)setUp
{
    [super setUp];
    
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    
    NSURL *baseModelURL = [frameworkBundle URLForResource:@"Base" withExtension:@"momd"];
    self.baseModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:baseModelURL];
    
    NSURL *modelExtension = [frameworkBundle URLForResource:@"Extension" withExtension:@"momd"];
    self.modelExtension = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelExtension];
}

#pragma mark Tests

- (void)testExtendedModel
{
    NSManagedObjectModel *extendedModel = [self.baseModel modelByExtendingWithModels:@[self.modelExtension]];
    
    XCTAssertNotNil(extendedModel);

    NSSet *entityNames = [NSSet setWithArray:[[extendedModel entitiesByName] allKeys]];
    NSSet *expectedEntityNames = [NSSet setWithObjects:@"Item", @"Collection", @"ExtendedCollection", @"Metadata", nil];
    XCTAssertEqualObjects(entityNames, expectedEntityNames);
    
    NSEntityDescription *collection = [[extendedModel entitiesByName] objectForKey:@"Collection"];
    NSEntityDescription *extendedCollection = [[extendedModel entitiesByName] objectForKey:@"ExtendedCollection"];
    XCTAssertNotNil(extendedCollection);
    XCTAssertEqualObjects(collection, extendedCollection.superentity);
}

@end
