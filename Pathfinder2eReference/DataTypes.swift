//
//  DataTypes.swift
//  Pathfinder2eReference
//
//  Created by bluepill on 20/3/2022.
//

import Foundation

/**
 categorisation of character competency
 */
enum Ability: String, Codable {
    case charisma
    case dexterity
    case intelligence
    case wisdom
}

/**
 amount of learning needed to use a rule
 */
enum Competence: String, Codable {
    case untrained
    case trained
}

/**
 categorisation for similar rules
 */
enum SkillGroup: String, Codable {
    case acrobatics, arcana, athletics, crafting, deception, diplomacy, intimidation, lore, medicine, nature, occultism, performance, religion, society, stealth, survival, thievery
}

/**
 identifier for the type of activity a rule occurs in
 */
enum Behaviour: String, Codable {
    case action
    case activity
    case reaction
    case freeAction = "free action"
}

/**
 what a game rule affects
 */
enum Affect:String, Codable {
    case player
    case others
    case item
    case environment
}

/**
 the game mode a rule runs in
 */
enum Mode: String, Codable {
    case encounter
    case exploration
    case downtime
}

/**
 characteristic of a rule
 */
enum Trait: String, Codable {
    case attack, auditory, concentrate, emotion, healing, linguistic, manipulate, mental, move, secret, visual
}


struct Skill: Codable {
    let name: String // name for the skill
    let skillGroup: SkillGroup // the skill category that the skill depends on
    let keyAbility: Ability // the ability the skill depends on
    let competence: Competence // the amount of learning needed to use the skill
    let type: Behaviour // category of the skill
    let duration: Int // time the skill takes
    let mode: Mode // the game mode the skill is usable in
    let traits: Set<Trait> // collection of traits that apply to the skill
    let requirement: String // explanation of what is required to perform the skill
    let description: String // explanaion of the skill
    let criticalSuccess: String // explanation of the conseqeunces of rolling a critical success
    let success: String // explanation of the conseqeunces of rolling a success
    let failure: String // explanation of the conseqeunces of rolling a failure
    let criticalFailure: String // explanation of the conseqeunces of rolling a critical failure
    let affects: Set<Affect> // what the skill affects
}

struct Skills: Codable {
    let description: String // explanation of what a skills are
    let skills: [Skill] // collection of skills

    /**
     load json data from a project resource file into a new Skills object.  if there is a problem a fatal error is triggered.
     */
    static func load(jsonResource resourceName: String) -> Skills {
        // find the file resource
        guard let fileURL = Bundle.main.url(forResource: resourceName, withExtension: "json")  else {
            fatalError("unable to retrieve \(resourceName).json location")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("unable to read \(resourceName).json contents")
        }
        
        do {
            return try JSONDecoder().decode(Skills.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            fatalError("unable to decode Skills data, data corrupted: context=\(context)")
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("unable to decode Skills data, key not found: key=\(key), context=\(context)")
        } catch DecodingError.typeMismatch(let type, let context) {
            fatalError("unable to decode Skills data, type mismatch: type=\(type), context=\(context)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("unable to decode Skills data, value not found: type=\(type), context=\(context)")
        } catch {
            fatalError("unable to decode Skills data: data fields are invalid")
        }
        
//        guard let skills = try? JSONDecoder().decode(Skills.self, from: data) else {
//            fatalError("unable to decode Conditions data!")
//        }
//
//        return Skills(description: skills.description, skills: skills.skills.sorted(by: { $0.name <= $1.name }))
    }
}

struct Action: Codable {
    let name: String // name for the action
    let type: Behaviour // category of the action
    let duration: Int // time the action takes
    let mode: Mode // the game mode the action is usable in
    let traits: Set<Trait> // collection of traits that apply to the action
    let trigger: String // explanation of what triggers the action
    let requirement: String // explanation of what is required to perform the action
    let description: String // explanaion of the action
    let criticalSuccess: String // explanation of the conseqeunces of rolling a critical success
    let success: String // explanation of the conseqeunces of rolling a success
    let failure: String // explanation of the conseqeunces of rolling a failure
    let criticalFailure: String // explanation of the conseqeunces of rolling a critical failure
    let affects: Set<Affect> // what the action affects
}

struct Actions: Codable {
    let description: String // explanation of what actions are
    let actions: [Action] // collection of actions

    /**
     load json data from a project resource file into a new Actions object.  if there is a problem a fatal error is triggered.
     always returns an alphabetically ordered list of Action; based on Action.name
     */
    static func load(jsonResource resourceName: String) -> Actions {
        // find the file resource
        guard let fileURL = Bundle.main.url(forResource: resourceName, withExtension: "json")  else {
            fatalError("unable to retrieve \(resourceName).json location")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("unable to read \(resourceName).json contents")
        }
        
//        do {
//            return try JSONDecoder().decode(Actions.self, from: data)
//        } catch DecodingError.dataCorrupted(let context) {
//            fatalError("unable to decode Actions data, data corrupted: context=\(context)")
//        } catch DecodingError.keyNotFound(let key, let context) {
//            fatalError("unable to decode Actions data, key not found: key=\(key), context=\(context)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            fatalError("unable to decode Actions data, type mismatch: type=\(type), context=\(context)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            fatalError("unable to decode Actions data, value not found: type=\(type), context=\(context)")
//        } catch {
//            fatalError("unable to decode Actions data: data fields are invalid")
//        }
        
        guard let actions = try? JSONDecoder().decode(Actions.self, from: data) else {
            fatalError("unable to decode Actions data!")
        }
        
        return Actions(description: actions.description, actions: actions.actions.sorted(by: { $0.name <= $1.name }))
    }
}

struct Condition: Codable {
    let name: String // name for the condition
    let description: String // explanation of the condition
    let affects: Set<Affect> // what the condition affects
}

struct Conditions: Codable {
    let description: String // explanation of what conditions are
    let conditions: [Condition] // collection of conditions

    /**
     load json data from a project resource file into a new Conditions object.  if there is a problem a fatal error is triggered.
     */
    static func load(jsonResource resourceName: String) -> Conditions {
        // find the file resource
        guard let fileURL = Bundle.main.url(forResource: resourceName, withExtension: "json")  else {
            fatalError("unable to retrieve \(resourceName).json location")
        }
        guard let data = try? Data(contentsOf: fileURL) else {
            fatalError("unable to read \(resourceName).json contents")
        }
        
//        do {
//            return try JSONDecoder().decode(Conditions.self, from: data)
//        } catch DecodingError.dataCorrupted(let context) {
//            fatalError("unable to decode Conditions data, data corrupted: context=\(context)")
//        } catch DecodingError.keyNotFound(let key, let context) {
//            fatalError("unable to decode Conditions data, key not found: key=\(key), context=\(context)")
//        } catch DecodingError.typeMismatch(let type, let context) {
//            fatalError("unable to decode Conditions data, type mismatch: type=\(type), context=\(context)")
//        } catch DecodingError.valueNotFound(let type, let context) {
//            fatalError("unable to decode Conditions data, value not found: type=\(type), context=\(context)")
//        } catch {
//            fatalError("unable to decode Conditions data: data fields are invalid")
//        }
        
        guard let conditions = try? JSONDecoder().decode(Conditions.self, from: data) else {
            fatalError("unable to decode Conditions data!")
        }
        
        return Conditions(description: conditions.description, conditions: conditions.conditions.sorted(by: { $0.name <= $1.name }))
    }
}
