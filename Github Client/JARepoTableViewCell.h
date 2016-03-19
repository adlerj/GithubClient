//
//  JARepoTableViewCell.h
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import <OctoKit/OctoKit.h>
#import <UIKit/UIKit.h>

@interface JARepoTableViewCell : UITableViewCell
@property(nonatomic, weak) OCTRepository *repo;
@end
