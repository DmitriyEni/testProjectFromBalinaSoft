//
//  Profile.swift
//  TestProject
//
//  Created by Dmitriy Eni on 24.08.2022.
/*
 Необходимо сделать НАТИВНОЕ приложение под iOS со следующим функционалом:
 - Один экран со списком (Элементы списка получить с сервера
 GET-запросом, подгружать при прокрутке)
 - Нажатие на любой элемент списка должно открывать камеру
 - Когда снимок сделан - отправляется POST-запрос на сервер с
 идентификатором нажатого элемента, ФИО разработчика и фото с камеры
 */

import Foundation
import ObjectMapper

class Content: Mappable {
    var content = [Profile]()
    var totalPages = 0
    var totalElements = 0
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        content               <- map["content"]
        totalPages            <- map["totalPages"]
        totalElements         <- map["totalElements"]
    }
}

class Profile: Mappable {
    var id = 0
    var name = ""
    var image: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id        <- map["id"]
        name      <- map["name"]
        image     <- map["image"]
    }
}
