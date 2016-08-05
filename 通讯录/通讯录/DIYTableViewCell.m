//
//  DIYTableViewCell.m
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DIYTableViewCell.h"

@implementation DIYTableViewCell

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
        
        self.imageViews = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageViews];
        
        self.nameL = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameL];
        
        self.numberL = [[UILabel alloc]init];
        [self.contentView addSubview:self.numberL];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageViews.frame = CGRectMake(0, 0, 120, 150);
    self.nameL.frame = CGRectMake(150, 0, 120, 30);
    self.numberL.frame = CGRectMake(150, 75, 120, 30);
    
    
}

-(void)setPerson:(Contact *)Person
{
    if (_Person != Person) {
        _Person = Person;
        self.imageViews.image = [UIImage imageNamed:Person.icon];
        self.nameL.text = Person.name;
        self.numberL.text = Person.number;
    }
}




@end
