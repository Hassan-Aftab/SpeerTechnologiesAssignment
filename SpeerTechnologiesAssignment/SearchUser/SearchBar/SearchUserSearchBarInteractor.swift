//
//  SearchUserSearchBarInteractor.swift
//  SpeerTechnologiesAssignment
//
//  Created by Hassan Aftab on 12/01/2022.
//

import Foundation

protocol SearchUserSearchBarInteractorType {
    var onBeginEditing: (()->())? { get set }
    var onEndEditing: (()->())? { get set }
    var onCancel: (()->())? { get set }
    var onSearchTapped: ((String)->())? { get set }
}

class SearchUserSearchBarInteractor: SearchUserSearchBarInteractorType{
    var onBeginEditing: (()->())?
    var onEndEditing: (()->())?
    var onCancel: (()->())?
    var onSearchTapped: ((String)->())?
}
