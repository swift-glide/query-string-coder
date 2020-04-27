import Foundation
import Glide

extension StringKeyValueDecoder {
  final class KeyedContainer<Key> where Key: CodingKey {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]
    let data: [String: String]

    init(data: [String: String], codingPath: [CodingKey], userInfo: [CodingUserInfoKey: Any]) {
      self.codingPath = codingPath
      self.userInfo = userInfo
      self.data = data
    }
  }
}

extension StringKeyValueDecoder.KeyedContainer: KeyedDecodingContainerProtocol {
  var allKeys: [Key] {
    data.keys.compactMap { Key(stringValue: String($0)) }
  }

  func contains(_ key: Key) -> Bool {
    data[key.stringValue] != nil
  }

  func decodeNil(forKey key: Key) throws -> Bool {
    data[key.stringValue] == nil
  }

  func decode<T>(_ type: T.Type, forKey key: Key) throws -> T where T: Decodable {
    guard let value = data[key.stringValue] else {
      throw DecodingError.valueNotFound(T.self, at: self.codingPath + [key])
    }

    if let parameterType = T.self as? ParameterRepresentable.Type {
      if let result = parameterType.init(value) as? T {
        return result
      } else {
        throw DecodingError.typeMismatch(T.self, at: self.codingPath + [key])
      }
    } else {
      throw DecodingError.valueNotFound(T.self, at: self.codingPath + [key])
    }
  }

  func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath + [key], debugDescription: "Not supported."))
  }

  func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath + [key], debugDescription: "Not supported."))
  }

  func superDecoder() throws -> Decoder {
    StringKeyValueDecoder(data: data)
  }

  func superDecoder(forKey key: Key) throws -> Decoder {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath + [key], debugDescription: "Not supported."))
  }
}

extension StringKeyValueDecoder.KeyedContainer: FormDataDecodingContainer {}

extension DecodingError {
  static func typeMismatch(_ type: Any.Type, at path: [CodingKey]) -> DecodingError {
    let pathString = path.map { $0.stringValue }.joined(separator: ".")

    let context = DecodingError.Context(
      codingPath: path,
      debugDescription: "Data found at '\(pathString)' was not \(type)"
    )
    return Swift.DecodingError.typeMismatch(type, context)
  }

  static func valueNotFound(_ type: Any.Type, at path: [CodingKey]) -> DecodingError {
    let pathString = path.map { $0.stringValue }.joined(separator: ".")

    let context = DecodingError.Context(
      codingPath: path,
      debugDescription: "No \(type) was found at '\(pathString)'"
    )
    
    return Swift.DecodingError.valueNotFound(type, context)
  }
}
