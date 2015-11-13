//
//  MALRootNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALConsNode.h"
#import "MALChunkNode.h"
#import "MALLiteralNode.h"
#import "MALQuotedConsStartNode.h"
#import "MALUnquotedConsStartNode.h"
#import "MALStringNode.h"

@interface MALConsNode ()

@property (nonatomic) BOOL rootNode;
@property (nonatomic, weak) id<MALContainerNode> _Nullable parentContainerNode;
@property (nonatomic) NSMutableArray<id<MALNode>>  * _Nonnull nodes;

@end

@implementation MALConsNode

#pragma mark - init/dealloc

- (nonnull instancetype)init {
    self = [super init];
    if (self) {
        _rootNode = YES;
        _nodes = [NSMutableArray new];
    }
    return self;
}

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        _rootNode = NO;
        _parentContainerNode = parentContainerNode;
        _nodes = [NSMutableArray new];
    }
    return self;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    if ([chunkNode isEqual:[MALChunkNode spaceChunkNode]]) {
        return self;
    } else if ([chunkNode isEqual:[MALChunkNode commaChunkNode]]) {
        return self;
    } else if ([chunkNode isEqual:[MALChunkNode openParensChunkNode]]) {
        MALConsNode *consNode = [[MALConsNode alloc] initWithParentContainerNode:self];
        [self.nodes addObject:consNode];
        return consNode;
    } else if ([chunkNode isEqual:[MALChunkNode closeParensChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return parentContainerNode;
    } else if ([chunkNode isEqual:[MALChunkNode singleQuoteChunkNode]]) {
        MALQuotedConsStartNode *quoteQuotedConsStartNode = [[MALQuotedConsStartNode alloc] initWithParentContainerNode:self
                                                                                                 type:MALQuotedConsStartNodeTypeQuote];
        [self.nodes addObject:quoteQuotedConsStartNode];
        return quoteQuotedConsStartNode;
    } else if ([chunkNode isEqual:[MALChunkNode backQuoteChunkNode]]) {
        MALQuotedConsStartNode *quasiQuoteConsNode = [[MALQuotedConsStartNode alloc] initWithParentContainerNode:self
                                                                                                type:MALQuotedConsStartNodeTypeQuasiQuote];
        [self.nodes addObject:quasiQuoteConsNode];
        return quasiQuoteConsNode;
    } else if ([chunkNode isEqual:[MALChunkNode tildeChunkNode]]) {
        MALUnquotedConsStartNode *unquoteQuoteConsNode = [[MALUnquotedConsStartNode alloc] initWithParentContainerNode:self];
        [self.nodes addObject:unquoteQuoteConsNode];
        return unquoteQuoteConsNode;
    } else if ([chunkNode isEqual:[MALChunkNode doubleQuoteChunkNode]]) {
        MALStringNode *stringNode = [[MALStringNode alloc] initWithParentContainerNode:self];
        [self.nodes addObject:stringNode];
        return stringNode;
    } else {
        MALLiteralNode *literalNode = [[MALLiteralNode alloc] initWithParentContainerNode:self
                                                                                chunkNode:chunkNode];
        [self.nodes addObject:literalNode];
        return literalNode;
    }
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    NSMutableArray<NSString *> * _Nonnull nodeDescriptions = [NSMutableArray arrayWithCapacity:self.nodes.count];
    for (id<MALNode> node in self.nodes) {
        [nodeDescriptions addObject:node.description];
    }
    
    NSMutableString *nodeDescription = [[nodeDescriptions componentsJoinedByString:@" "] mutableCopy];
    if (!self.rootNode) {
        [nodeDescription insertString:@"("
                              atIndex:0];
        [nodeDescription appendString:@")"];
    }
    return nodeDescription;
}

#pragma mark - Public API

- (void)appendLiteralNode:(nonnull MALLiteralNode *)literalNode {
    [self.nodes addObject:literalNode];
}

@end
