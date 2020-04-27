//import Foundation
//
//public class FormDataEncoder {
//    func encode(_ value: Encodable) throws -> Data {
//        let encoder = _FormDataEncoder()
//        try value.encode(to: encoder)
//        return encoder.data
//    }
//}
//
//final class _FormDataEncoder {
//    var codingPath: [CodingKey] = []
//    
//    var userInfo: [CodingUserInfoKey : Any] = [:]
//    
//    fileprivate var container: FormDataEncodingContainer?
//}
//
//extension _FormDataEncoder: Encoder {
//    fileprivate func assertCanCreateContainer() {
//        precondition(self.container == nil)
//    }
//    
//    func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
//        assertCanCreateContainer()
//        
//        let container = KeyedContainer<Key>(codingPath: self.codingPath, userInfo: self.userInfo)
//        self.container = container
//        
//        return KeyedEncodingContainer(container)
//    }
//    
//    func unkeyedContainer() -> UnkeyedEncodingContainer {
//        assertCanCreateContainer()
//        
//        let container = UnkeyedContainer(codingPath: self.codingPath, userInfo: self.userInfo)
//        self.container = container
//        
//        return container
//    }
//    
//    func singleValueContainer() -> SingleValueEncodingContainer {
//        assertCanCreateContainer()
//        
//        let container = SingleValueContainer(codingPath: self.codingPath, userInfo: self.userInfo)
//        self.container = container
//        
//        return container
//    }
//}
//
//protocol FormDataEncodingContainer: class {
//    
//}
