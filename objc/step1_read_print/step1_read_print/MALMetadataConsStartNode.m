//
//  MALMetadataConsStartNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/16/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALMetadataConsStartNode.h"
#import "MALConsNode.h"

@interface MALMetadataConsStartNode ()

@property (nonatomic) MALConsNode * _Nonnull consNode;

@end

@implementation MALMetadataConsStartNode

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        _consNode = [[MALConsNode alloc] initWithType:MALConsNodeTypeList
                                  parentContainerNode:parentContainerNode];
    }
}

@end
