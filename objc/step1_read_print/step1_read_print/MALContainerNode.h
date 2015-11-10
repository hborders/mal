//
//  MALContainerNode.h
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import "MALNode.h"

@class MALChunkNode;

@protocol MALContainerNode <MALNode>

- (nonnull id<MALContainerNode>)containerNodeAfterConsumingChunkNode:(nonnull MALChunkNode *)chunkNode;

@end
