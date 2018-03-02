//
//  DemoViewModel.m
//  Demo
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "DemoViewModel.h"
#import "WeiboModel.h"
#import <MJExtension.h>
#import "DemoViewCellViewModel.h"
#import "NSString+Additions.h"

@implementation DemoViewModel

#pragma mark - Protocol
- (void)xy_initialize{
    /*订阅信号*/
    @weakify(self);
    [self.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(NSMutableArray <WeiboModel *>*models){
        @strongify(self);
        NSMutableArray *dataArray = @[].mutableCopy;
        if (models.count) {
            [models enumerateObjectsUsingBlock:^(WeiboModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                DemoViewCellViewModel *viewModel = [DemoViewCellViewModel new];
                viewModel.avatarUrl = obj.user.avatar_large;
                viewModel.username = obj.user.screen_name;
                if (obj.source.length > 6) {
                    NSInteger start = [obj.source indexOf:@"\">"]+2;
                    NSInteger end = [obj.source indexOf:@"</a>"];
                    viewModel.from = [obj.source substringFromIndex:start toIndex:end];
                }else{
                    viewModel.from = @"未知";
                }
                viewModel.time = obj.created_at;
                viewModel.reports = [[self class] formatNumberFrom:obj.reposts_count];
                viewModel.comments = [[self class] formatNumberFrom:obj.comments_count];
                viewModel.text = obj.text;
                
                if (obj.retweeted_status) {
                    DemoViewCellViewModelSubData *subData = [DemoViewCellViewModelSubData new];
                    subData.avatarUrl = obj.retweeted_status.user.avatar_large;
                    subData.username = obj.retweeted_status.user.screen_name;
                    subData.text = [NSString stringWithFormat:@"@%@: %@", subData.username, obj.retweeted_status.text];
                    subData.picUrls = [[self class] formatPicUrlsFrom:obj.retweeted_status.pic_urls url:obj.retweeted_status.thumbnail_pic picIds:obj.retweeted_status.pic_ids];
                    viewModel.subData = subData;
                }else{
                    viewModel.picUrls = [[self class] formatPicUrlsFrom:obj.pic_urls url:obj.thumbnail_pic picIds:obj.pic_ids];
                }
                
                [dataArray addObject:viewModel];
            }];
        }
        self.dataArray = dataArray;
        [self.refreshDataEndSubject sendNext:nil];
    }];
}

#pragma mark - Tools
+ (NSString *)formatNumberFrom:(NSString *)numberString{
    NSInteger number = [numberString integerValue];
    if (number>=10000) {
        return [NSString stringWithFormat:@"  %.1fw", number/10000.0];
    } else {
        if (number>0) {
            return [NSString stringWithFormat:@"  %ld", (long)number];
        } else {
            return @"";
        }
    }
}

+ (NSArray *)formatPicUrlsFrom:(NSArray *)picUrls url:(NSString *)url picIds:(NSArray *)picIds{
    if (picIds && picIds.count>1) {
        NSString *typeStr = @"jpg";
        if (picIds.count>0||url.length>0) {
            typeStr = [url substringFromIndex:url.length-3];
        }
        NSMutableArray *temp = [NSMutableArray array];
        for (NSString *pic_url in picIds) {
            [temp addObject:@{@"thumbnail_pic": [NSString stringWithFormat:@"http://ww2.sinaimg.cn/thumbnail/%@.%@", pic_url, typeStr]}];
        }
        return temp.copy;
    } else {
        return picUrls;
    }
}

#pragma mark - Lazy load

- (RACCommand *)refreshDataCommand{
    if (_refreshDataCommand == nil) {
        _refreshDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            //创建信号,用来传递数据
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSArray *temp = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
                NSMutableArray *models = [WeiboModel mj_objectArrayWithKeyValuesArray:temp];
                [subscriber sendNext:models];
                [subscriber sendCompleted];                            
                
                return nil;
            }];
        }];
    }
    return _refreshDataCommand;
}

- (RACSubject *)refreshDataEndSubject{
    if (_refreshDataEndSubject == nil) {
        _refreshDataEndSubject = [RACSubject subject];
    }
    return _refreshDataEndSubject;
}

@end
