//
//  ViewController.m
//  DZ 30 - Skut_TablView_Dinam
//
//  Created by mac on 06.01.18.
//  Copyright © 2018 Dima Zgera. All rights reserved.
//

#import "ViewController.h"
#import "ZDColor.h"
#import "ZDStudent.h"

static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pink", @"Fred", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"Castenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Zgera", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"Kobayashi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};


@interface ViewController ()

//@property (strong, nonatomic) NSMutableArray* colorsArray;
@property (strong, nonatomic) NSMutableArray* studentsArray;
@property (strong, nonatomic) NSMutableArray* groupsStudents;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     self.colorsArray = [NSMutableArray array];
     
     for (int i = 0; i < 1000; i++) {
     SVColor* color = [self generateColor];
     [self.colorsArray addObject:color];
     }
     */
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.studentsArray = [NSMutableArray array];
    
    for (int i = 0; i < 50; i++) {
        ZDStudent* student = [self createStudent];
        [self.studentsArray addObject:student];
    }
    
    self.groupsStudents = [NSMutableArray array];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"score >= %f", 4.8];
    
    NSMutableArray* bestStudents = [NSMutableArray arrayWithArray:[self.studentsArray filteredArrayUsingPredicate:predicate]];
    
    [self sortStudentsArray:bestStudents];
    
    [self.groupsStudents addObject:bestStudents];
    
    predicate = [NSPredicate predicateWithFormat:@"score >= %f AND score < %f", 4.f, 4.8];
    
    NSMutableArray* goodStudents = [NSMutableArray arrayWithArray:[self.studentsArray filteredArrayUsingPredicate:predicate]];
    
    [self sortStudentsArray:goodStudents];
    
    [self.groupsStudents addObject:goodStudents];
    
    predicate = [NSPredicate predicateWithFormat:@"score >= %f AND score < %f", 3.f, 4.f];
    
    NSMutableArray* normalStudents = [NSMutableArray arrayWithArray:[self.studentsArray filteredArrayUsingPredicate:predicate]];
    
    [self sortStudentsArray:normalStudents];
    
    [self.groupsStudents addObject:normalStudents];
    
    predicate = [NSPredicate predicateWithFormat:@"score < %f", 3.f];
    
    NSMutableArray* badStudents = [NSMutableArray arrayWithArray:[self.studentsArray filteredArrayUsingPredicate:predicate]];
    
    [self sortStudentsArray:badStudents];
    
    [self.groupsStudents addObject:badStudents];
    
    
    NSMutableArray* colorsArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        ZDColor* color = [self createColor];
        [colorsArray addObject:color];
    }
    
    [self.groupsStudents addObject:colorsArray];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.groupsStudents count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray* students = [self.groupsStudents objectAtIndex:section];
    
    return [students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 4) {
        
        static NSString* colorCellIdentifier = @"colorCell";
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:colorCellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:colorCellIdentifier];
        }
        
        NSArray* colorArray = [self.groupsStudents objectAtIndex:indexPath.section];
        
        ZDColor* color = [colorArray objectAtIndex:indexPath.row];
        
        cell.textLabel.textColor = color.color;
        
        cell.textLabel.text = color.name;
        
        return cell;
        
    }
    
    static NSString* studentCellIdentifier = @"studentCell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentCellIdentifier];
        //NSLog(@"create cell");
    } else {
        //NSLog(@"reuse cell");
    }
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    
    NSArray* group = [self.groupsStudents objectAtIndex:indexPath.section];
    
    ZDStudent* student = [group objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.1f", student.score];
    
    if (student.score < 3.f) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    
    return cell;
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
            
        case 0:
            return @"Отличники";
            break;
            
        case 1:
            return @"Хорошисты";
            break;
            
        case 2:
            return @"Троечники";
            break;
            
        case 3:
            return @"Двоечники";
            break;
            
        case 4:
            return @"Цвета";
            break;
            
        default:
            return @"unknown";
            break;
    }
    
}

#pragma mark - Methods

- (UIColor*) randomColor {
    
    CGFloat r = arc4random_uniform(256) / 255.f;
    CGFloat g = arc4random_uniform(256) / 255.f;
    CGFloat b = arc4random_uniform(256) / 255.f;
    
    UIColor* color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    
    return color;
    
}

- (ZDColor*) createColor {
    
    ZDColor* color = [[ZDColor alloc] init];
    
    color.color = [self randomColor];
    
    const CGFloat * components =  CGColorGetComponents(color.color.CGColor);
    
    color.name = [NSString stringWithFormat:@"RGB(%d, %d, %d)", (int)(components[0] * 255), (int)(components[1] * 255), (int)(components[2] * 255)];
    
    return color;
    
}

- (ZDStudent*) createStudent {
    
    ZDStudent* student = [[ZDStudent alloc] init];
    
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    student.score = 2.f + (float)arc4random_uniform(3) + (float)arc4random_uniform(11) / 10.f;
    
    return student;
    
}


- (void) sortStudentsArray:(NSMutableArray*) array {
    
    [array sortUsingComparator:^NSComparisonResult(ZDStudent*  _Nonnull obj1, ZDStudent*  _Nonnull obj2) {
        
        if ([[obj1.firstName lowercaseString] compare:[obj2.firstName lowercaseString]] == (NSComparisonResult)NSOrderedSame) {
            return [[obj1.lastName lowercaseString] compare:[obj2.lastName lowercaseString]];
        }
        
        return [[obj1.firstName lowercaseString] compare:[obj2.firstName lowercaseString]];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
