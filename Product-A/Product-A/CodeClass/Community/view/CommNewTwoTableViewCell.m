//
//  CommNewTwoTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommNewTwoTableViewCell.h"

@implementation CommNewTwoTableViewCell

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
        [self.contentView addSubview:self.titleL];
        
        self.contentL = [[UILabel alloc]init];
        self.contentL.font = [UIFont systemFontOfSize:15];
        self.contentL.textColor = [UIColor blackColor];
        self.contentL.alpha = 0.5;
        [self.contentView addSubview:self.contentL];
        
        self.dayL = [[UILabel alloc]init];
        self.dayL.font = [UIFont systemFontOfSize:15];
        self.dayL.textColor = [UIColor blackColor];
        self.dayL.alpha = 0.5;
        
        [self.contentView addSubview:self.dayL];
        
        self.pinglunImageV = [[UIImageView alloc]init];
        self.pinglunImageV.image = [UIImage imageNamed:@"chat"];
        [self.contentView addSubview:self.pinglunImageV];
        
        self.pinglunNumL = [[UILabel alloc]init];
        self.pinglunNumL.font = [UIFont systemFontOfSize:15];
        self.pinglunNumL.textColor = [UIColor blackColor];
        self.pinglunNumL.alpha = 0.5;
        [self.contentView addSubview:self.pinglunNumL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleL.frame = CGRectMake(20, 25, kScreenWidth-40, 50);
    self.contentL.frame = CGRectMake(20, 95, kScreenWidth-40, 50);
    self.dayL.frame = CGRectMake(20, 165, 100, 30);
    self.pinglunImageV.frame = CGRectMake(kScreenWidth-150, 165, 30, 30);
    self.pinglunNumL.frame = CGRectMake(kScreenWidth-120, 165, 100, 30);
}

-(void)setModel:(CommShouYeModel *)model
{
    if (_model != model) {
        _model = model;
        self.titleL.text = model.title;
        self.contentL.text = model.content;
        self.dayL.text = model.addtime_f;
        self.pinglunNumL.text = [NSString stringWithFormat:@"%@",model.comment];
    }
}


@end
