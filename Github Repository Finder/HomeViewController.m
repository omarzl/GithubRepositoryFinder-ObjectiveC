//
//  ViewController.m
//  Github Repository Finder
//
//  Created by kryteria on 22/11/16.
//  Copyright © 2016 omarzl. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "Constants.h"
#import "Repository.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,HomeCellDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *wavesImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wavesLeftConstraint;
@property (nonatomic) CGFloat wavesImageWidth;
@property (strong,nonatomic) NSMutableArray *repositories;
@property (strong,nonatomic) NSString *searchTerm;
@property (strong,nonnull) AFHTTPSessionManager *manager;

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
    self.manager=[AFHTTPSessionManager manager];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.repositories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell* cell=[tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    cell.delegate=self;
    Repository *rep=self.repositories[indexPath.row];
    cell.titleLabel.text=rep.name;
    cell.descriptionLabel.text=rep.desc;
    [cell.urlButton setTitle:rep.url forState:UIControlStateNormal];
    Owner *owner=rep.owner;
    cell.userImageView.image=nil;
    if (owner!=nil) {
        cell.usernameLabel.text=owner.name;
        NSURL*url=[NSURL URLWithString:owner.userImage];
        if (url!=nil) {
            [cell.userImageView setImageWithURL:url];
        }
    }
    return cell;
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

#pragma mark - HomeCellDelegate

-(void)didPressedButton:(UITableViewCell *)cell{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    if (indexPath!=nil) {
        Repository *rep=self.repositories[indexPath.row];
        NSURL *url=[NSURL URLWithString:rep.url];
        if (url!=nil) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchRepositoriesForString:searchText];
}

#pragma mark - Search logic

-(void)searchRepositoriesForString:(NSString *)name{
    [self.repositories removeAllObjects];
    if ([name  isEqual: @""]) {
        [self.tableView reloadData];
    }else{
        [self requestRepositoriesForString:name];
    }
}

-(void)requestRepositoriesForString:(NSString *)name{
    NSString *url=[NSString stringWithFormat:@"%@%@%@?q=%@",kEndPointApi,kGetSearch,kGetSearchRepositories,name];
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject class] isSubclassOfClass:[NSDictionary class]]) {
            id items=responseObject[@"items"];
            if ([[items class] isSubclassOfClass:[NSArray class]]) {
                NSArray* arr=items;
                for (int x=0; x<arr.count; x++) {
                    id object=arr[x];
                    if ([[object class] isSubclassOfClass:[NSDictionary class]]) {
                        NSDictionary*dicc=object;
                        Repository*rep=[Repository createFromMap:dicc];
                        [self.repositories addObject:rep];
                    }
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
