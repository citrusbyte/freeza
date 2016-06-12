import Foundation

struct EntryModel {

    let title: String?
    let author: String?
    let creation: NSDate?
    let thumbnailURL: NSURL?
    let commentsCount: Int?
    let imageURL: NSURL?
    
    init(withDictionary dictionary: [String: AnyObject]) {
        
        func dateFromDictionary(withAttributeName attribute: String) -> NSDate? {
            
            guard let rawDate = dictionary[attribute] as? Double else {
                
                return nil
            }
            
            return NSDate(timeIntervalSince1970: rawDate)
        }
        
        func urlFromDictionary(withAttributeName attribute: String) -> NSURL? {
            
            guard let rawURL = dictionary[attribute] as? String else {
                
                return nil
            }
            
            return NSURL(string: rawURL)
        }
        
        self.title = dictionary["title"] as? String
        self.author = dictionary["author"] as? String
        self.creation = dateFromDictionary(withAttributeName: "created_utc")
        self.thumbnailURL = urlFromDictionary(withAttributeName: "thumbnail")
        self.commentsCount = dictionary["num_comments"] as? Int
        
        if let media = dictionary["media"] as? [String: AnyObject],
            type = media["type"] as? String where type == "i.imgur.com" {
                
            self.imageURL = nil
            
        } else {
        
            self.imageURL = urlFromDictionary(withAttributeName: "url")
        }
    }
}
