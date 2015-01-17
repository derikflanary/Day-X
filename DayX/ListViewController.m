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

@interface ListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger rowCount;


@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Entries";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    UIBarButtonItem *addEntryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEntry:)];
    self.navigationItem.rightBarButtonItem = addEntryButton;
    
    
    
    //Entry Controller Stuff
    
    NSArray *entryArrayFromDefaults = [EntryController sharedInstance].entries;
    
    self.rowCount = [entryArrayFromDefaults count];
//    
//    NSMutableDictionary *newEntryDict = [NSMutableDictionary dictionary];
//    [newEntryDict setValue:@"The Next Day" forKey:titleKey];
//    [newEntryDict setValue:@"This day was awful" forKey:textKey];
//    [newEntryDict setValue:[NSDate date] forKey:dateKey];
//
//    Entry *newEntry = [[Entry alloc]initWithDictionary:newEntryDict];
//    [mutableEntryArrayFromDefaults addObject:newEntry];
//    
//    [self storeEntriesToDefaults:mutableEntryArrayFromDefaults];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCellStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell One"];
    if (!cell){
        cell = [TableViewCellStyleTableViewCell new];
    }
    NSArray *entryArrayFromDefaults = [EntryController sharedInstance].entries;
    Entry *entry = [entryArrayFromDefaults objectAtIndex:indexPath.row];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy 'at' HH:mm"];
    NSString *dateOfEntry = [dateFormatter stringFromDate:entry.date];
    
    cell.textLabel.text = entry.title;
    cell.detailTextLabel.text = dateOfEntry;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    NSArray *entryArrayFromDefaults = [EntryController sharedInstance].entries;
    Entry *entry = [entryArrayFromDefaults objectAtIndex:indexPath.row];
    [detailViewController updateWithEntry:entry];
    
    detailViewController.entryIndex = indexPath.row;
    //NSLog(@"%lu, %lu", detailViewController.entryIndex, indexPath.row);
}

-(void)addEntry:(id)sender{
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
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
