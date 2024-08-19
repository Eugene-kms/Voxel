import UIKit
import FirebaseDatabase
import VoxelAuthentication
import VoxelSettings
import Swinject

public protocol ContactsRepository {
    func fetch() async throws -> [Contact]
    func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws
    func updateContact(_ contact: Contact, with fullName: String) async throws
    func fetchContact(with uid: String) async throws -> Contact
}

enum ContactsRepositoryError: Error {
    case contactNotRegistered
}

public struct ContactRelationship: Decodable {
    let name: String
}

public class ContactsRepositoryLive: ContactsRepository {
    
    private let reference: DatabaseReference
    private let phoneNumberReference: DatabaseReference
    private let userReference: DatabaseReference
    private let authService: AuthService
    
    public init(container: Container) {
        reference = Database.database().reference().child("contacts")
        phoneNumberReference = Database.database().reference().child(DatabaseBranch.phoneNumbers.rawValue)
        userReference = Database.database().reference().child("users")
        authService = container.resolve(AuthService.self)!
    }
    
    public func fetch() async throws -> [Contact] {
        
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        let snapshot = try await reference.child(user.uid).getData()
        let contacts = try snapshot.data(as: [String: ContactRelationship].self)
        
        var contactsArray = [Contact]()
        
        try await withThrowingTaskGroup(of: Contact.self) { [unowned self] group in
            for (contactUid, contactRel) in contacts {
                group.addTask {
                    let profile = try await self.fetchProfile(with: contactUid)
                    let isMutual = try await self.isContactMutual(contactUid)
                    return Contact(
                        uid: contactUid,
                        name: contactRel.name,
                        userProfile: profile, 
                        isMutual: isMutual
                    )
                }
            }
            
            for try await contact in group {
                contactsArray.append(contact)
            }
        }
        
        return contactsArray
    }
    
    private func fetchProfile(with uid: String) async throws -> UserProfile {
        let snapshot = try await userReference.child(uid).getData()
        return try snapshot.data(as: UserProfile.self)
    }
    
    public func fetchContact(with uid: String) async throws -> Contact {
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        let profile = try await fetchProfile(with: uid)
        let snapshot = try await reference.child(user.uid).child(uid).getData()
        let contactRel = try snapshot.data(as: ContactRelationship.self)
        let isMutual = try await isContactMutual(uid)
        
        return Contact(
            uid: uid,
            name: contactRel.name,
            userProfile: profile,
            isMutual: isMutual
        )
    }
    
    private func isContactMutual(_ uid: String) async throws -> Bool {
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        let snapshot = try await  reference.child(uid).child(user.uid).getData()
        return snapshot.exists()
    }
    
    public func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws {
        
        let snapshot = try await phoneNumberReference.child(phoneNumber).getData()
        
        guard let contactUserId = snapshot.value as? String else {
            throw ContactsRepositoryError.contactNotRegistered
        }
        
        guard let user = authService.user else {
            throw AuthError.noVerificationId
        }
        
        try await reference.child(user.uid).child(contactUserId).setValue([
            "name": fullName
        ])
    }
    
    public func updateContact(_ contact: Contact, with fullName: String) async throws {
        
        guard let user = authService.user else {
            throw AuthError.noVerificationId
        }
        
        try await  reference.child(user.uid).child(contact.uid).child("name").setValue(fullName)
    }
}
