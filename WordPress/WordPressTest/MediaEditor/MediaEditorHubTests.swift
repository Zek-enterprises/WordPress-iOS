import XCTest
import Nimble

@testable import WordPress

class MediaEditorHubTests: XCTestCase {

    func testInitializeFromStoryboard() {
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        expect(hub).toNot(beNil())
    }

    func testShowImage() {
        let hub: MediaEditorHub = MediaEditorHub.initialize()
        _ = hub.view
        let image = UIImage()

        hub.show(image: image)

        expect(hub.imageView.image).to(equal(image))
    }

    func testTappingCancelButtonCallsOnCancel() {
        var didCallOnCancel = false
        let hub: MediaEditorHub = MediaEditorHub.initialize()
        _ = hub.view
        hub.onCancel = {
            didCallOnCancel = true
        }

        hub.cancelButton.sendActions(for: .touchUpInside)

        expect(didCallOnCancel).to(beTrue())
    }

    func testApplyStyles() {
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        hub.apply(styles: [.cancelLabel: "foo"])

        expect(hub.cancelButton.titleLabel?.text).to(equal("foo"))
    }

    func testHideActivityIndicatorView() {
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        _ = hub.view

        expect(hub.activityIndicatorView.isHidden).to(beTrue())
    }

    func testApplyLoadingLabel() {
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        hub.apply(styles: [.loadingLabel: "foo"])

        expect(hub.activityIndicatorLabel.text).to(equal("foo"))
    }

    func testWhenInPortraitShowTheCorrectToolbarAndConstraints() {
        XCUIDevice.shared.orientation = .portrait
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        hub.loadViewIfNeeded()

        expect(hub.horizontalToolbar.isHidden).to(beFalse())
        expect(hub.verticalToolbar.isHidden).to(beTrue())
        expect(hub.portraitConstraints.allSatisfy { $0.isActive }).to(beTrue())
        expect(hub.landscapeConstraints.allSatisfy { !$0.isActive }).to(beTrue())
    }

    func testWhenInLandscapeShowTheCorrectToolbarAndConstraints() {
        XCUIDevice.shared.orientation = .landscapeLeft
        let hub: MediaEditorHub = MediaEditorHub.initialize()

        hub.loadViewIfNeeded()

        expect(hub.horizontalToolbar.isHidden).to(beTrue())
        expect(hub.verticalToolbar.isHidden).to(beFalse())
        expect(hub.portraitConstraints.allSatisfy { !$0.isActive }).to(beTrue())
        expect(hub.landscapeConstraints.allSatisfy { $0.isActive }).to(beTrue())
    }

}