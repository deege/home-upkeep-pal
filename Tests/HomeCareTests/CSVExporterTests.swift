import XCTest
@testable import HomeCare

final class CSVExporterTests: XCTestCase {
    func testExportTasksProducesHeaderAndRows() {
        let home = HomeEntity(name: "My Home")
        let task = TaskEntity(homeID: home.id, title: "Test", notes: "Hello", frequencyDays: 5, lastDoneAt: nil, nextDueAt: Date())
        let asset = AssetEntity(homeID: home.id, name: "Fridge")
        let exporter = CSVExporter()
        let csv = exporter.exportTasks(home: home, tasks: [task], assets: [asset])
        XCTAssertTrue(csv.contains("HomeName,TaskTitle"))
        XCTAssertTrue(csv.contains("My Home"))
        XCTAssertTrue(csv.contains("Test"))
    }

    func testExportAssetsIncludesCategory() {
        let home = HomeEntity(name: "My Home")
        let asset = AssetEntity(homeID: home.id, name: "Fridge", category: .appliance)
        let exporter = CSVExporter()
        let csv = exporter.exportAssets(home: home, assets: [asset])
        XCTAssertTrue(csv.contains("Appliance") || csv.contains("appliance"))
    }
}
