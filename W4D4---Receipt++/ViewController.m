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

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [[DataManager sharedInstance] fetchData:@"Tag"].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [[DataManager sharedInstance] fetchData:dataEntity].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
	
	NSArray <Receipt*> *receiptData = [[DataManager sharedInstance] fetchData:dataEntity];
	
	cell.textLabel.text = receiptData[indexPath.row].note;
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	Tag *tag = (Tag *)[[DataManager sharedInstance] fetchData:@"Tag"][section];
	return tag.tagName;
}

@end
