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

typedef NS_ENUM(NSInteger, MALConsNodePrivateType) {
    MALConsNodePrivateTypeRoot,
    MALConsNodePrivateTypeList,
    MALConsNodePrivateTypeVector,
};

@interface MALConsNode ()

@property (nonatomic) MALConsNodePrivateType privateType;
@property (nonatomic, weak) id<MALContainerNode> _Nullable parentContainerNode;
@property (nonatomic) NSMutableArray<id<MALNode>>  * _Nonnull nodes;

@end

@implementation MALConsNode

#pragma mark - init/dealloc

- (nonnull instancetype)init {
    self = [super init];
    if (self) {
        _privateType = MALConsNodePrivateTypeRoot;
        _nodes = [NSMutableArray new];
    }
    return self;
}

- (nonnull instancetype)initWithType:(MALConsNodeType)type
                 parentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        switch (type) {
            case MALConsNodeTypeList:
                _privateType = MALConsNodePrivateTypeList;
                break;
            case MALConsNodeTypeVector:
                _privateType = MALConsNodePrivateTypeVector;
                break;
        }
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
        MALConsNode *listConsNode = [[MALConsNode alloc] initWithType:MALConsNodeTypeList
                                              parentContainerNode:self];
        [self.nodes addObject:listConsNode];
        return listConsNode;
    } else if ([chunkNode isEqual:[MALChunkNode openSquareBracketChunkNode]]) {
        MALConsNode *vectorConsNode = [[MALConsNode alloc] initWithType:MALConsNodeTypeVector
                                              parentContainerNode:self];
        [self.nodes addObject:vectorConsNode];
        return vectorConsNode;
    } else if ([chunkNode isEqual:[MALChunkNode closeParensChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return parentContainerNode;
    } else if ([chunkNode isEqual:[MALChunkNode closeSquareBracketChunkNode]]) {
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
    switch (self.privateType) {
        case MALConsNodePrivateTypeRoot:
            // don't wrap with anything
            break;
        case MALConsNodePrivateTypeList:
            [nodeDescription insertString:@"("
                                  atIndex:0];
            [nodeDescription appendString:@")"];
            break;
        case MALConsNodePrivateTypeVector:
            [nodeDescription insertString:@"["
                                  atIndex:0];
            [nodeDescription appendString:@"]"];
            break;
    }
    return nodeDescription;
}

#pragma mark - Public API

- (void)appendLiteralNode:(nonnull MALLiteralNode *)literalNode {
    [self.nodes addObject:literalNode];
}

@end
