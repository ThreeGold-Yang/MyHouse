//
//  McBiaoTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "McBiaoTableViewCell.h"

@implementation McBiaoTableViewCell

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
        
        self.unameL = [[UILabel alloc]init];
        self.unameL.font = [UIFont systemFontOfSize:15];
        self.unameL.alpha = 0.5;
        [self.contentView addSubview:self.unameL];
        
        self.contentL = [[UILabel alloc]init];
        self.contentL.font = [UIFont systemFontOfSize:15];
        self.contentL.alpha = 0.5;
        [self.contentView addSubview:self.contentL];
        
        self.wifiV = [[UIImageView alloc]init];
        self.wifiV.image = [UIImage imageNamed:@"WiFi"];
        self.wifiV.alpha = 0.5;
        [self.contentView addSubview:self.wifiV];
        
        self.shouTingNumL = [[UILabel alloc]init];
        self.shouTingNumL.alpha = 0.5;
        [self.contentView addSubview:self.shouTingNumL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10, 10, 100, 100);
    self.titleL.frame = CGRectMake(117, 15, 100, 20);
    self.unameL.frame = CGRectMake(117, 45, 100, 20);
    self.contentL.frame = CGRectMake(117, 75, 200, 20);
    self.shouTingNumL.frame = CGRectMake(kScreenWidth-100, 15, 100, 20);
    self.wifiV.frame = CGRectMake(kScreenWidth-20-100, 15, 20, 20);
}


-(void)setModel:(MCBiaoModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.titleL.text = model.title;
        self.unameL.text = [NSString stringWithFormat:@"by:%@",model.uname];
        self.shouTingNumL.text = [NSString stringWithFormat:@"%@",model.count];
        self.contentL.text = model.desc;
    }
}









@end
