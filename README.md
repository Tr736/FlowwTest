Floww Take-Home Task

### Design Pattern
The design pattern used is MVVM.

### Dependency Manager and 3rd-Party Frameworks
The dependency manager used is SPM. The third-party frameworks used are Nuke & NukeUI to improve performance by managing cache and increasing scroll performance on listviews, and SwiftUICharts for charting to save time.

### Error Handling
Error handling is currently lacking. In case of an error, it either prints to the log or fails silently. Better error handling, including retries and user notifications, is desired. The app's heavy dependence on network also calls for better monitoring of reachability and the ability to show full-screen errors or fall back on local cache.

Cache
A cache system is desired to reduce server load and improve responsiveness, but this will be added later.

Tests
The author places great importance on tests but due to time constraints, some tests have been omitted. Mocks have been added to the main target for use in SwiftUI Previews, rather than in the test target. A data provider testing system using local JSON files and view model tests are planned for the future. UITests should only be run on a local network, so the data provider work should be completed first. You can see the author's past work on UITests, data provider and view model tests at the following link: https://github.com/Tr736/ClearScoreTest.
