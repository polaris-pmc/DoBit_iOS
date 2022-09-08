//
//  CalendarViewModel.swift
//  DoBit
//
//  Created by 서민주 on 2021/07/22.
//

import Foundation

class CalendarViewModel: NSObject {
    @IBOutlet weak var repository: CalendarRepository!
    
    private var checkedDateList: [[Date]] = []
    private var tableCellDataList: [ExpendableCellData] = []
    
    func identityCount() -> Int {
        return tableCellDataList.count
    }
    
    func getDates(idx: Int) -> [Date] {
        return checkedDateList[idx]
    }
    
    func getCellData(idx: Int) -> ExpendableCellData {
        return tableCellDataList[idx]
    }
    
    func toggleSection(idx: Int) {
        tableCellDataList[idx].opened = !tableCellDataList[idx].opened
    }
    
    func list(year: Int, month: Int, completed: @escaping () -> Void ) {
        repository.list(params: (year, month)) { [self] graphDatas in

            var dateList: [[Date]] = []
            var dataList: [ExpendableCellData] = []
            for graphData in graphDatas ?? [] {

                let identityName = graphData.userIdentityName
                let identityColor = graphData.userIdentityColor
                
                let cellData = ExpendableCellData(opened: false, title: identityName, color: identityColor, sectionData: graphData.graphDataList)
                
                dataList.append(cellData)
                
                let formattedDateList: [Date] = graphData.checkDateList.map {
                    return DateUtil.shared.formatDateWithDash(year: year, month: month, day: $0)
                }
                
                dateList += [formattedDateList]
            }
            
            self.tableCellDataList = dataList
            self.checkedDateList = dateList
            completed()
        }
    }
}
