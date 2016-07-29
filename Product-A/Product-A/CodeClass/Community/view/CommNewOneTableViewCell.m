//
//  CommNewOneTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommNewOneTableViewCell.h"

@implementation CommNewOneTableViewCell

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
        self.titleL = [[UILabel alloc]init];
        self.titleL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.titleL];
        
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.contentL = [[UILabel alloc]init];
        self.contentL.font = [UIFont systemFontOfSize:15];
        self.contentL.textColor = [UIColor blackColor];
        self.contentL.alpha = 0.5;
        self.contentL.numberOfLines = 3;
        [self.contentView addSubview:self.contentL];
        
        self.dayL = [[UILabel alloc]init];
        self.dayL.font = [UIFont systemFontOfSize:15];
        self.dayL.textColor = [UIColor blackColor];
        self.dayL.alpha = 0.5;
        [self.contentView addSubview:self.dayL];
        
        self.pingLunImageV = [[UIImageView alloc]init];
        self.pingLunImageV.image = [UIImage imageNamed:@"chat"];
        [self.contentView addSubview:self.pingLunImageV];
        
        self.pingLunNumL = [[UILabel alloc]init];
        self.pingLunNumL.font = [UIFont systemFontOfSize:15];
        self.pingLunNumL.textColor = [UIColor blackColor];
        self.pingLunNumL.alpha = 0.5;
        
        [self.contentView addSubview:self.pingLunNumL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(20, 25, kScreenWidth-40, 50);
    self.imageV.frame = CGRectMake(20, 95, 80, 80);
    self.contentL.frame = CGRectMake(110, 95, kScreenWidth-130, 80);
    self.dayL.frame = CGRectMake(20, 195, 100, 30);
    self.pingLunImageV.frame = CGRectMake(kScreenWidth-150, 195, 30, 30);
    self.pingLunNumL.frame = CGRectMake(kScreenWidth-120, 195, 100, 30);
}

-(void)setModel:(CommShouYeModel *)model
{
    if (_model != model) {
        _model = model;
        self.titleL.text = model.title;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.contentL.text = model.content;
        self.dayL.text = model.addtime_f;
        self.pingLunNumL.text = [NSString stringWithFormat:@"%@",model.comment];
    }
}
@end
