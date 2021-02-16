//
//  SearchEndModel.h
//  CyxbsMobile2019_iOS
//
//  Created by 石子涵 on 2021/2/16.
//  Copyright © 2021 Redrock. All rights reserved.
//
/**搜索结果页的网络请求model*/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchEndModel : NSObject
- (void)loadRelevantDynamicDataWithStr:(NSString *)str Page:(NSInteger)page Sucess:(void(^)(NSArray *array))sucess Failure:(void(^)(void))failure;
@end

NS_ASSUME_NONNULL_END
