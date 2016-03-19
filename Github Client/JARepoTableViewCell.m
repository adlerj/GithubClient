//
//  JARepoTableViewCell.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JARepoTableViewCell.h"

@interface JARepoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *repoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *repoDescriptionLabel;


@end

@implementation JARepoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
