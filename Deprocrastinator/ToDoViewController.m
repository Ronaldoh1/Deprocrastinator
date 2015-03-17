//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/16/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (nonatomic) NSMutableArray *itemsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.itemsArray = [NSMutableArray arrayWithObjects: @"To Do1", @"To Do2", @"To Do3", @"To Do4",nil ];
    
   // self.inputField.backgroundColor = [UIColor redColor];

}


- (IBAction)addItem:(UIButton *)sender {

    //UITableViewCell *cell = [UITableViewCell new];

   // cell.textLabel.text =    self.inputField.text;

    [self.itemsArray addObject:self.inputField.text];


    [self.inputField resignFirstResponder];

    [self.tableview reloadData];

    self.inputField.text = @"";

    


}

- (IBAction)editItem:(UIBarButtonItem *)sender {

}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    return nil;
//}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



#pragma mark - UITableViewDataSource protocalls
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.itemsArray.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [self.itemsArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

  //  NSLog(@"%ld", (long)indexPath.row);

    cell.backgroundColor = [UIColor greenColor];
}

#pragma mark - UIGestureRecognizerDelegate Protocols

- (IBAction)swipeRightGestureRecognizer:(UISwipeGestureRecognizer *)sender {

    if (sender.state == UIGestureRecognizerStateEnded){
        cgPoint location = [sender locat]
    }




}

-


@end
