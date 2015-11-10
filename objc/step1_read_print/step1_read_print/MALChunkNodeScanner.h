//
//  MALChunkNodeScanner.h
//  step1_read_print
//
//  Created by Heath Borders on 11/10/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MALChunkNode;

@interface MALChunkNodeScanner : NSObject

+ (nonnull NSMutableArray<MALChunkNode *> *)chunkNodesFromString:(nonnull NSString *)string;

@end
