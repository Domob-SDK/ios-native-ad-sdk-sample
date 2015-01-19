//
//  XMLParsing.m
//  DMNativeAdDemo

   

#import "XMLParsing.h"

@implementation XMLParsing

- (id)init
{
    if (self = [super init]) {
        
        elementToParse = [[NSArray alloc] initWithObjects:@"title",@"link",@"description",@"author",@"pubDate", nil];
        
    }
    return self;
    
}
- (void) getXML {
    //获取xml
    self.xmlData = [NSMutableData data];

    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURL *url = [NSURL URLWithString:@"http://news.qq.com/newsgn/rss_newsgn.xml"];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];

    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (urlConnection != nil) {
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (!self.getXmlDone);
    }
}

#pragma mark NSURLConnection Delegate methods
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}
// Forward errors to the delegate.
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.getXmlDone = YES;
}
// Called when a chunk of data has been downloaded.
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the downloaded chunk of data.
    [self.xmlData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    self.getXmlDone = YES;
    NSXMLParser *m_parser = [[NSXMLParser alloc] initWithData:self.xmlData];
    //设置该类本身为代理类，即该类在声明时要实现NSXMLParserDelegate委托协议
    [m_parser setDelegate:self];  //设置代理为本地
    
    BOOL flag = [m_parser parse]; //开始解析
    if(flag) {

        if ([self.delegate respondsToSelector:@selector(parsingSuccessfulWithArray:)]) {
            [self.delegate parsingSuccessfulWithArray:itemsArray];
        }
    }
    else {

    }

}

- (NSArray *)xmlDataArray
{
    return itemsArray;
}


#pragma mark NSXMLParserDelegate
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if([elementName isEqualToString:@"channel"]) {

        itemsArray = [[NSMutableArray alloc] init];
    }
    else if([elementName isEqualToString:@"item"]) {
    
        aItem = [[ModelItem alloc] init];
        
    }
    storingFlag = [elementToParse containsObject:elementName];  //判断是否存在要存储的对象
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // 当用于存储当前元素的值是空时，则先用值进行初始化赋值
    // 否则就直接追加信息
    if (storingFlag) {
        if (!currentElementValue) {
            currentElementValue = [[NSMutableString alloc] initWithString:string];
        }
        else {
            [currentElementValue appendString:string];
        }
    }
    
}

// 这里才是真正完成整个解析并保存数据的最终结果的地方
- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if (storingFlag) {
        //去掉字符串的空格
        NSString *trimmedString = [currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //将字符串置空
        [currentElementValue setString:@""];
        
        if ([elementName isEqualToString:@"title"]) {
            aItem.titleItem = trimmedString;
        }
        if ([elementName isEqualToString:@"link"]) {
            aItem.linkItem = trimmedString;
        }
        if ([elementName isEqualToString:@"description"]) {
            aItem.descriptionItem = trimmedString;
        }
        if ([elementName isEqualToString:@"author"]) {
            aItem.authorItem = trimmedString;
        }
        if ([elementName isEqualToString:@"pubDate"]) {
            aItem.pubDate = trimmedString;
            aItem.isNativeAd = NO;
            [itemsArray addObject:aItem];
        }
        
        
    }
    
}

@end
