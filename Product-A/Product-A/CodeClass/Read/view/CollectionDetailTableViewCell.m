//
//  CollectionDetailTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CollectionDetailTableViewCell.h"

@implementation CollectionDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titL = [[UILabel alloc]init];
        self.titL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.titL];
        
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.intrL = [[UILabel alloc]init];
        self.intrL.alpha = 0.5;
        self.intrL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.intrL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titL.frame = CGRectMake(20, 25, kScreenWidth-40, 30);
    self.imageV.frame = CGRectMake(20, 72, (kScreenWidth-40)/2, 100);
    self.intrL.frame = CGRectMake(20+(kScreenWidth-40)/2+10, 72, (kScreenWidth-40)/2, 100);
}

-(void)setModel:(CollectionDetailModel *)model
{
    if (_model != model) {
        _model = model;
        self.titL.text = model.title;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.intrL.text = model.content;
    }
}

@end
