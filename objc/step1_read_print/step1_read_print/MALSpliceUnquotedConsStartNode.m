//
//  MALSpliceUnquotedConsStartNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/13/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALSpliceUnquotedConsStartNode.h"
#import "MALConsNode.h"
#import "MALChunkNode.h"

@interface MALSpliceUnquotedConsStartNode ()

@property (nonatomic) MALConsNode * _Nonnull consNode;

@end

@implementation MALSpliceUnquotedConsStartNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithConsNode:(nonnull MALConsNode *)consNode {
    self = [super init];
    if (self) {
        _consNode = consNode;
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    return self.consNode.description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    return [self.consNode containerNodeAfterConsumingChunkNode:chunkNode];
}

@end
