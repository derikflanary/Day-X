//
//  ListViewController.m
//  DayX
//
//  Created by Derik Flanary on 1/15/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "Entry.h"

@interface ListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger rowCount;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"List View";
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addEntryButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEntry:)];
    self.navigationItem.rightBarButtonItem = addEntryButton;
    
    //Entry Controller Stuff
    
    NSArray *entryArrayFromDefaults = [self loadEntriesFromDefaults];
    NSMutableArray *mutableEntryArrayFromDefaults = [NSMutableArray arrayWithArray:entryArrayFromDefaults];
    
    self.rowCount = [entryArrayFromDefaults count];
    
    NSMutableDictionary *newEntryDict = [NSMutableDictionary dictionary];
    
    [newEntryDict setValue:@"My Day" forKey:titleKey];
    [newEntryDict setValue:@"It was a good day" forKey:textKey];
    [newEntryDict setValue:[NSDate date] forKey:dateKey];

    Entry *newEntry = [[Entry alloc]initWithDictionary:newEntryDict];
    [mutableEntryArrayFromDefaults addObject:newEntry];
    
    [self storeEntriesToDefaults:mutableEntryArrayFromDefaults];
    
}

-(NSArray *)loadEntriesFromDefaults{
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:@"Entries"];
    NSMutableArray *mutableEntryArray = [NSMutableArray array];
    for (NSDictionary *entryDict in entryDictionaries) {
        Entry *entry = [[Entry alloc] initWithDictionary:entryDict];
        [mutableEntryArray addObject:entry];
    }
    return mutableEntryArray;
}

-(void)storeEntriesToDefaults:(NSArray *)entryArray{
    NSMutableArray *mutableEntryDictionaries;
    for (Entry *entry in entryArray) {
        NSDictionary *entryDictionary = [entry entryDictionary];
        [mutableEntryDictionaries addObject:entryDictionary];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableEntryDictionaries forKey:@"Entries"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSNumber *rowNum = [defaults objectForKey:@"rowCount"];
//    self.rowCount = [rowNum integerValue];
    return self.rowCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell One"];
    if (!cell){
        cell = [UITableViewCell new];
    }
//    NSDictionary *entryDict;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    entryDict = [defaults objectForKey:@"entryKey"];
    cell.textLabel.text = @"Entry";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)addEntry:(id)sender{
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    self.rowCount ++;
//    NSNumber *rowNum = [NSNumber numberWithInteger:self.rowCount];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:rowNum forKey:@"rowCount"];
//    [defaults synchronize];
    
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
