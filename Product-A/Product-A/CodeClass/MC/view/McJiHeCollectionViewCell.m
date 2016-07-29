//
//  McJiHeCollectionViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "McJiHeCollectionViewCell.h"

@implementation McJiHeCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.imageV.frame = CGRectMake(0, 0, 120, 150);
    self.imageV.frame = self.contentView.frame;
}


-(void)setModel:(MCJiHeModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
    }
}
@end
