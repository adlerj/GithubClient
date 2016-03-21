//
//  JARepoTableViewController.m
//  Github Client
//
//  Created by Jeffrey Adler on 3/18/16.
//  Copyright © 2016 Jadler. All rights reserved.
//

#import "JARepoTableViewController.h"
#import "JAClientManager.h"
#import "JARepoTableViewCell.h"
#import "JAWebViewController.h"

#define kWebViewControllerSegueIdentifier @"webViewControllerSegue"

@interface JARepoTableViewController ()  <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, readonly) OCTClient *client;

@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation JARepoTableViewController 

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.clearsSelectionOnViewWillAppear = YES;
    self.tableView.tableHeaderView = self.searchBar;
    self.title = @"GitHub Repo Searcher";
}

#pragma mark - Lazy Instantiations
- (UISearchBar *)searchBar
{
    if (!_searchBar) {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44.f)];
        _searchBar.delegate = self;
        _searchBar.showsCancelButton = YES;
    }
    
    return _searchBar;
}

- (NSMutableArray *)searchResults
{
    if (!_searchResults) {
        
        _searchResults = [NSMutableArray array];
    }
    
    return _searchResults;
}

#pragma mark - TableView Datasource and Delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JARepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repoCell" forIndexPath:indexPath];
    
    cell.repo = self.searchResults[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kWebViewControllerSegueIdentifier sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.searchResults.count;
}


#pragma mark - Helpers

// Proxied for easier access
- (OCTClient *)client
{
    return [JAClientManager defaultManager].client;
}

- (void)performRequest:(NSString*)searchTerm {
    
    RACSignal *request = [self.client searchRepositoriesWithQuery:searchTerm orderBy:nil ascending:YES];
    
    __weak typeof(self) weakSelf = self;
    
    // This method actually kicks off the request, handling any results using the
    // blocks below.
    [request subscribeNext:^(OCTRepositoriesSearchResult *searchResult) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView beginUpdates];
            
            for (OCTRepository *repo in searchResult.repositories) {
                
                [weakSelf.searchResults addObject:repo];
                
                [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.searchResults.count - 1
                                                                                inSection: 0]]
                                          withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [weakSelf.tableView endUpdates];
        });
        
    } error:^(NSError *error) {
        
        NSLog(@"Error with download: %@", error);
    } completed:^() {}];
    
}


#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchResults = nil;
    [self.tableView reloadData];
    
    [self.searchBar resignFirstResponder];
    
    [self performRequest:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kWebViewControllerSegueIdentifier]) {
        JAWebViewController *webVC = (JAWebViewController*)[segue destinationViewController];
        
        OCTRepository *repo = self.searchResults[self.tableView.indexPathForSelectedRow.row];
        webVC.url = repo.HTMLURL;
        webVC.title = repo.name;
    }
}


@end
