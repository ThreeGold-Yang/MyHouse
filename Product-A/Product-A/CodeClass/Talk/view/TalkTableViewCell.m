//
//  TalkTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TalkTableViewCell.h"

@implementation TalkTableViewCell

- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.unameL = [[UILabel alloc]init];
        self.unameL.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.unameL];
        
        self.timeL = [[UILabel alloc]init];
        self.timeL.font = [UIFont systemFontOfSize:15];
        self.timeL.alpha = 0.5;
        [self.contentView addSubview:self.timeL];
        
        self.talkContentL = [[UILabel alloc]init];
        self.talkContentL.numberOfLines = 0;
        self.talkContentL.alpha = 0.5;
        self.talkContentL.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.talkContentL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(20, 15, 80, 80);
    self.unameL.frame = CGRectMake(110, 25, 150, 30);
    self.timeL.frame = CGRectMake(110, 55, 150, 30);
    CGFloat xx = [justHeight justHeightBy:self.talkContentL.text font:15 width:kScreenWidth-40];
    self.talkContentL.frame = CGRectMake(20, 110, kScreenWidth-40, xx);
}

-(void)setModel:(PinLunModel *)model
{
    if (_model != model) {
        _model = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:placeHoldImageURL completed:nil];
        self.unameL.text= model.uname;
        self.timeL.text = model.addtime_f;
        self.talkContentL.text = model.content;
    }
}
@end
