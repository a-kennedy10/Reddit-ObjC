//
//  AKPostController.m
//  RedditiOSObjectiveC
//
//  Created by Alex Kennedy on 9/30/20.
//  Copyright © 2020 Alex Kennedy. All rights reserved.
//

#import "AKPostController.h"
#import "AKPost.h"

@implementation AKPostController

+(instancetype)sharedController
{
    static AKPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AKPostController alloc] init];
    });
    return sharedInstance;
}

//MARK: - Properties

- (NSURL *)baseURL
{
    return [NSURL URLWithString:@"https://www.reddit.com/r/"];
}

//MARK: - fetch
- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<AKPost *> * _Nonnull, NSError * _Nonnull))completion
{
    // built url, that the user searches with the json extension
    NSURL *searchURL = [self baseURL];
    searchURL = [searchURL URLByAppendingPathComponent:searchTerm];
    searchURL = [searchURL URLByAppendingPathExtension:@"json"];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:searchURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // error handling
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil, error);
            return;
        }
        
        if (!data)
        {
            NSLog(@"Error, no data returned from task");
            completion(nil, error);
            return;
        }
        
        // get the json
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        if(!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"JSONDictionary is not a dictionary class");
            completion(nil, error);
            return;
        }
        
        NSDictionary *postDataDictionaries = jsonDictionary[@"data"];
        NSArray *childrenArray = postDataDictionaries[@"children"];
        //we need a placeholder array so we can complete with the type of object that we defined ([AKPost])
        NSMutableArray *postsArray = [NSMutableArray array];
        
        for (NSDictionary *dataDictionary in childrenArray)
        {
            AKPost *post = [[AKPost alloc] initwithDictionary:dataDictionary];
            [postsArray addObject:post];
        }
        
        completion(postsArray, nil);
        
        
    }]resume];
}


@end
