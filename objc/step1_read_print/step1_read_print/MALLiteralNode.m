//
//  MALLiteralNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALLiteralNode.h"
#import "MALChunkNode.h"
#import "MALChunkNodeScanner.h"

@interface MALLiteralNode()

@property (nonatomic, weak) id<MALContainerNode> _Nullable parentContainerNode;
@property (nonatomic) NSMutableArray<MALChunkNode *> * _Nonnull chunkNodes;

@end

@implementation MALLiteralNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode
                                          chunkNode:(nonnull MALChunkNode *)chunkNode {
    self = [super init];
    if (self) {
        _parentContainerNode = parentContainerNode;
        _chunkNodes = [@[
                         chunkNode,
                         ] mutableCopy];
    }
    return self;
}

- (nonnull instancetype)initWithParentContainerNode:(id<MALContainerNode>)parentContainerNode
                                             string:(nonnull NSString *)string {
    self = [super init];
    if (self) {
        _parentContainerNode = parentContainerNode;
        _chunkNodes = [MALChunkNodeScanner chunkNodesFromString:string];
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    NSMutableString *description = [NSMutableString new];
    for (MALChunkNode *chunkNode in self.chunkNodes) {
        [description appendString:chunkNode.description];
    }
    
    return description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    if ([chunkNode isEqual:[MALChunkNode spaceChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return parentContainerNode;
    } else if ([chunkNode isEqual:[MALChunkNode commaChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return parentContainerNode;
    } else if ([chunkNode isEqual:[MALChunkNode closeParensChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return [parentContainerNode containerNodeAfterConsumingChunkNode:chunkNode];
    } else if ([chunkNode isEqual:[MALChunkNode closeSquareBracketChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return [parentContainerNode containerNodeAfterConsumingChunkNode:chunkNode];
    } else {
        [self.chunkNodes addObject:chunkNode];
        return self;
    }
}

@end
