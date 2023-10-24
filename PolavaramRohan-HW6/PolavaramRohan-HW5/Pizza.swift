// Project: PolavaramRohan-HW5
// EID: rp34586
// Course: CS329E
//  Pizza.swift
//  PolavaramRohan-HW5
//
//  Created by Rohan Polavaram on 10/12/23.
//

import Foundation
class Pizza {
    var pSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String

    init(pSize: String, crust: String, cheese: String, meat: String, veggies: String) {
        self.pSize = pSize
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
}
