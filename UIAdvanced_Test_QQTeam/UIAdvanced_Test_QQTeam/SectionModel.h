//
//  SectionModel.h
//  UIAdvanced_Test_QQTeam
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SectionModel : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *online;
@property(nonatomic,strong) NSMutableArray *friends;

@property(nonatomic,assign) BOOL isChoose;

@end
