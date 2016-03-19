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

@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;

// allows an avatar image download operation to know if it is old or not
@property (nonatomic) NSInteger updateAvatarCount;

@end

@implementation JARepoTableViewCell

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.updateAvatarCount = 0;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRepo:(OCTRepository *)repo
{
    self.repoTitleLabel.text = [NSString stringWithFormat:@"%@ [%@]", repo.name, repo.language ?: @""];
    
    self.repoDescriptionLabel.text = repo.repoDescription;
    
    self.languageLabel.text = @"";
    
    self.ownerNameLabel.text = repo.ownerLogin;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSString *dateTime = [formatter stringFromDate:repo.dateUpdated];
    self.lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", dateTime];
    
    [self updateAvatarWithImageAtURL:repo.ownerAvatarURL];
}

- (void)updateAvatarWithImageAtURL:(NSURL*)url
{
    self.userAvatarImageView.image = nil;
    self.updateAvatarCount++;
    
    NSInteger currentCount = self.updateAvatarCount;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    
    __weak typeof(self) weakSelf = self;
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (currentCount == weakSelf.updateAvatarCount) {
                
                weakSelf.userAvatarImageView.image = [UIImage imageWithData:responseObject];
            }
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    
    [requestOperation start];
}



@end
