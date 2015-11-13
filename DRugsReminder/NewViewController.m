

#import "NewViewController.h"
#import "News2detailViewController.h"

@interface NewViewController ()
{
    
    NSXMLParser * parser;
    NSMutableArray * feeds;
    NSMutableDictionary *item;
    NSMutableDictionary *encl;
    NSMutableString *title;
    NSMutableString *description;
    NSMutableString * link;
    NSMutableString * url_img;
    NSMutableString *pubDate;
    NSString *element;
    NSString *img_path;
    NSMutableArray *list_title;
    NSMutableArray *list_description;
    NSMutableArray *list_link;
    NSMutableArray *list_url;
    NSMutableArray *list_pubDate;
    
}
@end

@implementation NewViewController

- (void)viewDidLoad {
    
    _listNews.delegate=self;
    _listNews.dataSource=self;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    BOOL connected;
    
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
        
        connected=true;
    else
    {
        connected=false;
        
    }
    
    //SQL
    NSString * docsDir;
    NSArray * dirPaths;
    //get the directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths [0];
    //Build the path to keep the database
    _databasePath = [[NSString alloc]initWithString:[docsDir stringByAppendingPathComponent:@"DRNEWS.db"]];
    NSFileManager * filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath:_databasePath]== NO) {
        const char *dbpath= [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_DB)==SQLITE_OK) {
            char *errorMessage;
            const char *sql_statment = "CREATE TABLE IF NOT EXISTS rss (ID INTEGER PRIMARY KEY AUTOINCREMENT, TITLE TEXT UNIQUE, DESCRIPTION TEXT, LINK TEXT, PUBDATE DATETIME, URL TEXT)";
            
            if (sqlite3_exec(_DB, sql_statment, NULL, NULL, &errorMessage)!= SQLITE_OK) {
                NSLog(@"Failed to create table News");
            }
            sqlite3_close(_DB);
            
        }
        else {
            NSLog(@"Failed to create/open table News");
        }
    }
    list_title = [[NSMutableArray alloc] init];
    list_description =[[NSMutableArray alloc] init];
    list_link =[[NSMutableArray alloc] init];
    list_pubDate =[[NSMutableArray alloc] init];
    list_url = [[NSMutableArray alloc] init];
    
    //RSS
    feeds =[[NSMutableArray alloc]init];
    
    
    NSURL * url = [NSURL URLWithString:@"http://www.huffingtonpost.com/feeds/verticals/health-fitness/index.xml "];
    parser =[[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
    
    sqlite3_stmt *statement;
    const char *dbpath= [_databasePath UTF8String];
    
    
    if (sqlite3_open(dbpath, &_DB)==SQLITE_OK) {
        
        for (int i=0; i<[feeds count]; i++) {
            
         /*   NSArray* foo =[[[feeds objectAtIndex:i] objectForKey:@"pubDate"] componentsSeparatedByString: @", "];
            NSString* day = [foo objectAtIndex: 1];
            NSArray* foo2 = [day componentsSeparatedByString: @" GMT"];
            NSString* date = [foo2 objectAtIndex: 0];
            NSArray* foo3 = [date componentsSeparatedByString: @" "];
            NSString* jj = [foo3 objectAtIndex: 0];
            NSString* m = [foo3 objectAtIndex: 1];
            NSString* aa = [foo3 objectAtIndex: 2];
            NSString* tt = [foo3 objectAtIndex: 3];
            NSString* mm;*/
            
   //         NSString * d = [NSString stringWithFormat:@"%@-%@-%@ %@",aa,mm,jj,tt];
            
            NSString * insertSQL = [NSString stringWithFormat:@"INSERT INTO rss (title, description, link, pubdate, url) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[[feeds objectAtIndex:i] objectForKey:@"title"],[[feeds objectAtIndex:i] objectForKey:@"description"],[[feeds objectAtIndex:i] objectForKey:@"link"],[[feeds objectAtIndex:i] objectForKey:@"pubDate"],[[feeds objectAtIndex:i] objectForKey:@"url"]];
            const char *insert_statement = [insertSQL UTF8String];
            sqlite3_prepare_v2(_DB, insert_statement, -1, &statement, NULL);
            if (sqlite3_step(statement)== SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(_DB);
            }
        }
    }
    if (sqlite3_open(dbpath, &_DB)==SQLITE_OK) {
        
        for (int i=0; i<[feeds count]; i++) {
            
           // NSArray* foo =[[[feeds objectAtIndex:i] objectForKey:@"pubDate"] componentsSeparatedByString: @", "];
           // NSString* day = [foo objectAtIndex: 1];
          //  NSArray* foo2 = [day componentsSeparatedByString: @" GMT"];
        //    NSString* date = [foo2 objectAtIndex: 0];
         //   NSArray* foo3 = [date componentsSeparatedByString: @" "];
       //     NSString* jj = [foo3 objectAtIndex: 0];
         //   NSString* m = [foo3 objectAtIndex: 1];
         //   NSString* aa = [foo3 objectAtIndex: 2];
          //  NSString* tt = [foo3 objectAtIndex: 3];
          //  NSString* mm;
        //    NSString * d = [NSString stringWithFormat:@"%@-%@-%@ %@",aa,mm,jj,tt];
            
            NSString * insertSQL = [NSString stringWithFormat:@"INSERT INTO rss (title, description, link, pubdate, url) VALUES (\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",[[feeds objectAtIndex:i] objectForKey:@"title"],[[feeds objectAtIndex:i] objectForKey:@"description"],[[feeds objectAtIndex:i] objectForKey:@"link"],[[feeds objectAtIndex:i] objectForKey:@"pubDate"],[[feeds objectAtIndex:i] objectForKey:@"url"]];
            const char *insert_statement = [insertSQL UTF8String];
            sqlite3_prepare_v2(_DB, insert_statement, -1, &statement, NULL);
            if (sqlite3_step(statement)== SQLITE_DONE) {
                sqlite3_finalize(statement);
                sqlite3_close(_DB);
            }
        }
    }
    
    
    if (sqlite3_open(dbpath, &_DB)==SQLITE_OK) {
        NSString * querySQL = @"DELETE FROM rss WHERE id NOT IN (SELECT id FROM rss ORDER BY id DESC LIMIT 50)";
        const char *del_statement = [querySQL UTF8String];
        sqlite3_prepare_v2(_DB, del_statement, -1, &statement, NULL);
        if (sqlite3_step(statement)== SQLITE_DONE) {
            sqlite3_finalize(statement);
            sqlite3_close(_DB);}
    }
    
    if (sqlite3_open(dbpath, &_DB)==SQLITE_OK) {
        NSString * querySQL = @"SELECT title, description, link, pubdate, url FROM rss ORDER BY pubdate DESC";
        const char *query_statement = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_DB, query_statement, -1, &statement, NULL)==SQLITE_OK) {
            
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *title_field = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                NSString *detail_field = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                NSString *link_field=[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                NSString *pubDate_field = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                NSString *url_field = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                
                [list_title addObject:title_field];
                [list_description addObject:detail_field];
                [list_link addObject:link_field];
                [list_pubDate addObject:pubDate_field];
                [list_url addObject:url_field];
                
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_DB);
        [self.listNews reloadData];
    }
    
    
    NSLog(@"aaaaaa");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [list_title count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    UICollectionViewCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];

    _imgView=(UIImageView*) [cell viewWithTag:100];
    UILabel* lbl1=(UILabel*) [cell viewWithTag:111];
    UILabel* lbl2=(UILabel*) [cell viewWithTag:122];
    
    _imgView.image= [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[list_url objectAtIndex:indexPath.row]]]];
    lbl1.text=[list_title objectAtIndex:indexPath.row];
    lbl2.text=[list_description objectAtIndex:indexPath.row];
    
    cell.layer.cornerRadius = 6;
    
    return cell;
    
    
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    if ([element isEqualToString:@"item"]) {
        item = [[NSMutableDictionary alloc]init];
        title = [[NSMutableString alloc]init];
        description = [[NSMutableString alloc]init];
        link = [[NSMutableString alloc]init];
        pubDate = [[NSMutableString alloc]init];
    }
    if ([element isEqualToString:@"enclosure"]) {
        url_img = [attributeDict objectForKey:@"url"];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"item"]) {
        [item setObject:title forKey:@"title"];
        [item setObject:description forKey:@"description"];
        [item setObject:link forKey:@"link"];
        [item setObject:pubDate forKey:@"pubDate"];
        [item setObject:url_img forKey:@"url"];
        [feeds addObject:[item copy]];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }else if ([element isEqualToString:@"description"]){
        [description appendString:string];
    }else if ([element isEqualToString:@"link"]){
        [link appendString:string];
    }else if ([element isEqualToString:@"pubDate"]){
        [pubDate appendString:string];
    }else if ([element isEqualToString:@"url"]){
        [url_img appendString:string]; }
    
    
}


-(void)parserDidEndDocument:(NSXMLParser *)parser{
    [self.listNews reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSArray *indexPaths = [self.listNews indexPathsForSelectedItems];
    News2detailViewController *svc = segue.destinationViewController;
    NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
    
    
   
    
    NSString* titre = [list_title objectAtIndex:indexPath.row];
    NSString* image = [list_url objectAtIndex:indexPath.row];
    NSString* desc = [list_description objectAtIndex:indexPath.row];
   
    svc.titre2 = titre;
    svc.image2 = image;
    svc.description2 = desc;
     [self.listNews deselectItemAtIndexPath:indexPath animated:NO];
    //[self.navigationController pushViewController:svc animated:YES];
    
    
    // NSLog(@"%@",desc);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)home:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:(YES)];
}
@end
