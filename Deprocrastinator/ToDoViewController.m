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

    if([sender.title isEqualToString:@"Edit"])
    {
        [sender setTitle:@"Done"];
        
        

    } else if ([sender.title isEqualToString:@"Done"])
    {
        [sender setTitle:@"Edit"];
    }



}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    return nil;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    //remove item from the array
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.itemsArray removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    }
}
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

  //cell.backgroundColor = [UIColor greenColor];
}

#pragma mark - UIGestureRecognizerDelegate Protocols

- (IBAction)swipeRightGestureRecognizer:(UISwipeGestureRecognizer *)sender {

    [self handleGestureRecognizer:sender];

}

-(void)handleGestureRecognizer: (UISwipeGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint location = [gestureRecognizer locationInView:self.tableview];
        NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];

        if(cell.textLabel.textColor == [UIColor redColor])
        {
            cell.textLabel.textColor= [UIColor yellowColor];
        }
        else if(cell.textLabel.textColor == [UIColor yellowColor]){
            cell.textLabel.textColor= [UIColor greenColor];

        }
        else if(cell.textLabel.textColor == [UIColor greenColor]){
            cell.textLabel.textColor= [UIColor redColor];
        }

    }

}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.itemsArray insertObject:[self.itemsArray objectAtIndex: sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.itemsArray removeObject:[self.itemsArray objectAtIndex:sourceIndexPath.row]];

}



@end
