//
//  ViewController.m
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *wavesImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wavesLeftConstraint;
@property (nonatomic) CGFloat wavesImageWidth;
@property (strong,nonatomic) NSMutableArray *repositories;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.repositories=[[NSMutableArray alloc] init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60.0;
    UIImage* wavesImage=[UIImage imageNamed:@"waves"];
    self.wavesImageWidth=wavesImage.size.width-[[UIScreen mainScreen] bounds].size.width;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.repositories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[UITableViewCell alloc] init];
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentSize.height>0 && scrollView.contentOffset.y>0) {
        CGFloat percentage=scrollView.contentOffset.y/scrollView.contentSize.height;
        CGFloat constant=self.wavesImageWidth*percentage*(-1);
        if (constant>self.wavesImageWidth) {
            constant=self.wavesImageWidth;
        }
        self.wavesLeftConstraint.constant=constant;
        [self.wavesImageView setNeedsUpdateConstraints];
        [self.wavesImageView updateConstraintsIfNeeded];
    }
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

#pragma mark - Search logic

-(void)searchRepositoriesForString:(NSString *)name{
    
}

@end
