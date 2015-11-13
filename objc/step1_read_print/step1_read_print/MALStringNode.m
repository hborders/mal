//
//  MALStringNode.m
//  step1_read_print
//
//  Created by Heath Borders on 11/12/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALStringNode.h"
#import "MALChunkNode.h"
#import "MALBackslashedStringNode.h"

@interface MALStringNode ()

@property (nonatomic, weak) id<MALContainerNode> _Nullable parentContainerNode;
@property (nonatomic) NSMutableArray<id<MALNode>> * _Nonnull childNodes;

@end


@implementation MALStringNode

#pragma mark - init/dealloc

- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode {
    self = [super init];
    if (self) {
        _parentContainerNode = parentContainerNode;
        _childNodes = [NSMutableArray new];
    }
    return self;
}

#pragma mark - MALNode

- (nonnull NSString *)description {
    NSMutableString *description = [@"\"" mutableCopy];
    for (id<MALNode> childNode in self.childNodes) {
        [description appendString:childNode.description];
    }
    [description appendString:@"\""];
    
    return description;
}

#pragma mark - MALContainerNode

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode {
    if ([chunkNode isEqual:[MALChunkNode backslashChunkNode]]) {
        MALBackslashedStringNode *backslashedStringNode = [[MALBackslashedStringNode alloc] initWithParentContainerNode:self];
        [self.childNodes addObject:backslashedStringNode];
        return backslashedStringNode;
    } else if ([chunkNode isEqual:[MALChunkNode doubleQuoteChunkNode]]) {
        id<MALContainerNode> parentContainerNode = self.parentContainerNode;
        NSAssert(parentContainerNode, @"self.parentContainerNode has been deallocated");
        return parentContainerNode;
    } else {
        [self.childNodes addObject:chunkNode];
        return self;
    }
}

@end
