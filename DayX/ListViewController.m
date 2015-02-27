//
//  ListViewController.m
//  DayX
//
//  Created by Derik Flanary on 1/15/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "TableViewCellStyleTableViewCell.h"
#import "EntryController.h"
#import "Stack.h"

@interface ListViewController ()<UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger rowCount;
@property (nonatomic, strong)NSFetchedResultsController *fetchedResultsController;

@end

@implementation ListViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSArray *entryArrayFromDefaults = [EntryController sharedInstance].entries;
    self.tableView.frame = self.view.bounds;
//    self.rowCount = [entryArrayFromDefaults count];
//    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Entries";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    //self.tableView.frame = self.view.bounds;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self configureFetchedResultsController];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *addEntryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEntry:)];
    self.navigationItem.rightBarButtonItem = addEntryButton;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    //Entry Controller Stuff
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - table view datasource
/////////////DATA SOURCE METHODS///////////////

-(void)configureFetchedResultsController{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:[Stack sharedInstance].managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    [self.fetchedResultsController performFetch:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.rowCount = self.fetchedResultsController.fetchedObjects.count;
    return self.rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCellStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell One"];
    if (!cell){
        cell = [TableViewCellStyleTableViewCell new];
    }
    
    Entry *entry = self.fetchedResultsController.fetchedObjects[indexPath.row];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy 'at' HH:mm"];
    NSString *dateOfEntry = [dateFormatter stringFromDate:entry.date];
    
    cell.textLabel.text = entry.title;
    cell.detailTextLabel.text = dateOfEntry;
    
    return cell;
}

////////////////////////////////////////
#pragma mark - FetchedResultsController Delegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}
#pragma mark - table view delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
//    DetailViewController *detailViewController = [DetailViewController new];
//    [detailViewController updateWithEntry:self.fetchedResultsController.fetchedObjects[indexPath.row]];
//    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)addEntry:(id)sender{
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

        NSArray*entryArray = [EntryController sharedInstance].entries;
    Entry *entry = [entryArray objectAtIndex:indexPath.row];
    [[EntryController sharedInstance]removeEntry:entry];
    //[self.tableView reloadData];
//        //    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
