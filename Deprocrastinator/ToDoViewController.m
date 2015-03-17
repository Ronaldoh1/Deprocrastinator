//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/16/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToDoViewController.h"
#import "ToDo.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (nonatomic) NSMutableArray *itemsArray;
@property (nonatomic) NSMutableArray *colorsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic) int indexForItemToDelete;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ToDo *toDo = [[ToDo alloc]initWithActionItem:@"Get Challenge Done" andWithDecider:0];


    self.itemsArray = [NSMutableArray arrayWithObjects:toDo,nil ];






}


- (IBAction)addItem:(UIButton *)sender {


    ToDo *newToDo = [[ToDo alloc] initWithActionItem:self.inputField.text andWithDecider:0];
    [self.itemsArray addObject:newToDo];


    [self.inputField resignFirstResponder];



    [self.tableview reloadData];

    self.inputField.text = @"";



    


}

- (IBAction)editItem:(UIBarButtonItem *)sender {

    if([sender.title isEqualToString:@"Edit"])
    {
        [sender setTitle:@"Done"];
        [self.tableview setEditing: YES animated: YES];

    } else if ([sender.title isEqualToString:@"Done"])
    {
        [sender setTitle:@"Edit"];
           [self.tableview setEditing: NO animated: NO];
    }



}

//-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self setEditing:true animated:true];
//}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this

        self.indexForItemToDelete = indexPath.row;

        [self displayAlert];

    }
}


-(void) displayAlert{

  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Reminder?" message:@"Are you should want to delete selected item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    
            //alert.tag = 1;
    
           // [alert addButtonWithTitle:@"Delete"];
           [alert show];

}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //button index 0 means the user presses the cancel button.
    if (buttonIndex == 0) {


    }else{
        //else this means that the user click on delete and should continue to remove the item from

        [self.itemsArray removeObjectAtIndex:self.indexForItemToDelete];
        [self.tableview reloadData]; // tell table to refresh now




    }
}

#pragma mark - UITableViewDataSource protocalls

///this allows to custumize the number of of sections in the table view.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//This is how many rows we're going to display based on the itemsArray count.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.itemsArray.count;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    ToDo *aToDo = [self.itemsArray objectAtIndex:indexPath.row];

    cell.textLabel.textColor = [self colorForRowWithToDo:aToDo];
    cell.textLabel.text = aToDo.actionItem;

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];


  cell.backgroundColor = [UIColor greenColor];
}
-(UIColor *)colorForRowWithToDo:(ToDo *)theToDo{
    switch (theToDo.colorDecider) {
        case 0:
            return [UIColor blackColor];
            break;
        case 1:
            return [UIColor redColor];
            break;
        case 2:
            return [UIColor yellowColor];
            break;
        case 3:
            return [UIColor greenColor];
            break;

        default:
            return [UIColor blackColor];
            break;
    }
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

        //First we need to check for the case when the color of the text is black. (Itinial color for the cell lable). Otherwise the other if statements will not be executed.


        ToDo *swipeToDo = [self.itemsArray objectAtIndex:indexPath.row];

        switch (swipeToDo.colorDecider) {
            case 0:
                swipeToDo.colorDecider = 1;
                 break;
            case 1:
                swipeToDo.colorDecider = 2;
                 break;
            case 2:
                swipeToDo.colorDecider = 3;
                break;
                
            default:
                break;
        }


         [self.tableview reloadData];
    }


}

-(void)changeColorAtIndex:(NSIndexPath *)indexPath toColor: (UIColor *) newColor{

    [self.colorsArray removeObjectAtIndex:indexPath.row];
    [self.colorsArray insertObject:newColor atIndex:indexPath.row];

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
