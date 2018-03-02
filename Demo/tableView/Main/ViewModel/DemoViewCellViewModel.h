//
//  DemoViewCellViewModel.h
//  tableView
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 Kingnet. All rights reserved.
//

#import "XYViewModel.h"

@interface DemoViewCellViewModelSubData : NSObject

@property (nonatomic, copy) NSString *avatarUrl;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSArray *picUrls;

@end

@interface DemoViewCellViewModel : XYViewModel

@property (nonatomic, copy) NSString *avatarUrl;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *from;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *reports;

@property (nonatomic, copy) NSString *comments;

@property (nonatomic, strong) DemoViewCellViewModelSubData *subData;

@property (nonatomic, copy) NSArray *picUrls;

@end
