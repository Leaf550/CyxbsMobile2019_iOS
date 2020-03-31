//
//  HttpClient.h
//  Demo
//
//  Created by 李展 on 2016/11/13.
//  Copyright © 2016年 zhanlee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef NS_ENUM(NSInteger, HttpRequestType) {
    HttpRequestGet,
    HttpRequestPost,
    HttpRequestDelete,
    HttpRequestPut,
};
typedef void (^PrepareExecuteBlock)(void);

@interface HttpClient : NSObject
+ (HttpClient *)defaultClient;

- (void)requestWithHead:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
                   head:(NSDictionary *)head
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithPath:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithToken:(NSString *)url
        method:(NSInteger)method
    parameters:(id)parameters
prepareExecute:(PrepareExecuteBlock) prepare
      progress:(void (^)(NSProgress * progress))progress
       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithJson:(NSString *)url
                 method:(NSInteger)method
             parameters:(id)parameters
         prepareExecute:(PrepareExecuteBlock) prepare
               progress:(void (^)(NSProgress * progress))progress
                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)requestWithPathInHEAD:(NSString *)url
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)uploadImageWithJson:(NSString *)url
                     method:(NSInteger)method
                 parameters:(id)parameters imageArray:(NSArray<UIImage  *> *)imageArray imageNames:(NSArray<NSString *> *)imageNames
             prepareExecute:(PrepareExecuteBlock) prepare
                   progress:(void (^)(NSProgress * progress))progress
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
