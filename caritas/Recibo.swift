//
//  Recibo.swift
//  caritas
//
//  Created by Alumno on 05/09/23.
//

import Foundation

struct ticketote: Codable{
    var tickets: [ticket]
}

struct ticket: Codable, Identifiable{
    var uuid, housingReference, receiptComments, reprogramationComments, housePhoneNumber, cellPhone, collectorComments, state, date, donorName, street, municipality, suburb: String
    var id, managerId, collectorId, donationAmount, houseNumber: Int
}

struct User: Codable, Identifiable{
    var id: String
    var rol: String
}

struct Collector: Codable, Identifiable{
    var fullname, username, uuid: String
    var id, managerId: Int
    var tickets: [ticket]
}

struct Manager: Codable {
    var collectors: [Collector]
}

