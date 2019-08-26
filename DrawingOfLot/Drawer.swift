//
//  Randomizer.swift
//  DrawingOfLot
//
//  Created by Rémi Caroff on 21/08/2019.
//  Copyright © 2019 Rémi Caroff. All rights reserved.
//

import Foundation

final class Drawer {
  private var initialKeys: [Person] = []
  private var availableValues: [Person] = []
  private var result: [Person] = []
  
  func draw(_ persons: [Person]) -> [Person] {
    
    initialKeys = persons.map { $0 }
    availableValues = persons.map { $0 }
    initialKeys.forEach { person in
      getAvailableValue(for: person) { val in
        person.receiver = val
        self.result.append(person)
      }
    }
    
    return result
  }
  
  func getAvailableValue(for person: Person, _ completion: @escaping (String) -> Void) {
    
    let randomKeyIndex = Int(arc4random_uniform(UInt32(self.availableValues.count)))
    let toAdd = self.availableValues[randomKeyIndex]
    let futureIndex = self.result.count
    guard toAdd.name != self.initialKeys[futureIndex].name, // On vérifie que la personne à ajouter n'est pas la même que l'autre
      toAdd.name != self.initialKeys[futureIndex].joint // On vérifie que la personne à ajouter n'est pas en couple avec l'autre
      else {
        let lastCount = self.initialKeys.count - self.result.count
        
        if lastCount == 1 {
          self.exchangeForLast(toAdd: toAdd, completion)
          return
        }
        
        if lastCount == 2 && availableValues.first!.name == availableValues.last!.joint {
          if initialKeys.count > 2 {
            self.exchangeForLast(toAdd: toAdd, completion)
          }
          return
        }
        
        self.getAvailableValue(for: person, completion)
        return
    }
    
    completion(toAdd.name)
    self.availableValues.remove(at: randomKeyIndex)
  }
  
  func exchangeForLast(toAdd: Person, _ completion: (String) -> Void) {
    
    let rndIdx = Int(arc4random_uniform(UInt32(result.count)))
    let toExchange = result[rndIdx]
    guard toExchange.receiver != toAdd.joint, toExchange.receiver != toAdd.name,
      toExchange.name != toAdd.name, toExchange.joint != toAdd.name else  {
      exchangeForLast(toAdd: toAdd, completion)
      return
    }
    
    let valueToExchange = toExchange.receiver
    result.remove(at: rndIdx)
    toExchange.receiver = toAdd.name
    self.result.insert(toExchange, at: rndIdx)
    
    completion(valueToExchange)
  }
}
