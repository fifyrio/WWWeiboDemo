//
//  DemoViewModel.h
//  Demo
//
//  Created by wuw on 2018/3/2.
//  Copyright © 2018年 fifyrio. All rights reserved.
//

#import "XYViewModel.h"
#import "DemoViewCellViewModel.h"

@interface DemoViewModel : XYViewModel

@property (nonatomic, retain) NSMutableArray <DemoViewCellViewModel *>*dataArray;

@property (nonatomic, strong) RACCommand *refreshDataCommand;

@property (nonatomic, strong) RACSubject *refreshDataEndSubject;

@end
