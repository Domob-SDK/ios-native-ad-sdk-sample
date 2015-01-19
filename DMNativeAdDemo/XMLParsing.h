//
//  XMLParsing.h
//  DMNativeAdDemo

   

#import <Foundation/Foundation.h>
#import "ModelItem.h"

@protocol XMLParsingDelegate <NSObject>

- (void) parsingSuccessfulWithArray:(NSArray *)array;

- (void) parsingError;

@end
@interface XMLParsing : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentElementValue;  //用于存储元素标签的值
    
    NSMutableArray *itemsArray;
    
    ModelItem *aItem;  //一个节点
    
    BOOL storingFlag; //查询标签所对应的元素是否存在
    
    NSArray *elementToParse;  //要存储的元素

}

@property (nonatomic, assign) BOOL getXmlDone;
@property (nonatomic, strong) NSMutableData *xmlData;
@property (nonatomic, weak) id<XMLParsingDelegate>delegate;

- (void) getXML;

@end
