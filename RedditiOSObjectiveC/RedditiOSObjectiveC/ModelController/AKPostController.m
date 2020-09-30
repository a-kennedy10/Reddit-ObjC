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
- (void)searchForPostWithSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<AKPost *> *, NSError *))completion
{
    // built url, that the user searches with the json extension
    NSURL *searchURL = [self baseURL];
    searchURL = [searchURL URLByAppendingPathComponent:searchTerm];
    NSURL *finalURL = [searchURL URLByAppendingPathExtension:@"json"];
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
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
        // now that we have access to the top level dictionary (jsonDictionary) we can subscript and drill down into the data, to get access to the data we need
        NSDictionary *postData = jsonDictionary[@"data"];
        NSArray *childrenArray = postData[@"children"];
        // the last json "layer" was already created in our model implementation
        
        //we need a placeholder array so we can complete with the type of object that we defined ([AKPost])
        NSMutableArray *postsArray = [NSMutableArray array];
        
        for (NSDictionary *dataDictionary in childrenArray)
        {
            AKPost *post = [[AKPost alloc] initwithDictionary:dataDictionary];
            //add objects to the created post array
            [postsArray addObject:post];
        }
        
        completion(postsArray, nil);
                
    }]resume];
}


@end
