//
//  AKPostController.h
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@class AKPost;

@interface AKPostController : NSObject

+ (instancetype)sharedController;

-(void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray<AKPost *> *posts, NSError *error))completion;
    // ABOVE - either come back with an array of post, or an error 

@end

NS_ASSUME_NONNULL_END
