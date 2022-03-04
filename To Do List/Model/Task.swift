//
//  Task.swift
//  To Do List
//
//  Created by Emanuelle Moço on 02/03/22.
//

// Arquivo criado para poder puxar as informacoes do banco de dados


import Foundation

struct Task {
    let id: String
    let descricao: String
    var status: String
    let data: String
    let idUser: String
}
