//
//  BodyLocation.swift
//  IntertekForm
//
//  Created by Filip Brej on 1/25/19.
//  Copyright © 2019 Intertek. All rights reserved.
//

import Foundation

// Body Location Model
struct BodyLocation {
    var location: String
    
    static var all: [BodyLocation] {
        return [BodyLocation(location: "Trachea"),
                BodyLocation(location: "Right Bronchus"),
                BodyLocation(location: "Left Bronchus"),
                BodyLocation(location: "Right Lower Lung"),
                BodyLocation(location: "Left Lower Lung"),
                BodyLocation(location: "Oral Cavity"),
                BodyLocation(location: "Nose"),
                BodyLocation(location: "Nasopharynx"),
                BodyLocation(location: "Larynx"),
                BodyLocation(location: "Hypopharynx"),
                BodyLocation(location: "Esophagus"),
                BodyLocation(location: "Stomach"),
                BodyLocation(location: "Bowel"),
                BodyLocation(location: "Rectum")
        ]
    }
}

// Removal Method Model
struct RemovalMethod {
    var method: String
    
    static var all: [RemovalMethod] {
        return [RemovalMethod(method: "Spontaneous"),
                RemovalMethod(method: "After Surgical Intervention"),
                RemovalMethod(method: "Remained in Patient"),
                RemovalMethod(method: "Foley Manipulation"),
                RemovalMethod(method: "Unknown")
        ]
    }
}

// Symptoms Model
struct Symptoms {
    var symptom: String
    
    static var all: [Symptoms] {
        return [Symptoms(symptom: "None"),
                Symptoms(symptom: "Mild"),
                Symptoms(symptom: "Moderate"),
                Symptoms(symptom: "Severe"),
                Symptoms(symptom: "In Extremis")
        ]
    }
}

// Impairment Model
struct Impairments {
    var impairment: String
    
    static var all: [Impairments] {
        return [Impairments(impairment: "No"),
                Impairments(impairment: "Neurologically Impaired"),
                Impairments(impairment: "Mentally Impaired"),
                Impairments(impairment: "Physically Impaired")
        ]
    }
}

// Speech Status Model
enum SpeechStatus {
    case ready
    case recognizing
    case unavailable
}
