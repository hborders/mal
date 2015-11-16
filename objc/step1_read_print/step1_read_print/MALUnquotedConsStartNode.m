//
//  MALUnquotedConsStartNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/13/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALUnquotedConsStartNode.h"
#import "MALConsNode.h"
#import "MALLiteralNode.h"
#import "MALChunkNode.h"
#import "MALSpliceUnquotedConsStartNode.h"

@interface MALUnquotedConsStartNode ()

@property (nonatomic) MALConsNode * _Nonnull consNode;

@end

@implementation MALUnquotedConsStartNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        _consNode = [[MALConsNode alloc] initWithType:MALConsNodeTypeList
                                  parentContainerNode:parentContainerNode];
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    return self.consNode.description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    if ([chunkNode isEqual:[MALChunkNode atChunkNode]]) {
        MALLiteralNode *unquoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:self.consNode
                                                                                          string:@"splice-unquote"];
        [self.consNode appendLiteralNode:unquoteLiteralNode];
        
        MALSpliceUnquotedConsStartNode *spliceUnquotedConsStartNode = [[MALSpliceUnquotedConsStartNode alloc] initWithConsNode:self.consNode];
        return spliceUnquotedConsStartNode;
    } else {
        MALLiteralNode *unquoteLiteralNode = [[MALLiteralNode alloc] initWithParentContainerNode:self.consNode
                                                                                          string:@"unquote"];
        [self.consNode appendLiteralNode:unquoteLiteralNode];
        return [self.consNode containerNodeAfterConsumingChunkNode:chunkNode];
    }
}

@end
