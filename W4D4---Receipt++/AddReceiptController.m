//
//  AddReceiptController.m
//  W4D4---Receipt++
//
//  Created by Dylan McCrindle on 2016-11-24.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "AddReceiptController.h"
#import "DataManager.h"
#import "Tag+CoreDataClass.h"
#import "Receipt+CoreDataClass.h"

@interface AddReceiptController ()
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@end

@implementation AddReceiptController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	
//	Tag *newTag = [NSEntityDescription insertNewObjectForEntityForName:@"Tag"
//												inManagedObjectContext:[DataManager sharedInstance].persistentContainer.viewContext];
//	
//	newTag.tagName = @"Family";
//	
//	
//	[[DataManager sharedInstance] saveContext];
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[DataManager sharedInstance] fetchData:@"Tag"].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell" forIndexPath:indexPath];
	
	Tag *tag = [[DataManager sharedInstance] fetchData:@"Tag"][indexPath.row];
	cell.textLabel.textAlignment = NSTextAlignmentCenter;
	cell.textLabel.text = tag.tagName;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
	} else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
		cell.accessoryType = UITableViewCellAccessoryNone;
	} else {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
}

- (IBAction)dismissAddReceipt:(UIButton *)sender {
	
	if([[sender currentTitle] isEqualToString: @"Cancel"]){
		[self dismissViewControllerAnimated:YES completion:nil];
	}
	
	else{
		Receipt *receipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt"
														 inManagedObjectContext:[DataManager sharedInstance].persistentContainer.viewContext];
		
		receipt.note = self.descriptionText.text;
		receipt.timeStamp = self.datePicker.date;
		receipt.amount = [self.amount.text floatValue];
		
		
		NSMutableArray *tags = [NSMutableArray new];
		NSArray *indexPaths = [self.categoryTableView indexPathsForSelectedRows];
		for (NSIndexPath *path in indexPaths) {
			Tag *tag = [[DataManager sharedInstance] fetchData:@"Tag"][path.row];
			[tags addObject:tag];
		}
		
		receipt.tags = [NSSet setWithArray:tags];
		
		[[DataManager sharedInstance] saveContext];
		[self dismissViewControllerAnimated:YES completion:nil];
		
	}
}


@end
