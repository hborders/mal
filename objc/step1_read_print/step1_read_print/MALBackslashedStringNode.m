//
//  MALQuotedBackslashedLiteralNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/12/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALBackslashedStringNode.h"
#import "MALChunkNode.h"

@interface MALBackslashedStringNode ()

@property (nonatomic, weak) id<MALContainerNode> _Nullable parentContainerNode;
@property (nonatomic) MALChunkNode * _Nullable quotedBackslashedChunkNode;

@end

@implementation MALBackslashedStringNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        _parentContainerNode = parentContainerNode;
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    MALChunkNode *quotedBackslashedChunkNode = self.quotedBackslashedChunkNode;
    if (quotedBackslashedChunkNode) {
        return [@"\\" stringByAppendingString:quotedBackslashedChunkNode.description];
    } else {
        return @"";
    }
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    id<MALContainerNode> parentContainerNode = self.parentContainerNode;
    NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
    self.quotedBackslashedChunkNode = chunkNode;
    return parentContainerNode;
}

@end
