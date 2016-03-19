//
//  JARepoTableViewCell.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JARepoTableViewCell.h"


@interface JARepoTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *userAvatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *repoTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *repoDescriptionLabel;

@end

@implementation JARepoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRepo:(OCTRepository *)repo
{
    self.repoTitleLabel.text = repo.name;
}



@end
