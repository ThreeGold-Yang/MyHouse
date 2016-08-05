//
//  DIYTableViewCell.h
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@interface DIYTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imageViews;
@property(nonatomic,strong) UILabel *nameL;
@property(nonatomic,strong) UILabel *numberL;

@property(nonatomic,strong) Contact *Person;


@end
