import Foundation

class Item: Codable{
    var title: String
    var done: Bool
    init(title: String, done: Bool) {
        self.title = title
        self.done = done 
    }
}
