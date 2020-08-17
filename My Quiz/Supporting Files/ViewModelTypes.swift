//
//  ViewModelTypes.swift
//  My Quiz
//
//  Created by Mihails Kuznecovs on 15/08/2020.
//  Copyright © 2020 Mihails Kuznecovs. All rights reserved.
//

import Foundation

protocol TableViewViewModelType {
    var numberOfRows: Int { get }
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CellViewModelType?
}

protocol CellViewModelType {}
