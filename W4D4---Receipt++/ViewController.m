//
//  ViewController.m
//  W4D4---Receipt++
//
//  Created by Dylan McCrindle on 2016-11-24.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"

#define dataEntity @"Receipt"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
	[self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [[DataManager sharedInstance] fetchData:@"Tag"].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	//NSPredicate *predicate = [NSPredicate predicateWithFormat: @"amount > 25", @"receipt."];

	return 1;//[[DataManager sharedInstance] fetchData:dataEntity withPredicate:predicate].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
	
	
	Tag *tag = (Tag *)[[DataManager sharedInstance] fetchData:@"Tag"][indexPath.section];
	NSPredicate *predicate = [NSPredicate predicateWithFormat: @"ALL tags.tagName LIKE[cd] %@", tag.tagName];

	NSArray <Receipt*> *receiptData = [[DataManager sharedInstance] fetchData:dataEntity withPredicate:predicate];
	
	cell.textLabel.text = receiptData[indexPath.row].note;

	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	Tag *tag = (Tag *)[[DataManager sharedInstance] fetchData:@"Tag"][section];
	return tag.tagName;
}

@end
