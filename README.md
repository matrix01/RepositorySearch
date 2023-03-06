# RepositorySearch
### Sample project to demonstrate Github Repository using MVVM architecture.

This project only demostrate fetching user data from api.github.com.
1. https://api.github.com/search/repositories

### How to run the project
1. Open `"RepositorySearch.xcodeproj"` from project directory
2. Build & Run project using the play button in XCODE or `CMD + R`
3. To do some basic unit test, please run the test files using `CMD + U`

### Requirements
1. Project was done in XCODE 14.4 (Please update if the xcode version is lower than this)
2. iOS device//Simulator running iOS 15.0 is selected as min version

## Retrospective
Completed the minimum specification and few from additional specification.

### Architecture
The project is based on `MVVM` architecture with a navigator to navigate through scenes.

Folder Structure:

RepositorySearch
<ul>
  <li>Network</li>
  <li>Screens</li>
    <ul>
      <li>DetailScreen</li>
        <ul>
          <li>DetailView</li>
          <li>DetailViewModel</li>
        </ul>
      <li>SearchScreen</li>
        <ul>
          <li>APIServices</li>
          <li>SearchView</li>
          <li>SearchViewModel</li>
        </ul>
    </ul>
  <li>Models</li>
  <li>Utils</li>
  <li>Resources</li>
  <li>Application</li>
  <li>SupportingFiles</li>
</ul>

RepositorySearchTests
<ul>
  <li>Fixture</li>
  <li>Mock</li>
  <li>SearchScreenTests</li>
</ul>

RepositorySearchUITests
<ul>
  <li>RepositorySearchUITests</li>
  <li>DetailViewUITests</li>
</ul>

### Things I would like to improve:
* Current project cover 100% for API services and more than 80% for view model tests. Possible to make 100%
* Coverage for UI tests 100%
* Use input/output use cases for ViewModel <-> UI binding

## Thank you and happy coding
