//
//  HSxStudentRealmTool.swift
//  HSxRealmDemo
//
//  Created by emily on 2018/6/28.
//  Copyright © 2018年 emily. All rights reserved.
//

import UIKit
import RealmSwift

class HSxStudentRealmTool: NSObject {
    private class func getDB() ->Realm {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPath.appending("/defaultDB.realm")
        //传入路径会自动创建数据库
        let defaultRealm = try! Realm(fileURL: URL.init(string: dbPath)!)
        return defaultRealm
    }
}
// MARK:- 增
extension HSxStudentRealmTool {
    /// 保存一个Student
    public class func insertStudent(by student : Student) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(student)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
    /// 保存一些Student
    public class func insertStudents(by students : [Student]) -> Void {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(students)
        }
        print(defaultRealm.configuration.fileURL ?? "")
    }
    
}

/// 查
extension HSxStudentRealmTool {
    /// 获取 所保存的 Student
    public class func getStudents() -> Results<Student> {
        let defaultRealm = self.getDB()
        return defaultRealm.objects(Student.self)
    }
    
    /// 获取 指定id (主键) 的 Student
    public class func getStudent(from id : Int) -> Student? {
        let defaultRealm = self.getDB()
        return defaultRealm.object(ofType: Student.self, forPrimaryKey: id)
    }
    
    /// 获取 指定条件 的 Student
    public class func getStudentByTerm(_ term: String) -> Results<Student> {
        let defaultRealm = self.getDB()
        print(defaultRealm.configuration.fileURL ?? "")
        let predicate = NSPredicate(format: term)
        let results = defaultRealm.objects(Student.self)
        return  results.filter(predicate)
    }
    
    /// 获取 学号升降序 的 Student
    public class func getStudentByIdSorted(_ isAscending: Bool) -> Results<Student> {
        let defaultRealm = self.getDB()
        print(defaultRealm.configuration.fileURL ?? "")
        let results = defaultRealm.objects(Student.self)
        return  results.sorted(byKeyPath: "id", ascending: isAscending)
    }
}

/// 改
extension HSxStudentRealmTool {
    /// 更新单个 Student
    public class func updateStudent(student : Student) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(student, update: true)
        }
    }
    
    /// 更新多个 Student
    public class func updateStudent(students : [Student]) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.add(students, update: true)
        }
    }
    
    /// 更新多个 Student
    public class func updateStudentAge(age : Int) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            let students = defaultRealm.objects(Student.self)
            students.setValue(age, forKey: "age")
        }
    }
    
}

/// 删
extension HSxStudentRealmTool {
    /// 删除单个 Student
    public class func deleteStudent(student : Student) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(student)
        }
    }
    
    /// 删除多个 Student
    public class func deleteStudent(students : Results<Student>) {
        let defaultRealm = self.getDB()
        try! defaultRealm.write {
            defaultRealm.delete(students)
        }
    }
}
// MARK:- 配置
extension HSxStudentRealmTool {
    // 配置数据库
    public class func configRealm() {
        // 如果要存储的数据模型属性发生变化，需要配置当前版本号比之前大
        let dbVersion : UInt64 = 1
        let docPatch = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as String
        let dbPath = docPatch.appending("/defaultDB.realm")
        let config = Realm.Configuration(fileURL: URL.init(string: dbPath), inMemoryIdentifier: nil, syncConfiguration: nil, encryptionKey: nil, readOnly: false, schemaVersion: dbVersion, migrationBlock: { (migration, oldSchemaVersion) in
            migration.enumerateObjects(ofType: Student.className(), { (oldObject, newObject) in
                let name = oldObject!["name"] as! String
                newObject!["groupNmae"] = "哈哈\(name)"
                
            })
        }, deleteRealmIfMigrationNeeded: false, shouldCompactOnLaunch: nil, objectTypes: nil)
        Realm.Configuration.defaultConfiguration = config
        Realm.asyncOpen { (realm, error) in
            if let _ = realm {
                print("realm 服务器配置成功！")
            }else if let error = error {
                print("realm 数据库配置失败：\(error.localizedDescription)")
            }
        } 
    }
}
