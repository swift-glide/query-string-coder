import Foundation
import NIO

public enum FormContent {
  public struct URLEncoded {
    public private(set) var storage = [String: String]()

    static func parse(_ string: String) -> [String: String] {
      let percentEncoded = string.replacingOccurrences(of: "+", with: "%20")
      let pairs: [(Substring, Substring)] = percentEncoded
        .split(separator: "&")
        .map {
          let pair = $0.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
          return (pair[0], pair[1])
        }

      return pairs.reduce([:]) { result, pair in
        var newResult = result
        newResult[String(pair.0)] = pair.1.removingPercentEncoding ?? String(pair.1)
        return newResult
      }
    }
  }
}

extension FormContent.URLEncoded: ExpressibleByStringLiteral {
  public init(_ string: String) {
    self = .init(storage: FormContent.URLEncoded.parse(string))
  }

  public init(stringLiteral: String) {
    self = .init(storage: FormContent.URLEncoded.parse(stringLiteral))
  }
}

public final class FormDataDecoder {
  public func decode<T>(
    _ decodable: T.Type,
    from body: ByteBuffer
  ) throws -> T where T: Decodable {
    let string = body.getString(at: body.readerIndex, length: body.readableBytes) ?? ""
    let formContent = FormContent.URLEncoded(string)

    let decoder = StringKeyValueDecoder(data: formContent.storage)
    return try T(from: decoder)
  }

  public func decode<T>(
    _ decodable: T.Type,
    from data: Data
  ) throws -> T where T: Decodable {
    let string = String(data: data, encoding: .utf8)!
    let formContent = FormContent.URLEncoded(string)

    let decoder = StringKeyValueDecoder(data: formContent.storage)
    return try T(from: decoder)
  }
}

final class StringKeyValueDecoder {
  var codingPath: [CodingKey] = []
  var userInfo: [CodingUserInfoKey: Any] = [:]

  var container: FormDataDecodingContainer?
  fileprivate var data: [String: String]

  init(data: [String: String]) {
    self.data = data
  }
}

extension StringKeyValueDecoder: Decoder {
  fileprivate func assertCanCreateContainer() {
    precondition(container == nil)
  }

  func container<Key>(keyedBy _: Key.Type) -> KeyedDecodingContainer<Key> where Key: CodingKey {
    assertCanCreateContainer()

    let container = KeyedContainer<Key>(data: data, codingPath: codingPath, userInfo: userInfo)
    self.container = container

    return KeyedDecodingContainer(container)
  }

  func unkeyedContainer() -> UnkeyedDecodingContainer {
    fatalError("Not supported")
  }

  func singleValueContainer() -> SingleValueDecodingContainer {
    fatalError("Not supported")
  }
}

protocol FormDataDecodingContainer: class {}
