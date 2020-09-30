//
//  AKPost.m
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
// https://www.reddit.com/r/funny.json

#import "AKPost.h"

@implementation AKPost

-(instancetype)initWithTitle:(NSString *)title ups:(NSInteger)ups commentCount:(NSNumber *)commentCount
{
    self = [super init];
    if (self)
    {
        _title = [title copy];
        _ups = ups;
        _commentCount = [commentCount copy];
    }
    return self;
}

-(instancetype)initwithDictionary:(NSDictionary *)dictionary
{
    // get each post from the data key (dictionary)
    NSDictionary *dataDictionary = dictionary[@"data"];
    
    //When youre inside the innermost dataDictionary which holds the object that you want to initialize, that is when you can define your properties that come from the json
    
    NSString *title = dataDictionary[[AKPost titleKey]];
    NSInteger ups = [dataDictionary[[AKPost ups]] integerValue];
    NSNumber *commentCount = dataDictionary[[AKPost commentCount]];
    
    return [self initWithTitle:title ups:ups commentCount:commentCount];
}

//MARK: - keys

+(NSString *)titleKey
{
    return @"title";
}

+(NSString *)ups
{
    return @"ups";
}

+(NSString *)commentCount
{
    return @"num_comments";
}

@end
