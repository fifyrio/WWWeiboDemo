//
//  WeiboModel.h
//  tableView
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 Kingnet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString *avatar_large;

@property (nonatomic, copy) NSString *screen_name;

@end

@interface Retweet : NSObject

@property (nonatomic, strong) User *user;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSArray *pic_urls;

@property (nonatomic, copy) NSString *thumbnail_pic;

@property (nonatomic, copy) NSArray *pic_ids;

@end

@interface WeiboModel : NSObject

@property (nonatomic, copy) NSString *source;

@property (nonatomic, strong) User *user;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *reposts_count;

@property (nonatomic, copy) NSString *comments_count;

@property (nonatomic, strong) Retweet *retweeted_status;

@property (nonatomic, copy) NSArray *pic_urls;

@property (nonatomic, copy) NSString *thumbnail_pic;

@property (nonatomic, copy) NSArray *pic_ids;

@end
