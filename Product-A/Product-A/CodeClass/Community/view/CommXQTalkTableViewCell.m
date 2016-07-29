//
//  CommXQTalkTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommXQTalkTableViewCell.h"

@implementation CommXQTalkTableViewCell

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
        self.talkPerImageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.talkPerImageV];
        
        self.talkPerL = [[UILabel alloc]init];
        [self.contentView addSubview:self.talkPerL];
        
        self.talkDayL = [[UILabel alloc]init];
        self.talkDayL.font = [UIFont systemFontOfSize:15];
        self.talkDayL.alpha = 0.5;
        [self.contentView addSubview:self.talkDayL];
        
        self.zanBtn = [[UIButton alloc]init];
        [self.zanBtn setTitle:@"赞" forState:(UIControlStateNormal)];
        self.zanBtn.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.zanBtn];
        
        self.zanNumL = [[UILabel alloc]init];
        [self.contentView addSubview:self.zanNumL];
        
        self.talkContentL = [[UILabel alloc]init];
        self.talkContentL.font = [UIFont systemFontOfSize:15];
        self.talkContentL.alpha = 0.5;
        self.talkContentL.numberOfLines = 0;
        [self.contentView addSubview:self.talkContentL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.talkPerImageV.frame = CGRectMake(20, 15, 50, 50);
    self.talkPerL.frame = CGRectMake(80, 15, 150, 25);
    self.talkDayL.frame = CGRectMake(80, 40, 150, 25);
    self.zanBtn.frame = CGRectMake(kScreenWidth-100, 15, 30, 20);
    self.zanNumL.frame = CGRectMake(kScreenWidth-70, 15, 50, 20);
    CGFloat h = [justHeight justHeightBy:self.talkContentL.text font:15 width:kScreenWidth-40];
    self.talkContentL.frame = CGRectMake(20, 85, kScreenWidth-40, h);
}

-(void)setModel:(CommXQTalkModel *)model
{
    if (_model != model) {
        _model = model;
        [self.talkPerImageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:placeHoldImageURL completed:nil];
        self.talkPerL.text = model.uname;
        self.talkDayL.text = model.addtime_f;
        self.zanNumL.text = [NSString stringWithFormat:@"%@",model.cmtnum];
        self.talkContentL.text = model.content;
    }
}

@end
