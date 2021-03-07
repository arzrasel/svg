# svg
svg


[Python Practice Problems: Get Ready for Your Next Interview – Real Python - realpython.com](https://realpython.com/python-practice-problems/)

[GitHub - Markdown Tables generator - TablesGenerator.com](https://www.tablesgenerator.com/markdown_tables)

[How to print call stack in Swift?](https://stackoverflow.com/questions/30754796/how-to-print-call-stack-in-swift/30814498)

[Understanding Result Type in Swift 5 with Daniel Steinberg](https://www.avanderlee.com/swift/result-enum-type/)
[Understanding the Result Type in Swift](https://www.andyibanez.com/posts/swift-result-type/)
[Result Type in Swift](https://mobikul.com/result-type-in-swift/)



//class ManagedBuffer<Header, Element>
enum MultiValue: Codable {
    struct Key: CodingKey, Hashable, CustomStringConvertible {
        var description: String {
            return stringValue
        }

        let stringValue: String
        init(_ string: String) { self.stringValue = string }
        init?(stringValue: String) { self.init(stringValue) }
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    case string(String)
    case number(Double)
    case object([Key: MultiValue])
    case array([MultiValue])
    case bool(Bool)
    case null
    init(from decoder: Decoder) throws {
        if let string = try? decoder.singleValueContainer().decode(String.self) { self = .string(string) }
        else if let number = try? decoder.singleValueContainer().decode(Double.self) { self = .number(number) }
        else if let object = try? decoder.container(keyedBy: Key.self) {
            var result: [Key: MultiValue] = [:]
            for key in object.allKeys {
                result[key] = (try? object.decode(MultiValue.self, forKey: key)) ?? .null
            }
            self = .object(result)
        }
        else if var array = try? decoder.unkeyedContainer() {
            var result: [MultiValue] = []
            for _ in 0..<(array.count ?? 0) {
                result.append(try array.decode(MultiValue.self))
            }
            self = .array(result)
        }
        else if let bool = try? decoder.singleValueContainer().decode(Bool.self) { self = .bool(bool) }
        else if let isNull = try? decoder.singleValueContainer().decodeNil(), isNull { self = .null }
        else { throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Unknown MultiValue type")) }
    }
    func encode(to encoder: Encoder) throws {
        switch self {
        case .string(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .number(let number):
            var container = encoder.singleValueContainer()
            try container.encode(number)
        case .bool(let bool):
            var container = encoder.singleValueContainer()
            try container.encode(bool)
        case .object(let object):
            var container = encoder.container(keyedBy: Key.self)
            for (key, value) in object {
                try container.encode(value, forKey: key)
            }
        case .array(let array):
            var container = encoder.unkeyedContainer()
            for value in array {
                try container.encode(value)
            }
        case .null:
            var container = encoder.singleValueContainer()
            try container.encodeNil()
        }
        throw MultiValueError.missingValue
    }
    //    init(from decoder: Decoder) throws {
    //        if let int = try? decoder.singleValueContainer().decode(Int.self) {
    //            self = .int(int)
    //            return
    //        }
    //        if let string = try? decoder.singleValueContainer().decode(String.self) {
    //            self = .string(string)
    //            return
    //        }
    //        throw MultiValueError.missingValue
    //    }
    enum MultiValueError:Error {
        case missingValue
    }
    //https://stackoverflow.com/questions/58175721/how-to-encode-struct-in-swift-using-encodable-that-contains-an-already-encoded-v
}
