import Foundation

extension StringKeyValueDecoder {
    final class UnkeyedContainer {
        var codingPath: [CodingKey]
        var userInfo: [CodingUserInfoKey: Any]
       
        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
            self.codingPath = codingPath
            self.userInfo = userInfo
      }
  }
}

extension StringKeyValueDecoder.UnkeyedContainer: UnkeyedDecodingContainer {
  var count: Int? { nil }

  var isAtEnd: Bool { true }

  var currentIndex: Int { 0 }

  func decodeNil() throws -> Bool {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }

  func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }

  func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }

  func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }

  func superDecoder() throws -> Decoder {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }
}

extension StringKeyValueDecoder.UnkeyedContainer: FormDataDecodingContainer {}
