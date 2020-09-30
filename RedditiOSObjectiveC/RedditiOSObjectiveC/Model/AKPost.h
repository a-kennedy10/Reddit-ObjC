//
//  AKPost.h
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AKPost : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, readonly) NSInteger ups;
@property (nonatomic, readonly) NSNumber *commentCount;

-(instancetype)initWithTitle:(NSString *)title
                         ups:(NSInteger)ups
                commentCount:(NSNumber *)commentCount;

@end

@interface AKPost (JSONConvertable)

-(instancetype)initwithDictionary:(NSDictionary *)dictionary;


@end


NS_ASSUME_NONNULL_END
