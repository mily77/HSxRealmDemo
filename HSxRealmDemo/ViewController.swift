//
//  ViewController.swift
//  HSxRealmDemo
//
//  Created by emily on 2018/6/28.
//  Copyright © 2018年 emily. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        testInsterStudent()
        //        testInsertStudentWithPhotoBook()
        //        testInsertManyStudent()
        //  查询数据库中所有学生模型并输出姓名，图片，所拥有的书信息
        //        let stus = HSxStudentRealmTool.getStudents()
        //        for stu in stus {
        //            print(stu.name)
        //
        //            if stu.books.count > 0 {
        //                for book in stu.books {
        //                    print(book.name + "+" + book.author)
        //                }
        //            }
        //        }
        //
        //        //通过主键查询
        //        let student = HSxStudentRealmTool.getStudent(from: 25)
        //        if let studentL = student {
        //            print(studentL.name)
        //        }
        //
        //        // 条件查询
        //        let students = HSxStudentRealmTool.getStudentByTerm("name = '嘻嘻_10'")
        //        if students.count == 0 {
        //            print("未查询到任何数据")
        //            return
        //        }
        //        for student in students {
        //            print(student.name,student.weight)
        //        }
        
        
    }
    
    func testInsterStudent() {
        let stu = Student()
        stu.name = "颂曦"
        stu.age = 18
        stu.id = 1
        let birthdayStr = "1993-12-24"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
        
        stu.weight = 90
        stu.address = "南山区"
        
        HSxStudentRealmTool.insertStudent(by: stu)
    }
    
    func testInsertStudentWithPhotoBook() {
        
        
        
        let stu = Student()
        stu.name = "曦_有书"
        stu.weight = 89
        stu.age = 26
        stu.id = 2
        // 头像
        //        stu.setPhotoWitName("cat")
        
        let bookHeben = Book.init(name: "奥黛丽.赫本传", author: "艾米")
        let bookTujieHTTP = Book.init(name: "图解HTTP", author: "上野宣")
        let bookNiupengzhayi = Book.init(name: "牛棚杂忆", author: "季羡林")
        
        stu.books.append(bookHeben)
        stu.books.append(bookTujieHTTP)
        stu.books.append(bookNiupengzhayi)
        
        HSxStudentRealmTool.insertStudent(by: stu)
        
    }
    func testInsertManyStudent() {
        var stus = [Student]()
        
        for i in 24...30 {
            let stu = Student()
            stu.name = "嘻嘻_\(i)"
            stu.weight = i+70;
            stu.age = i+10
            stu.id = i;
            // 头像
            //            stu.setPhotoWitName("cat")
            let birthdayStr = "1993-06-10"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            stu.birthday = dateFormatter.date(from: birthdayStr)! as NSDate
            stus.append(stu)
        }
        
        HSxStudentRealmTool.insertStudents(by: stus)
    }
    
    /// 批量更改
    func testUpdateStudents() {
        var stus = [Student]()
        for i in 17...24 {
            let stu = Student()
            stu.name = "嘻嘻改名_\(i)"
            stu.weight = 148;
            stu.age = 27
            stu.id = i;
            stus.append(stu)
        }
        HSxStudentRealmTool.updateStudent(students: stus)
    }
    /// 批量更改年龄
    func testUpdateStudentAge() {
        HSxStudentRealmTool.updateStudentAge(age: 18)
    }
    
    // 删除某ID
    func testDeleteOneStudent() {
        let stu = HSxStudentRealmTool.getStudent(from: 3)
        if stu != nil {
            HSxStudentRealmTool.deleteStudent(student: stu!)
        }
    }
    /// 删除所有
    func testDeleteAllStudent() {
        let stus = HSxStudentRealmTool.getStudents()
        HSxStudentRealmTool.deleteStudent(students: stus)
    }
}

