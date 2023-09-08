//
//  Recibo.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import Foundation
struct Recibo: Codable, Identifiable{
    var userId, id: Int
    var title, body: String
}

struct ticket: Codable, Identifiable{
    var cellPhone, collectorComments, collectorId, date, housePhoneNumber: String
    var housingReference, id, managerId, receiptComments, reprogrammationComments, state: String
    
}
struct User: Codable, Identifiable{
    var id: String
}
