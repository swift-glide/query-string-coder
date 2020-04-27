import Foundation

extension DictionaryDecoder {
  final class SingleValueContainer {
    var codingPath: [CodingKey]
    var userInfo: [CodingUserInfoKey: Any]

    init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
      self.codingPath = codingPath
      self.userInfo = userInfo
    }
  }
}

extension DictionaryDecoder.SingleValueContainer: SingleValueDecodingContainer {
  private func expectNonNull<T>(_ type: T.Type) throws {
    guard !self.decodeNil() else {
      throw DecodingError.valueNotFound(
        type,
        DecodingError.Context(
          codingPath: self.codingPath,
          debugDescription: "Expected \(type) but found null value instead."
        )
      )
    }
  }
  
  func decodeNil() -> Bool {
    return false
  }
  
  func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
    throw DecodingError.dataCorrupted(.init(codingPath: self.codingPath, debugDescription: "Not supported."))
  }
}

extension DictionaryDecoder.SingleValueContainer: FormDataDecodingContainer {}
