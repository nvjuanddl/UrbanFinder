import Foundation

struct CitiesListRequest: NetworkRequest {
    typealias Output = [CityResponse]
    
    var url: URL {
        .init(string: "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json")!
    }
    var method: HTTPMethod {
        .get
    }
}
