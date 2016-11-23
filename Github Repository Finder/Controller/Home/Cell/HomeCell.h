//
//  HomeCell.h
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCellDelegate <NSObject>

-(void)didPressedButton:(UITableViewCell*)cell;

@end

@interface HomeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *urlButton;
@property (weak, nonatomic) id<HomeCellDelegate> delegate;

@end
