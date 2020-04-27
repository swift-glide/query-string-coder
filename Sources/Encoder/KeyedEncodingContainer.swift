//import Foundation
//
//extension _FormDataEncoder {
//    final class KeyedContainer<Key> where Key: CodingKey {
//        var codingPath: [CodingKey]
//        var userInfo: [CodingUserInfoKey: Any]
//        
//        init(codingPath: [CodingKey], userInfo: [CodingUserInfoKey : Any]) {
//            self.codingPath = codingPath
//            self.userInfo = userInfo
//        }
//    }
//}
//
//extension _FormDataEncoder.KeyedContainer: KeyedEncodingContainerProtocol {
//    func encodeNil(forKey key: Key) throws {
//        
//    }
//    
//    func encode<T>(_ value: T, forKey key: Key) throws where T : Encodable {
//
//    }
//    
//    func nestedUnkeyedContainer(forKey key: Key) -> UnkeyedEncodingContainer {
//
//    }
//    
//    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
//
//    }
//    
//    func superEncoder() -> Encoder {
//
//    }
//    
//    func superEncoder(forKey key: Key) -> Encoder {
//
//    }
//}
//
//extension _FormDataEncoder.KeyedContainer: FormDataEncodingContainer {}
