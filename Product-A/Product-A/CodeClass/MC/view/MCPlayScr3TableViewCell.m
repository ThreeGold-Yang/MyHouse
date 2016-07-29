//
//  MCPlayScr3TableViewCell.m
//  Product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCPlayScr3TableViewCell.h"

@implementation MCPlayScr3TableViewCell

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
        self.musicNameL = [[UILabel alloc]init];
        [self.contentView addSubview:self.musicNameL];
        
        self.musicPersonL = [[UILabel alloc]init];
        self.musicPersonL.textColor = PKCOLOR(155, 155, 155);
        [self.contentView addSubview:self.musicPersonL];
        
        self.downLoadBtn = [[UIButton alloc]init];
        [self.contentView addSubview:self.downLoadBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.musicNameL.frame = CGRectMake(16, 0, 200, 30);
    self.musicPersonL.frame = CGRectMake(16, 30, 200, 30);
    self.downLoadBtn.frame = CGRectMake(kScreenWidth - 96, 20, 80, 20);
    self.downLoadBtn.backgroundColor = [UIColor redColor];
    
}

-(void)setModel:(MCXQXiaBanModel *)model
{
    if (_model != model) {
        _model = model;
        self.musicNameL.text = model.title;
        self.musicPersonL.text = model.uname;
    }
}


@end
