//
//  MCXQTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCXQTableViewCell.h"

@implementation MCXQTableViewCell

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
        
        self.wifiV = [[UIImageView alloc]init];
        self.wifiV.image = [UIImage imageNamed:@"WiFi"];
        [self.contentView addSubview:self.wifiV];
        
        self.listenNumL = [[UILabel alloc]init];
        [self.contentView addSubview:self.listenNumL];
        
        self.playerV = [[UIImageView alloc]init];
        self.playerV.image = [UIImage imageNamed:@"music_icon_play_highlighted@2x"];
        [self.contentView addSubview:self.playerV];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(20, 12, 80, 80);
    self.titleL.frame = CGRectMake(110, 12, 150, 40);
    self.wifiV.frame = CGRectMake(110, 62, 30, 30);
    self.listenNumL.frame = CGRectMake(140, 62, 120, 30);
    self.playerV.frame = CGRectMake(kScreenWidth-20-50, 27, 50, 50);
}

-(void)setModel:(MCXQXiaBanModel *)model
{
    if (_model != model) {
        _model  = model;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.titleL.text = model.title;
        self.listenNumL.text = [NSString stringWithFormat:@"%@",model.musicVisit];
    }
}

@end
