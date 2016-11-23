//
//  HomeCell.m
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell()

@end

@implementation HomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius=25;
    self.userImageView.clipsToBounds=true;
}

- (IBAction)didPressedButton:(UIButton *)sender {
    [self.delegate didPressedButton:self];
}

@end
