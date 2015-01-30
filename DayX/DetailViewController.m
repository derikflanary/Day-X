//
//  DetailViewController.m
//  DayX
//
//  Created by Derik Flanary on 1/13/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "ListViewController.h"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong)UILabel *charCountLabel;


@property (weak, nonatomic) IBOutlet UIButton *clearButton;


@end



@implementation DetailViewController

- (void)updateWithEntry:(Entry *)entry {
    
    
        self.textField.text = self.thisEntry.title;
        self.textView.text = self.thisEntry.text;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Day X";
    self.textField.delegate = self;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    self.navigationItem.prompt = @"Add an entry";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.charCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 100, 30)];
    self.charCountLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.charCountLabel];
    
    self.textView.delegate = self;
    
    [self updateWithEntry:self.thisEntry];
   
    
    NSInteger charCount = [self.textView.text length];
    self.charCountLabel.text = [@(charCount) stringValue];
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

-(void)dismissKeyboard{
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}


- (void) donePressed:(id)sender {
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}

- (IBAction)savePressed:(id)sender {
    
    if (!self.thisEntry){
        
    [[EntryController sharedInstance] addEntryWithTitle:self.textField.text andText:self.textView.text];
    }else{
        self.thisEntry.title = self.textField.text;
        self.thisEntry.text = self.textView.text;
        self.thisEntry.date = [NSDate date];
    }
    [[EntryController sharedInstance] synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clearButtonPressed:(id)sender {
    self.textField.text = nil;
    self.textView.text  = nil;
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults removeObjectForKey:entryKey];
}
-(void)textViewDidChange:(UITextView *)textView{
    NSInteger charCount;
    charCount = [self.textView.text length];
    NSString *title = [NSString stringWithFormat:@"%lu", charCount];
    self.charCountLabel.text = title;

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
