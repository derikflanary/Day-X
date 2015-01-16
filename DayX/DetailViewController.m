//
//  DetailViewController.m
//  DayX
//
//  Created by Derik Flanary on 1/13/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "Entry.h"
#import "ListViewController.h"

@interface DetailViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UIButton *clearButton;


@end



@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Day X";
    self.textField.delegate = self;
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePressed)];
//    self.navigationItem.rightBarButtonItem = doneButton;
    
    [self updateWithDictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}

- (void) donePressed{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}

- (IBAction)savePressed:(id)sender {
    NSString *title = self.textField.text;
    NSString *text = self.textView.text;
    NSDate *date = [NSDate date];
    NSDictionary *entriesDict;
    entriesDict = @{titleKey: title,
                    textKey: text,
                    dateKey: date};
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:entriesDict forKey:entryKey];
    [defaults synchronize];
}

-(void)updateWithDictionary{
//    NSDictionary *entryDict;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    entryDict = [defaults objectForKey:entryKey];
    ListViewController *listViewController = [ListViewController new];
    listViewController.entryArrayFromDefaults = [listViewController loadEntriesFromDefaults];
    NSLog(@"%lu", self.entryIndex);
    Entry *entry = [Entry new];
    entry = [listViewController.entryArrayFromDefaults objectAtIndex:self.entryIndex];
    self.textField.text = entry.title;
    self.textView.text = entry.text;
}

- (IBAction)clearButtonPressed:(id)sender {
    self.textField.text = nil;
    self.textView.text  = nil;
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults removeObjectForKey:entryKey];
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
