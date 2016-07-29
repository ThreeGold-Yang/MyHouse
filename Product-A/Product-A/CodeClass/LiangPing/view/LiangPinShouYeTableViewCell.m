//
//  LiangPinShouYeTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPinShouYeTableViewCell.h"

@implementation LiangPinShouYeTableViewCell

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
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
        
        self.buyBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [self.contentView addSubview:self.buyBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(20, 20, kScreenWidth - 40, 150);
    self.titleL.frame = CGRectMake(20, 190, (kScreenWidth - 40)*3/4, 20);
    self.buyBtn.frame = CGRectMake(20 + (kScreenWidth - 40)*3/4, 190, (kScreenWidth - 40)/4, 20);
}

-(void)setModel:(LiangPinShouYeModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.titleL.text = model.title;
        [self.buyBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
    }
}


@end
