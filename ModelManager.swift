//
//  ModelManager.swift
//  mini-hack
//
//  Created by Admin on 9/19/16.
//  Copyright © 2016 Admin. All rights reserved.
//

class ModelManager {
    static let sharedInstance = ModelManager()
    
    static var pokemon = [Pokemon]()
    //    var database : AnyObject
    
    var database = FMDatabase(path: Database.getPath("pokemon.db"))
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Database.getPath("pokemon.db"))
        }
        ModelManager.sharedInstance.getAllStudentData()
        return sharedInstance
    }
    
    
    
    
    func getAllStudentData() {
        ModelManager.sharedInstance.database!.open()
        let resultSet: FMResultSet! = ModelManager.sharedInstance.database!.executeQuery("SELECT * FROM pokemon", withArgumentsInArray: nil)
        
        if (resultSet != nil) {
            while resultSet.next() {
                let pokemon = Pokemon()
                pokemon.id = Int(resultSet.intForColumn("id"))
                pokemon.name = resultSet.stringForColumn("name")
                pokemon.tag = resultSet.stringForColumn("tag")
                pokemon.color = resultSet.stringForColumn("color")
                pokemon.gen = Int(resultSet.intForColumn("gen"))
                pokemon.img = resultSet.stringForColumn("img")
                ModelManager.pokemon.append(pokemon)
                
            }
        }
        ModelManager.sharedInstance.database!.close()
    }

}
